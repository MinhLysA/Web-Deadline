<!-- filepath: c:\xampp\htdocs\WebBlogsFood\includes\header.php -->
<?php
$logged_in = isset($_SESSION['user_id']);
$user_name = ($logged_in && isset($_SESSION['user_name'])) ? $_SESSION['user_name'] : "Người dùng";
?>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?php echo $title ?? 'Trang Web'; ?></title>
    <link rel="stylesheet" href="static/Lv2/css/header.css" />
    <link rel="stylesheet" href="static/Lv2/css/footer.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link rel="stylesheet" href="assets/css/logo.css" />
    <link rel="stylesheet" href="assets/css/login.css" />
    <link rel="stylesheet" href="assets/css/forgot.css" />
    <link rel="stylesheet" href="assets/css/register.css" />
    <link rel="stylesheet" href="assets/css/logoutmenu.css" />
    <link rel="stylesheet" href="assets/css/CongThucV2.css" />
    <link rel="stylesheet" href="static/Lv2/css/style_anuong.css" />
    <link rel="stylesheet" href="static/Lv2/css/style_bosuutap.css" />
    <link rel="stylesheet" href="static/Lv2/css/style_congthuc.css" />
    <link rel="stylesheet" href="static/Lv2/css/style_video.css" />
    <link rel="stylesheet" href="static/Lv2/css/style_vitri.css" />
    <script src="assets/js/kt.js" defer></script>
    <script src="../static/Lv2/js/anuong.js" defer></script>
    <script src="../static/Lv2/js/kt.js"></script>
    <script src="../WebBlogsFood/assets/js/kt.js" defer></script>
    <script src="../static/Lv2/js/bosuutap.js" defer></script>
  </head>
  <body>
      <header>
        <div class="container">
        <div class="logo">
  <a href="index.php">
    <img src="images/Logo (2).png" alt="Logo" class="logo-img">
  </a>
</div>
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
                    <?php if ($logged_in): ?>
                        <!-- Hiển thị tên user và menu dropdown nếu đã đăng nhập -->
                        <a href="#"><?php echo htmlspecialchars($user_name); ?> ▼</a>
                        <ul class="dropdown-menu">
                            <li><a href="logout.php">Đăng xuất</a></li>
                        </ul>
                    <?php else: ?>
                        <!-- Hiển thị "Tài khoản" nếu chưa đăng nhập -->
                        <a href="login.php">Tài khoản</a>
                    <?php endif; ?>
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