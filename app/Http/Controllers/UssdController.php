<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Vote;
use App\Models\Payment;
use App\Models\Setting;
use App\Models\Category;
use App\Models\Candidate;
use App\Models\USSDSession;
use Illuminate\Http\Request;
use Paypack\Paypack;

class USSDController extends Controller
{
    // Session expiry time in minutes

    public function index(Request $request)
    {
        $phoneNumber = $request->phoneNumber;
        $text = $request->text;

        // Clear expired sessions
        $this->cleanExpiredSessions();

        // Initial entry point - Empty text or the code itself means first access
        if (empty($text) || $text == "513*001") {
            // Clear any existing session
            USSDSession::where('phone_number', $phoneNumber)->delete();

            // Create new session
            $session = new USSDSession();
            $session->phone_number = $phoneNumber;
            $session->level = 0;
            $session->data = ['inputs' => []];
            $session->last_activity = Carbon::now();
            $session->save();

            $response = $this->home_menu();
        } else {
            // Get existing session or create new one
            $session = USSDSession::where('phone_number', $phoneNumber)->first();

            if (!$session) {
                // Create new session if it doesn't exist
                $session = new USSDSession();
                $session->phone_number = $phoneNumber;
                $session->level = 0;
                $session->data = ['inputs' => []];
            }

            // Add current input to the session
            $sessionData = $session->data;
            $sessionData['inputs'][] = $text;
            $session->data = $sessionData;

            // Increment level
            $session->level += 1;
            $session->last_activity = Carbon::now();
            $session->save();

            // Process based on current level
            switch ($session->level) {
                case 1: // Main Menu Selection (League type)
                    if ($text == "1") {
                        // Men's League
                        $response = $this->getCategoriesList('men');
                    } elseif ($text == "2") {
                        // Women's League
                        $response = $this->getCategoriesList('women');
                    } else {
                        $response = "Invalid selection. Please try again.\n" . $this->home_menu();
                        // Reset session level for retry
                        $session->level = 0;
                        $session->data = ['inputs' => []];
                        $session->save();
                    }
                    break;

                case 2: // Category Selection
                    $inputs = $session->data['inputs'];
                    $leagueType = $inputs[0]; // 1 for men, 2 for women
                    $categoryIndex = $text; // The category index the user selected

                    $leagueTypeString = ($leagueType == '1') ? 'men' : 'women';

                    // Get candidates for the selected category
                    $response = $this->getCandidatesList($categoryIndex, $leagueTypeString);

                    // Store the actual category ID in the session
                    $category = $this->getCategory($categoryIndex, $leagueTypeString);
                    if ($category) {
                        $sessionData = $session->data;
                        $sessionData['category_id'] = $category->id;
                        $session->data = $sessionData;
                        $session->save();
                    }
                    break;

                case 3: // Candidate Selection
                    $inputs = $session->data['inputs'];
                    $leagueType = $inputs[0]; // 1 for men, 2 for women
                    $categoryIndex = $inputs[1]; // Category index
                    $candidateIndex = $text; // Candidate index

                    $leagueTypeString = ($leagueType == '1') ? 'men' : 'women';

                    // Get the actual candidate
                    $candidate = $this->getCandidate($categoryIndex, $candidateIndex, $leagueTypeString);
                    $category = $this->getCategory($categoryIndex, $leagueTypeString);

                    if ($candidate && $category) {
                        // Format phone number by removing '25' prefix if it exists
                        $formattedPhoneNumber = $this->formatPhoneNumber($phoneNumber);

                        // Check if the phone number has already voted in this category
                        $existingVote = Payment::where(function ($query) use ($formattedPhoneNumber) {
                            $query->where('phone_number', $formattedPhoneNumber)
                                ->orWhere('phone_number', '25' . $formattedPhoneNumber);
                        })
                            ->where('category_id', $category->id)
                            ->where('status', 'successful')
                            ->first();

                        if ($existingVote) {
                            $response = "Iyi nimero ya telefoni yamaze gutora muri iki cyiciro.";
                            // Clear session after completion
                            $session->delete();
                        } else {
                            // Store the candidate ID in the session
                            $sessionData = $session->data;
                            $sessionData['candidate_id'] = $candidate->id;
                            $session->data = $sessionData;
                            $session->save();

                            $response = "Enter vote count for " . $candidate->name . ":";
                        }
                    } else {
                        $response = "Invalid candidate selected. Please try again.";
                        // Reset session level for retry
                        $session->level = 1;
                        $session->data = ['inputs' => [$leagueType]];
                        $session->save();
                    }
                    break;

                case 4: // Vote Count Entry
                    $inputs = $session->data['inputs'];
                    $leagueType = $inputs[0]; // 1 for men, 2 for women
                    $categoryIndex = $inputs[1]; // Category index
                    $candidateIndex = $inputs[2]; // Candidate index
                    $voteCount = $text; // Vote count

                    $leagueTypeString = ($leagueType == '1') ? 'men' : 'women';

                    if (!is_numeric($voteCount) || $voteCount < 1) {
                        $response = "Invalid vote count. Please enter a positive number.";
                        // Reset session level for retry
                        $session->level = 3;
                        $session->data = ['inputs' => [$leagueType, $categoryIndex, $candidateIndex]];
                        $session->save();
                    } else {
                        $candidate = $this->getCandidate($categoryIndex, $candidateIndex, $leagueTypeString);
                        $category = $this->getCategory($categoryIndex, $leagueTypeString);

                        if ($candidate && $category) {
                            // Get vote amount from settings
                            $vote_amount = (int) Setting::where('name', 'vote_amount')->first()->value ?? 200;
                            $total_amount = $vote_amount * $voteCount;

                            // Store vote count and amount in session
                            $sessionData = $session->data;
                            $sessionData['vote_count'] = $voteCount;
                            $sessionData['total_amount'] = $total_amount;
                            $session->data = $sessionData;
                            $session->save();

                            $response = "You're about to vote for " . $candidate->name . " in category " . $category->name . ".\n";
                            $response .= "Cost: " . $total_amount . " RWF\n";
                            $response .= "1. Yes\n";
                            $response .= "2. No";
                        } else {
                            $response = "Invalid selection. Please try again.\n" . $this->home_menu();
                            // Reset session
                            $session->level = 0;
                            $session->data = ['inputs' => []];
                            $session->save();
                        }
                    }
                    break;

                case 5: // Confirmation
                    $inputs = $session->data['inputs'];
                    $confirmation = $text; // Confirmation

                    if ($confirmation == "1") { // Yes
                        // Get stored data from session
                        $sessionData = $session->data;
                        $candidateId = $sessionData['candidate_id'] ?? null;
                        $categoryId = $sessionData['category_id'] ?? null;
                        $voteCount = $sessionData['vote_count'] ?? 0;
                        $totalAmount = $sessionData['total_amount'] ?? 0;

                        if ($candidateId && $categoryId) {
                            try {
                                // Initialize Paypack service (would need to be implemented)
                                $paypack = new Paypack();

                                // Format phone number for payment processing
                                $formattedPhoneNumber = $this->formatPhoneNumber($phoneNumber);


                                $paypack = new Paypack();

                                $paypack->config([
                                    'client_id' => env('PAYPACK_CLIENT_ID'),
                                    'client_secret' => env('PAYPACK_CLIENT_SECRET'),
                                ]);

                                $cashin = $paypack->cashIn([
                                    'phone' => $formattedPhoneNumber,
                                    'amount' => $totalAmount,
                                ]);

                                // Format phone number by removing '25' prefix if it exists
                                $formattedPhoneNumber = $this->formatPhoneNumber($phoneNumber);

                                // Create payment record
                                $payment = Payment::create([
                                    'candidate_id' => $candidateId,
                                    'category_id' => $categoryId,
                                    'phone_number' => $formattedPhoneNumber,
                                    'payment_method' => 'mtn', // Default to MTN for USSD
                                    'amount' => $totalAmount,
                                    'votes' => $voteCount,
                                    'status' => 'pending',
                                    'transaction_id' => $cashin['ref'] ?? ('VP' . time() . rand(1000, 9999)),
                                ]);

                                Vote::create([
                                    'candidate_id' => $candidateId,
                                    'payment_id' => $payment->id,
                                ]);

                                $payment->update(['status' => 'initiated']);

                                $response = "Ishyura kugirango ijwi ryawe ryemerwe /n Niba utabonye ubutumwa kanda *182*7*1*PIN# Wishyure";
                            } catch (\Exception $e) {
                                $response = "An error occurred while processing your payment. Please try again later.";
                            }
                        } else {
                            $response = "Error processing your vote. Please try again later.";
                        }
                    } else { // No or invalid
                        $response = "Vote cancelled. Thank you for using our service.";
                    }

                    // Clear session after completion
                    $session->delete();
                    break;

                default:
                    $response = "Session error. " . $this->home_menu();
                    // Reset session
                    $session->level = 0;
                    $session->data = ['inputs' => []];
                    $session->save();
                    break;
            }
        }

        return response($response, 200)
            ->header('Content-Type', 'text/plain')
            ->header('Freeflow', 'FC');
    }

