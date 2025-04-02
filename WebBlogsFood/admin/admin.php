<?php
session_start();
// Kiểm tra đăng nhập
if(!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once __DIR__ . '/../config/database.php';

// Lấy thống kê
// Lấy số lượng nhà hàng
$restaurants_count = $conn->query("SELECT COUNT(*) FROM restaurants")->fetchColumn();

// Lấy số lượng đánh giá
$reviews_count = $conn->query("SELECT COUNT(*) FROM reviews")->fetchColumn();

// Lấy số lượng người dùng
$users_count = $conn->query("SELECT COUNT(*) FROM users")->fetchColumn();

// Lấy đánh giá gần đây
$recent_reviews = $conn->query("SELECT r.*, u.username, res.name as restaurant_name 
                               FROM reviews r 
                               JOIN users u ON r.user_id = u.id 
                               JOIN restaurants res ON r.restaurant_id = res.id 
                               ORDER BY r.created_at DESC LIMIT 5");
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Blog Review Nhà Hàng</title>
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="../assets/css/dashboard.css">
</head>
<body>
    <!-- SIDEBAR -->
    <section id="sidebar">
        <a href="#" class="brand">
            <i class='bx bxs-restaurant'></i>
            <span class="text">Admin Review NH</span>
        </a>
        <ul class="side-menu top">
            <li class="active">
                <a href="admin.php">
                    <i class='bx bxs-dashboard'></i>
                    <span class="text">Dashboard</span>
                </a>
            </li>
            <li>
                <a href="restaurants.php">
                    <i class='bx bxs-food-menu'></i>
                    <span class="text">Quản lý Nhà hàng</span>
                </a>
            </li>
            <li>
                <a href="reviews.php">
                    <i class='bx bxs-star'></i>
                    <span class="text">Quản lý Đánh giá</span>
                </a>
            </li>
            <li>
                <a href="categories.php">
                    <i class='bx bxs-category'></i>
                    <span class="text">Danh mục</span>
                </a>
            </li>
            <li>
                <a href="users.php">
                    <i class='bx bxs-user'></i>
                    <span class="text">Người dùng</span>
                </a>
            </li>
        </ul>
        <ul class="side-menu">
            <li>
                <a href="settings.php">
                    <i class='bx bxs-cog'></i>
                    <span class="text">Cài đặt</span>
                </a>
            </li>
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
            <a href="#" class="notification">
                <i class='bx bxs-bell'></i>
                <span class="num"><?= $reviews_count > 0 ? $reviews_count : '' ?></span>
            </a>
            <a href="#" class="profile">
                <img src="../assets/images/people.png">
            </a>
        </nav>

        <!-- MAIN -->
        <main>
            <div class="head-title">
                <div class="left">
                    <h1>Dashboard</h1>
                    <ul class="breadcrumb">
                        <li>
                            <a href="#">Dashboard</a>
                        </li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li>
                            <a class="active" href="#">Tổng quan</a>
                        </li>
                    </ul>
                </div>
            </div>

            <ul class="box-info">
                <li>
                    <i class='bx bxs-restaurant'></i>
                    <span class="text">
                        <h3><?= $restaurants_count ?></h3>
                        <p>Nhà hàng</p>
                    </span>
                </li>
                <li>
                    <i class='bx bxs-star'></i>
                    <span class="text">
                        <h3><?= $reviews_count ?></h3>
                        <p>Đánh giá</p>
                    </span>
                </li>
                <li>
                    <i class='bx bxs-user'></i>
                    <span class="text">
                        <h3><?= $users_count ?></h3>
                        <p>Người dùng</p>
                    </span>
                </li>
            </ul>

            <div class="table-data">
                <div class="order">
                    <div class="head">
                        <h3>Đánh giá mới nhất</h3>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Người dùng</th>
                                <th>Nhà hàng</th>
                                <th>Điểm</th>
                                <th>Ngày</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while($review = $recent_reviews->fetch(PDO::FETCH_ASSOC)): ?>
                            <tr>
                                <td>
                                    <img src="img/user-avatar.png">
                                    <p><?= htmlspecialchars($review['username']) ?></p>
                                </td>
                                <td><?= htmlspecialchars($review['restaurant_name']) ?></td>
                                <td>
                                    <span class="status completed">
                                        <?= str_repeat('★', $review['rating']) . str_repeat('☆', 5 - $review['rating']) ?>
                                    </span>
                                </td>
                                <td><?= date('d/m/Y', strtotime($review['created_at'])) ?></td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
                <div class="todo">
                    <div class="head">
                        <h3>Công việc cần làm</h3>
                        <i class='bx bx-plus'></i>
                    </div>
                    <ul class="todo-list">
                        <li class="completed">
                            <p>Kiểm tra đánh giá mới</p>
                            <i class='bx bx-dots-vertical-rounded'></i>
                        </li>
                        <li class="not-completed">
                            <p>Duyệt nhà hàng mới</p>
                            <i class='bx bx-dots-vertical-rounded'></i>
                        </li>
                        <li class="not-completed">
                            <p>Cập nhật danh mục</p>
                            <i class='bx bx-dots-vertical-rounded'></i>
                        </li>
                    </ul>
                </div>
            </div>
        </main>
    </section>

    <script src="../assets/js/dashboard.js"></script>
</body>
</html>