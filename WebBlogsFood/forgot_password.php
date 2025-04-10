<?php
session_start();
require_once 'config/database.php';
require_once 'admin/send_mail.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];

    $stmt = $conn->prepare("SELECT id FROM nguoidung WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        $token = bin2hex(random_bytes(16));
        $thoi_gian_het_han = date('Y-m-d H:i:s', strtotime('+1 hour'));

        $stmt = $conn->prepare("INSERT INTO reset_password (nguoidung_id, token, thoi_gian_het_han) VALUES (?, ?, ?)");
        $stmt->execute([$user['id'], $token, $thoi_gian_het_han]);

        $reset_link = "http://localhost/WebBlogsFood/admin/reset_password.php?token=$token";
        $subject = "Reset Password for Web Blog Food";
        $body = "Chào bạn,<br>Vui lòng nhấp vào liên kết sau để đặt lại mật khẩu: <a href='$reset_link'>$reset_link</a><br>Liên kết có hiệu lực trong 1 giờ.";
        $mail_result = sendMail($email, $subject, $body);

        if ($mail_result === true) {
            $success = "Vui lòng kiểm tra email để đặt lại mật khẩu!";
        } else {
            $error = $mail_result;
        }
    } else {
        $error = "Email không tồn tại!";
    }
}
?>

<?php include 'includes/header.php'?>
    <div class="for-container">
        <h2>Quên mật khẩu</h2>
        <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
        <?php if (isset($success)) echo "<p style='color:green;'>$success</p>"; ?>
        <form method="POST">
            <input type="email" name="email" placeholder="Nhập email của bạn" required />
            <button type="submit">Gửi yêu cầu</button>
            <p><a href="login.php">Quay lại đăng nhập</a></p>
        </form>
    </div>
    <?php
    include 'includes/footer.php'
    ?>
</body>
</html>