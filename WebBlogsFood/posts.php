<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once 'config/database.php';

// Lấy danh sách bài viết
$sql = "SELECT b.id, b.tieude, b.ngay_dang, n.ten as tacgia 
        FROM baiviet b 
        JOIN nguoidung n ON b.tacgia_id = n.id 
        ORDER BY b.ngay_dang DESC";
$stmt = $conn->prepare($sql);
$stmt->execute();
$posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bài viết - Blog Ẩm Thực</title>
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
            <li class="active">
                <a href="posts.php">
                    <i class='bx bxs-food-menu'></i>
                    <span class="text">Quản lý Bài viết</span>
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
                    <input type="search" placeholder="Tìm kiếm bài viết...">
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
                    <h1>Quản lý Bài viết</h1>
                    <ul class="breadcrumb">
                        <li><a href="admin.php">Dashboard</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a class="active" href="posts.php">Quản lý Bài viết</a></li>
                    </ul>
                </div>
                <a href="add_post.php" class="btn-download">
                    <i class='bx bxs-plus-circle'></i>
                    <span class="text">Thêm bài viết</span>
                </a>
            </div>

            <div class="table-data">
                <div class="order">
                    <div class="head">
                        <h3>Danh sách Bài viết</h3>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Tiêu đề</th>
                                <th>Tác giả</th>
                                <th>Ngày đăng</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($posts as $post): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($post['tieude']); ?></td>
                                <td><?php echo htmlspecialchars($post['tacgia']); ?></td>
                                <td><?php echo date('d/m/Y', strtotime($post['ngay_dang'])); ?></td>
                                <td>
                                    <a href="edit_post.php?id=<?php echo $post['id']; ?>" class="btn-edit"><i class='bx bxs-edit'></i> Sửa</a>
                                    <a href="delete_post.php?id=<?php echo $post['id']; ?>" class="btn-delete" onclick="return confirm('Bạn có chắc muốn xóa bài viết này?');"><i class='bx bxs-trash'></i> Xóa</a>
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