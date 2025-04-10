<?php
ob_start();
session_start();
require_once 'config/database.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $matkhau = $_POST['matkhau'];

    $stmt = $conn->prepare("SELECT id, ten, matkhau, vai_tro, trang_thai FROM nguoidung WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($matkhau, $user['matkhau'])) {
        if ($user['trang_thai'] == 0) {
            $error = "Tài khoản chưa được kích hoạt! Vui lòng kiểm tra email.";
        } else {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['vai_tro'] = $user['vai_tro'];
            $_SESSION['user_name'] = $user['ten'];

            if ($user['vai_tro'] == 'admin') {
                $_SESSION['admin_logged_in'] = true;
                header("Location: admin.php");
                exit();
            } else {
                header("Location: index.php");
                exit();
            }
        }
    } else {
        $error = "Email hoặc mật khẩu không đúng!";
    }
}
?>

  <?php include 'includes/header.php'?>
    <div class="login-container">
        <h2>ĐĂNG NHẬP THÀNH VIÊN</h2>
        <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
        <form method="POST">
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="matkhau" placeholder="Mật khẩu" required />
            <button type="submit">Đăng nhập</button>
            <a href="forgot_password.php">Quên mật khẩu?</a>
            <p>Chưa có tài khoản? <a href="register.php">Đăng ký</a></p>
        </form>
    </div>
    <?php
    include 'includes/footer.php'
    ?>
</body>
</html>