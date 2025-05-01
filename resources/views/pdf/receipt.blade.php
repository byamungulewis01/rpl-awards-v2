<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Receipt #{{ $booking->booking_reference }}</title>
    <style>
        @page {
            margin: 20;
            padding: 20;
        }

        body {
            font-family: 'DejaVu Sans', sans-serif;
            font-size: 11px;
            line-height: 1.4;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .receipt {
            max-width: 100%;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            border-bottom: 1px solid #ddd;
            padding-bottom: 0px;
            margin-bottom: 0px;
        }

        .title {
            font-size: 12px;
            font-weight: bold;
            margin-bottom: -5px;
        }

        .reference {
            font-size: 11px;
            color: #666;
            margin-top: 5px;
            margin-bottom: 4px;
        }

        .status {
            text-align: center;
            margin: 10px 0;
        }

        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: bold;
        }

        .status-confirmed {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-cancelled {
            background-color: #fee2e2;
            color: #b91c1c;
        }

        .section {
            margin-bottom: 10px;
            padding-bottom: 5px;
        }

        .section-title {
            font-size: 11px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .info-row {
            margin-bottom: 0px;
            display: flex;
        }

        .info-label {
            font-size: 10px;
            color: #666;
            width: 80px;
        }

        .info-value {
            font-weight: normal;
            flex: 1;
        }

        .journey-box {
            background-color: #f8f9fa;
            padding: 8px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .journey-point {
            text-align: center;
            width: 45%;
        }

        .journey-label {
            font-size: 9px;
            color: #666;
            text-transform: uppercase;
        }

        .seats {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-top: 5px;
        }

        .seat-badge {
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 10px;
        }

        .total-row {
            border-top: 1px solid #ddd;
            padding-top: 8px;
            margin-top: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-size: 11px;
            color: #666;
        }

        .total-value {
            font-size: 14px;
            font-weight: bold;
        }

        .footer {
            /* margin-top: 15px; */
            text-align: center;
            font-size: 10px;
            color: #666;
            border-top: 1px solid #ddd;
            /* padding-top: 10px; */
            position: fixed;
            bottom: 0px;
        }
    </style>
</head>

<body>
    <div class="receipt">
        <div class="header">
            <h1 class="title">Travel Receipt</h1>
            <p class="reference">{{ $booking->booking_reference }}</p>
        </div>

        <div class="section">
            <div class="info-row">
                <span class="info-label">Route:</span>
                <span class="info-value">{{ $booking->trip->route->name }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Departure:</span>
                <span class="info-value">{{ $booking->formatted_departure }}</span>
            </div>
        </div>

        <div class="journey-box">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 50%;">
                        <div class="journey-point">
                            <div class="journey-label">FROM</div>
                            <div>{{ $booking->boardingStop->name }}</div>
                        </div>
                    </td>
                    <td style="width: 50%;">
                        <div class="journey-point">
                            <div class="journey-label">TO</div>
                            <div>{{ $booking->destinationStop->name }}</div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="section">
            <div class="section-title">Passenger Details</div>
            <div class="info-row">
                <span class="info-label">Name:</span>
                <span class="info-value">{{ $booking->passenger_name }}</span>
            </div>
            @if ($booking->passenger_phone)
                <div class="info-row">
                    <span class="info-label">Phone:</span>
                    <span class="info-value">{{ $booking->passenger_phone }}</span>
                </div>
            @endif
        </div>

        <div class="section">
            <div class="section-title">Booking Details</div>
            <div class="info-row">
                <span class="info-label">Seats:</span>
                <span class="info-value">
                    <div class="seats">
                        @foreach ($booking->formatted_seats as $seat)
                            <span class="seat-badge">{{ $seat }}</span>
                        @endforeach
                    </div>
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Payment:</span>
                <span class="info-value">{{ ucfirst($booking->payment_method) }}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Booked on:</span>
                <span class="info-value">{{ $booking->formatted_booking_date }}</span>
            </div>
        </div>

        <div class="total-row">
            <div class="total-label">Total Amount</div>
            <div class="total-value">{{ $booking->formatted_amount }}</div>
        </div>

        <div class="footer">
            <p style="margin-bottom: -10px;">Thank you for your booking!</p>
            <p style="margin-bottom: -10px;">Please present this receipt during boarding.</p>
            <p>{{ date('Y-m-d H:i:s') }}</p>
        </div>
    </div>
</body>

</html>
