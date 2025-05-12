<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class SendSmsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $phone;
    protected $message;

    /**
     * Create a new job instance.
     */
    public function __construct($phone, $message)
    {
        $this->phone = $phone;
        $this->message = $message;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        try {
            // API endpoint
            $url = 'https://afrobulksms.com/api/sent/compose';

            // API parameters
            $fields = array(
                'api_key' => env('SMS_API_KEY'),
                'from_number' => 8,
                'from_type' => 'sender_id',
                'sender_id' => 'IPOSITA',
                'to_numbers' => '+25' . $this->phone,
                'body' => $this->message,
            );

            // Initialize cURL session
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($fields));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            $response = curl_exec($ch);

            if (curl_errno($ch)) {
                Log::error('SMS sending failed', [
                    'error' => curl_error($ch),
                    'phone' => $this->phone
                ]);
            }

            curl_close($ch);
        } catch (\Exception $e) {
            Log::error('SMS job failed', [
                'error' => $e->getMessage(),
                'phone' => $this->phone
            ]);
        }
    }
}
