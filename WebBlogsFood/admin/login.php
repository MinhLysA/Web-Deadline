<?php
ob_start();
session_start();
require_once '../config/database.php';

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
                header("Location: ../index.php");
                exit();
            }
        }
    } else {
        $error = "Email hoặc mật khẩu không đúng!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="../WebBlogsFood/assets/css/style.css">
</head>
<body>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Trang chủ</title>
    <link rel="stylesheet" href="../assets/css/style.css" />
    <link rel="stylesheet" href="../assets/css/login.css" />
    <script src="../assets/js/kt.js" defer></script>
  </head>
  <body>
    <div class="wrapper">
      <header>
        <div class="container">
          <div class="logo"><a href="../index.php">LOGO</a></div>
          <nav>
            <ul>
              <li><a href="bosuutap.php">Bộ sưu tập</a></li>
              <li class="dropdown">
                <a href="anuong.php">Ăn uống ▼</a>
                <ul class="dropdown-menu">
                  <li><a href="anuong.php">Phở</a></li>
                  <li><a href="anuong.php">Bún chả</a></li>
                  <li><a href="anuong.php">Cơm tấm</a></li>
                  <li><a href="anuong.php">Lẩu Thái</a></li>
                </ul>
              </li>
              <li><a href="video.php">Video</a></li>
              <li><a href="vitri.php">Gần bạn</a></li>
              <li><a href="congthuc.php">Công thức nấu ăn</a></li>
            </ul>
          </nav>
          <div class="account">
            <span>👤</span>
            <a href="../admin/login.php">Tài khoản</a>
          </div>
        </div>
      </header>

      <div class="search-container">
        <select>
          <option>Chọn địa điểm</option>
          <option>Hà Nội</option>
          <option>TP.HCM</option>
          <option>Đà Nẵng</option>
        </select>
        <input type="text" placeholder="Nhà hàng bạn mong muốn..." />
        <button>Tìm kiếm</button>
      </div>
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