    /**
     * Return the home menu
     */
    private function home_menu()
    {
        $response = "HITAMO AMAKIPE:\n";
        $response .= "1. ABAGABO\n";
        $response .= "2. ABAGORE";
        return $response;
    }

    /**
     * Get the list of categories for the specified league type
     */
    private function getCategoriesList($leagueType)
    {
        $categories = Category::where('league', $leagueType)
            ->where('status', 'active')
            ->get();

        if ($categories->isEmpty()) {
            return "No categories found for this league. Please try again later.";
        }

        $response = "HITAMO ICYICIRO:\n";
        foreach ($categories as $index => $category) {
            $response .= ($index + 1) . ". " . $category->name . "\n";
        }

        return rtrim($response);
    }

    /**
     * Get the list of candidates for the specified category and league type
     */
    private function getCandidatesList($categoryIndex, $leagueType)
    {
        // Get all active categories for this league
        $categories = Category::where('league', $leagueType)
            ->where('status', 'active')
            ->get();

        if ($categories->isEmpty() || !isset($categories[$categoryIndex - 1])) {
            return "Invalid category selected. Please try again.";
        }

        $category = $categories[$categoryIndex - 1];
        $candidates = Candidate::where('category_id', $category->id)
            ->where('status', 'active')
            ->get();

        if ($candidates->isEmpty()) {
            return "No candidates found for this category. Please try again later.";
        }

        $response = "HITAMO UMUKINNYI:\n";
        foreach ($candidates as $index => $candidate) {
            $response .= ($index + 1) . ". " . $candidate->name . "\n";
        }

        return rtrim($response);
    }

