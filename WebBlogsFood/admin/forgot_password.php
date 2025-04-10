<?php
session_start();
require_once '../config/database.php';
require_once 'send_mail.php';

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

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/logo.css">
    <link rel="stylesheet" href="../assets/css/forgot.css">
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
            <a href="../WebBlogsFood/admin/login.php">Tài khoản</a>
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
    <footer>
        <div class="container footer-content">
          <div class="footer-section">
            <div class="logo">LOGO</div>
          </div>
          <div class="footer-section">
            <h4>Giới thiệu</h4>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
          <div class="footer-section">
            <h4>Tiện ích</h4>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
          <div class="footer-section">
            <h4>Chính sách</h4>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
          <div class="footer-section">
            <h4>Chứng nhận</h4>
            <div class="certification-circle"></div>
          </div>
        </div>
      </footer>
</body>
</html>