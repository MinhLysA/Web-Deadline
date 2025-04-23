<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once 'config/database.php';

// Kiểm tra ID người dùng
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: users.php");
    exit();
}

$user_id = (int)$_GET['id'];

// Lấy thông tin người dùng
$sql = "SELECT id, ten, email, vai_tro FROM nguoidung WHERE id = :id";
$stmt = $conn->prepare($sql);
$stmt->execute([':id' => $user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    header("Location: users.php");
    exit();
}

$errors = [];
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ten = trim($_POST['ten']);
    $email = trim($_POST['email']);
    $vai_tro = $_POST['vai_tro'];
    $mat_khau = $_POST['mat_khau'];

    // Kiểm tra lỗi
    if (empty($ten)) $errors[] = "Tên không được để trống.";
    if (empty($email)) $errors[] = "Email không được để trống.";
    if (empty($vai_tro)) $errors[] = "Vui lòng chọn vai trò.";

    // Cập nhật database nếu không có lỗi
    if (empty($errors)) {
        if (!empty($mat_khau)) {
            // Cập nhật cả mật khẩu
            $hashed_password = password_hash($mat_khau, PASSWORD_DEFAULT);
            $sql = "UPDATE nguoidung SET ten = :ten, email = :email, matkhau = :matkhau, vai_tro = :vai_tro WHERE id = :id";
            $stmt = $conn->prepare($sql);
            $stmt->execute([
                ':ten' => $ten,
                ':email' => $email,
                ':matkhau' => $hashed_password,
                ':vai_tro' => $vai_tro,
                ':id' => $user_id
            ]);
        } else {
            // Không cập nhật mật khẩu
            $sql = "UPDATE nguoidung SET ten = :ten, email = :email, vai_tro = :vai_tro WHERE id = :id";
            $stmt = $conn->prepare($sql);
            $stmt->execute([
                ':ten' => $ten,
                ':email' => $email,
                ':vai_tro' => $vai_tro,
                ':id' => $user_id
            ]);
        }
        $success = "Cập nhật người dùng thành công!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Người dùng - Blog Ẩm Thực</title>
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
                    <h1>Sửa Người dùng</h1>
                    <ul class="breadcrumb">
                        <li><a href="admin.php">Dashboard</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a href="users.php">Quản lý Người dùng</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a class="active" href="edit_user.php">Sửa Người dùng</a></li>
                    </ul>
                </div>
            </div>

            <?php if (!empty($errors)): ?>
            <div class="alert alert-error">
                <?php foreach ($errors as $error): ?>
                    <p><?php echo $error; ?></p>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

            <?php if ($success): ?>
            <div class="alert alert-success">
                <p><?php echo $success; ?></p>
            </div>
            <?php endif; ?>

            <div class="table-data">
                <div class="order">
                    <form method="POST">
                        <div class="form-group">
                            <label for="ten">Tên:</label>
                            <input type="text" id="ten" name="ten" value="<?php echo htmlspecialchars($user['ten']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="mat_khau">Mật khẩu (để trống nếu không đổi):</label>
                            <input type="password" id="mat_khau" name="mat_khau">
                        </div>
                        <div class="form-group">
                            <label for="vai_tro">Vai trò:</label>
                            <select id="vai_tro" name="vai_tro">
                                <option value="">Chọn vai trò</option>
                                <option value="admin" <?php echo $user['vai_tro'] == 'admin' ? 'selected' : ''; ?>>Admin</option>
                                <option value="author" <?php echo $user['vai_tro'] == 'author' ? 'selected' : ''; ?>>Author</option>
                                <option value="user" <?php echo $user['vai_tro'] == 'user' ? 'selected' : ''; ?>>User</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-submit">Cập nhật người dùng</button>
                    </form>
                </div>
            </div>
        </main>
    </section>

    <script src="assets/js/dashboard.js"></script>
</body>
</html>