    /**
     * Get the category model by index and league type
     */
    private function getCategory($categoryIndex, $leagueType)
    {
        $categories = Category::where('league', $leagueType)
            ->where('status', 'active')
            ->get();

        if ($categories->isEmpty() || !isset($categories[$categoryIndex - 1])) {
            return null;
        }

        return $categories[$categoryIndex - 1];
    }

    /**
     * Get the candidate model by category index, candidate index and league type
     */
    private function getCandidate($categoryIndex, $candidateIndex, $leagueType)
    {
        $category = $this->getCategory($categoryIndex, $leagueType);

        if (!$category) {
            return null;
        }

        $candidates = Candidate::where('category_id', $category->id)
            ->where('status', 'active')
            ->get();

        if ($candidates->isEmpty() || !isset($candidates[$candidateIndex - 1])) {
            return null;
        }

        return $candidates[$candidateIndex - 1];
    }

    /**
     * Clean expired sessions
     */
    private function cleanExpiredSessions()
    {
        $expiryTime = Carbon::now()->subMinutes(15);
        USSDSession::where('last_activity', '<', $expiryTime)->delete();
    }

    /**
     * Format phone number by removing '25' prefix if it exists
     *
     * @param string $phoneNumber
     * @return string
     */
    private function formatPhoneNumber($phoneNumber)
    {
        // If phone number starts with '25', remove it
        if (substr($phoneNumber, 0, 2) === '25') {
            return substr($phoneNumber, 2);
        }

        return $phoneNumber;
    }
}