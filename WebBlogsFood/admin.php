<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once 'config/database.php';

// Lấy thống kê
$stmt = $conn->prepare("SELECT COUNT(*) as total FROM baiviet");
$stmt->execute();
$total_posts = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

$stmt = $conn->prepare("SELECT COUNT(*) as total FROM nguoidung");
$stmt->execute();
$total_users = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Blog Ẩm Thực</title>
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>
    <!-- SIDEBAR -->
    <section id="sidebar">
        <a href="admin.php" class="brand">
            <i class='bx bxs-restaurant'></i>
            <span class="text">Admin Blog Ẩm Thực</span>
        </a>
        <ul class="side-menu top">
            <li class="active">
                <a href="admin.php">
                    <i class='bx bxs-dashboard'></i>
                    <span class="text">Dashboard</span>
                </a>
            </li>
            <li>
                <a href="posts.php">
                    <i class='bx bxs-food-menu'></i>
                    <span class="text">Quản lý Bài viết</span>
                </a>
            </li>
            <li>
                <a href="users.php">
                    <i class='bx bxs-user'></i>
                    <span class="text">Quản lý Người dùng</span>
                </a>
            </li>
        </ul>
        <ul class="side-menu">
            <li>
                <a href="logout.php" class="logout">
                    <i class='bx bxs-log-out-circle'></i>
                    <span class="text">Đăng xuất</span>
                </a>
            </li>
        </ul>
    </section>

    <!-- CONTENT -->
    <section id="content">
        <!-- NAVBAR -->
        <nav>
            <i class='bx bx-menu'></i>
            <form action="#">
                <div class="form-input">
                    <input type="search" placeholder="Tìm kiếm...">
                    <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                </div>
            </form>
            <input type="checkbox" id="switch-mode" hidden>
            <label for="switch-mode" class="switch-mode"></label>
            <a href="admin.php" class="profile">
                <img src="images/admin.jpg">
            </a>
        </nav>

        <!-- MAIN -->
        <main>
            <div class="head-title">
                <div class="left">
                    <h1>Dashboard</h1>
                </div>
            </div>

            <ul class="box-info">
                <li>
                    <i class='bx bxs-food-menu'></i>
                    <span class="text">
                        <h3><?php echo $total_posts; ?></h3>
                        <p>Bài viết</p>
                    </span>
                </li>
                <li>
                    <i class='bx bxs-user'></i>
                    <span class="text">
                        <h3><?php echo $total_users; ?></h3>
                        <p>Người dùng</p>
                    </span>
                </li>
            </ul>
        </main>
    </section>

    <script src="assets/js/dashboard.js"></script>
</body>
</html>
