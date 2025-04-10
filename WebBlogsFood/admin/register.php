<?php
session_start();
require_once '../config/database.php'; // Kết nối database
require_once 'send_mail.php'; // File gửi email

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $ten = $_POST['ten'];
    $email = $_POST['email'];
    $matkhau = password_hash($_POST['matkhau'], PASSWORD_DEFAULT); // Mã hóa mật khẩu
    $vai_tro = 'user'; // Mặc định là user, admin sẽ thêm thủ công trong DB

    // Kiểm tra email đã tồn tại chưa
    $stmt = $conn->prepare("SELECT id FROM nguoidung WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        $error = "Email đã được sử dụng!";
    } else {
        // Thêm người dùng mới với trạng thái chưa kích hoạt (trang_thai = 0)
        $stmt = $conn->prepare("INSERT INTO nguoidung (ten, email, matkhau, vai_tro, trang_thai) VALUES (?, ?, ?, ?, 0)");
        $stmt->execute([$ten, $email, $matkhau, $vai_tro]);

        $nguoidung_id = $conn->lastInsertId();

        // Tạo token kích hoạt
        $token = bin2hex(random_bytes(16));
        $thoi_gian_het_han = date('Y-m-d H:i:s', strtotime('+1 hour')); // Hết hạn sau 1 giờ

        $stmt = $conn->prepare("INSERT INTO account_activation (nguoidung_id, token, thoi_gian_het_han) VALUES (?, ?, ?)");
        $stmt->execute([$nguoidung_id, $token, $thoi_gian_het_han]);

        // Gửi email kích hoạt
        $activation_link = "http://localhost/WebBlogsFood/admin/activate.php?token=$token";
        $subject = "Activate Account for Web Blog Food";
        $body = "Chào $ten,<br>Vui lòng nhấp vào liên kết sau để kích hoạt tài khoản: <a href='$activation_link'>$activation_link</a><br>Liên kết có hiệu lực trong 1 giờ.";
        $mail_result = sendMail($email, $subject, $body);

        if ($mail_result === true) {
            $success = "Đăng ký thành công! Vui lòng kiểm tra email để kích hoạt tài khoản.";
        } else {
            $error = $mail_result;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/logo.css">
    <link rel="stylesheet" href="../assets/css/resigter.css">
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
    <div class="register-container">
        <h2>ĐĂNG KÝ THÀNH VIÊN</h2>
        <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
        <?php if (isset($success)) echo "<p style='color:green;'>$success</p>"; ?>
        <form method="POST">
            <input type="text" name="ten" placeholder="Họ và tên" required />
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="matkhau" placeholder="Mật khẩu" required />
            <input type="password" name="xac_nhan_matkhau" placeholder="Xác nhận mật khẩu" required />
            <button type="submit">Đăng ký</button>
            <p>Đã có tài khoản? <a href="login.php">Đăng nhập</a></p>
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