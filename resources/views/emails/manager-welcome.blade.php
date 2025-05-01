<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Transport Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #0f172a;
            padding: 20px;
            text-align: center;
            color: white;
        }
        .content {
            padding: 20px;
            background-color: #f9fafb;
        }
        .credentials {
            background-color: #e5e7eb;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .footer {
            text-align: center;
            font-size: 12px;
            color: #6b7280;
            margin-top: 20px;
            padding: 10px 0;
            border-top: 1px solid #e5e7eb;
        }
        .button {
            display: inline-block;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Welcome to Our Transport Management System</h1>
        </div>

        <div class="content">
            <h2>Hello {{ $user->name }},</h2>

            <p>Welcome to our Transport Management System! Your company <strong>{{ $company->name }}</strong> has been successfully registered in our system, and you have been assigned as the company manager.</p>

            <p>Below are your login credentials to access the system:</p>

            <div class="credentials">
                <p><strong>Email:</strong> {{ $user->email }}</p>
                <p><strong>Password:</strong> {{ $password }}</p>
                <p><strong>Role:</strong> Company Manager</p>
            </div>

            <p><strong>Important:</strong> Please log in and change your password immediately for security reasons.</p>

            <a href="{{ route('login') }}" class="button">Login to Dashboard</a>

            <p>As a company manager, you'll be able to:</p>
            <ul>
                <li>Manage your company profile</li>
                <li>Add and manage vehicles</li>
                <li>View and update compliance documents</li>
                <li>Manage drivers and other staff members</li>
                <li>Track operations and generate reports</li>
            </ul>

            <p>If you have any questions or need assistance, please contact our support team.</p>

            <p>Thank you for joining us!</p>
        </div>

        <div class="footer">
            <p>&copy; {{ date('Y') }} Transport Management System. All rights reserved.</p>
            <p>This is an automated message, please do not reply to this email.</p>
        </div>
    </div>
</body>
</html>
