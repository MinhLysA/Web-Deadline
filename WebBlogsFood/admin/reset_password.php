<?php
session_start();
require_once '../config/database.php';

if (isset($_GET['token'])) {
    $token = $_GET['token'];

    $stmt = $conn->prepare("SELECT nguoidung_id, thoi_gian_het_han FROM reset_password WHERE token = ?");
    $stmt->execute([$token]);
    $reset = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($reset && strtotime($reset['thoi_gian_het_han']) > time()) {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $matkhau_moi = password_hash($_POST['matkhau_moi'], PASSWORD_DEFAULT);

            $stmt = $conn->prepare("UPDATE nguoidung SET matkhau = ? WHERE id = ?");
            $stmt->execute([$matkhau_moi, $reset['nguoidung_id']]);

            $stmt = $conn->prepare("DELETE FROM reset_password WHERE token = ?");
            $stmt->execute([$token]);

            $message = "Mật khẩu đã được đặt lại thành công! Vui lòng đăng nhập.";
        }
    } else {
        $message = "Token không hợp lệ hoặc đã hết hạn!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
    <link rel="stylesheet" href="../assets/css/reset_password.css">
</head>
<body>
    <div class="container">
        <h2>Đặt lại mật khẩu</h2>
        <?php if (isset($message)) echo "<p>$message</p>"; ?>
        <?php if (!isset($message) || strpos($message, "thành công") === false): ?>
        <form method="POST">
            <input type="password" name="matkhau_moi" placeholder="Mật khẩu mới" required />
            <input type="password" name="xac_nhan_matkhau" placeholder="Xác nhận mật khẩu" required />
            <button type="submit">Đặt lại</button>
        </form>
        <?php endif; ?>
        <p><a href="../login.php">Quay lại đăng nhập</a></p>
    </div>
</body>
</html>