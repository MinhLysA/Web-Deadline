<?php
// Thay đường dẫn tới các file PHPMailer
require_once 'PHPMailer-master/src/Exception.php';
require_once 'PHPMailer-master/src/PHPMailer.php';
require_once 'PHPMailer-master/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

function sendMail($to, $subject, $body) {
    $mail = new PHPMailer(true);
    try {
        // Cấu hình server SMTP (dùng Gmail làm ví dụ)
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = '99.dangkhoa.10@gmail.com'; // Thay bằng email của bạn
        $mail->Password = 'zriqkorqvllclzbh';    // Thay bằng mật khẩu ứng dụng
        $mail->SMTPSecure = 'tls';
        $mail->Port = 587;

        // Thiết lập người gửi và người nhận
        $mail->setFrom('99.dangkhoa.10@gmail.com', 'Web Blog Food');
        $mail->addAddress($to);

        // Nội dung email
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body = $body;

        $mail->send();
        return true;
    } catch (Exception $e) {
        return "Không thể gửi email. Lỗi: {$mail->ErrorInfo}";
    }
}
?>