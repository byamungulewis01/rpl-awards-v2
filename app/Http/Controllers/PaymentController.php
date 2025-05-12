<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use App\Jobs\SendSmsJob;
use Illuminate\Support\Facades\Log;

use Illuminate\Http\Request;

class PaymentController extends Controller
{
    private function verifySignature(Request $request)
    {
        // Get the X-Paypack-Signature header
        $requestHash = $request->header('X-Paypack-Signature');

        if (!$requestHash) {
            return false;
        }

        // Get your webhook secret key from environment variables
        $secret = env('PAYPACK_WEBHOOK_SIGN_KEY', '');

        // Get the raw request body
        $body = $request->getContent();

        // Calculate the HMAC digest
        $calculatedHash = base64_encode(hash_hmac('sha256', $body, $secret, true));

        // Compare the calculated hash with the request hash
        return hash_equals($calculatedHash, $requestHash);
    }


    public function handleWebhook(Request $request)
    {
        // Get the request data
        $payload = $request->all();

        $kind = $payload['kind'] ?? null;

        $transactionRef = $payload['data']['ref'] ?? null;
        $status = $payload['data']['status'] ?? null;

        // Verify the webhook signature
        if (!$this->verifySignature($request)) {
            return response()->json(['message' => 'Invalid signature'], 401);
        }

        if ($kind === 'transaction:processed' && $status === 'successful') {

            try {
                // Find payment by transaction reference
                $payment = Payment::where('transaction_id', $transactionRef)->first();

                if ($payment) {
                    $payment->update([
                        'status' => 'successful',
                        'payment_details' => $payload
                    ]);

                    // Queue SMS sending
                    $message = "Gutora Umukandida {$payment->candidate->name} mucyiciro ({$payment->category->name}) byagenze neza. \nMurakoze RPL Awards";
                    SendSmsJob::dispatch($payment->phone_number, $message);

                    Log::info('Payment successful via webhook', [
                        'payment_id' => $payment->id,
                        'transaction_id' => $transactionRef
                    ]);
                }
            } catch (\Exception $e) {
                Log::error('Error activating subscription via webhook', [
                    'error' => $e->getMessage(),
                    'ref' => $transactionRef
                ]);
            }
        }

        // Always return a 200 response to acknowledge receipt
        return response()->json(['message' => 'Webhook received']);
    }

    // test sms
    public function test_sms()
    {
        SendSmsJob::dispatch('0785436135', 'Hello, this is a test message');
    }

    private function send_sms($phone, $message)
    {
        SendSmsJob::dispatch($phone, $message);
    }
}
