<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once 'config/database.php';

// Lấy danh sách người dùng
$sql = "SELECT id, ten, email, vai_tro, ngay_dang_ky FROM nguoidung ORDER BY ngay_dang_ky DESC";
$stmt = $conn->prepare($sql);
$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng - Blog Ẩm Thực</title>
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
            <li>
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
            <li class="active">
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
                    <input type="search" placeholder="Tìm kiếm người dùng...">
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
            <h1>Quản lý Người dùng</h1>
            <ul class="breadcrumb">
                <li><a href="admin.php">Dashboard</a></li>
                <li><i class='bx bx-chevron-right'></i></li>
                <li><a class="active" href="#">Quản lý Người dùng</a></li>
            </ul>
        </div>
        <a href="add_user.php" class="btn-download">
            <i class='bx bxs-plus-circle'></i>
            <span class="text">Thêm người dùng</span>
        </a>
    </div>

    <?php if (isset($_GET['success'])): ?>
    <div class="alert alert-success">
        <p><?php echo htmlspecialchars($_GET['success']); ?></p>
    </div>
    <?php endif; ?>

    <?php if (isset($_GET['error'])): ?>
    <div class="alert alert-error">
        <p><?php echo htmlspecialchars($_GET['error']); ?></p>
    </div>
    <?php endif; ?>

    <div class="table-data">
        <div class="order">
            <div class="head">
                <h3>Danh sách Người dùng</h3>
            </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Ngày tạo</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($users as $user): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($user['ten']); ?></td>
                                <td><?php echo htmlspecialchars($user['email']); ?></td>
                                <td><?php echo htmlspecialchars($user['vai_tro']); ?></td>
                                <td><?php echo date('d/m/Y', strtotime($user['ngay_dang_ky'])); ?></td>
                                <td>
                                    <a href="edit_user.php?id=<?php echo $user['id']; ?>" class="btn-edit"><i class='bx bxs-edit'></i> Sửa</a>
                                    <a href="delete_user.php?id=<?php echo $user['id']; ?>" class="btn-delete" onclick="return confirm('Bạn có chắc muốn xóa người dùng này?');"><i class='bx bxs-trash'></i> Xóa</a>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </section>

    <script src="assets/js/dashboard.js"></script>
</body>
</html>
