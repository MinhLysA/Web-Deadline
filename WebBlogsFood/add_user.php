<?php
session_start();
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

require_once 'config/database.php';

$errors = [];
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ten = trim($_POST['ten']);
    $email = trim($_POST['email']);
    $mat_khau = $_POST['mat_khau'];
    $vai_tro = $_POST['vai_tro'];
    $trang_thai = $_POST['trang_thai'];

    if (empty($ten)) $errors[] = "Tên không được để trống.";
    if (empty($email)) $errors[] = "Email không được để trống.";
    if (empty($mat_khau)) $errors[] = "Mật khẩu không được để trống.";
    if (empty($vai_tro)) $errors[] = "Vui lòng chọn vai trò.";
    if (!isset($trang_thai) || ($trang_thai !== '0' && $trang_thai !== '1')) $errors[] = "Vui lòng chọn trạng thái hợp lệ.";

    if (empty($errors)) {
        $hashed_password = password_hash($mat_khau, PASSWORD_DEFAULT);
        $sql = "INSERT INTO nguoidung (ten, email, matkhau, vai_tro, trang_thai) VALUES (:ten, :email, :matkhau, :vai_tro, :trang_thai)";
        try {
            $stmt = $conn->prepare($sql);
            $stmt->execute([
                ':ten' => $ten,
                ':email' => $email,
                ':matkhau' => $hashed_password,
                ':vai_tro' => $vai_tro,
                ':trang_thai' => $trang_thai
            ]);
            $success = "Thêm người dùng thành công!";
        } catch (PDOException $e) {
            $errors[] = "Lỗi cơ sở dữ liệu: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người dùng</title>
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
    <section id="content">
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
        <main>
            <div class="head-title">
                <h1>Thêm Người dùng</h1>
            </div>
            <?php if (!empty($errors)): ?>
            <div class="alert alert-error">
                <?php foreach ($errors as $error): ?>
                    <p><?php echo htmlspecialchars($error); ?></p>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <?php if ($success): ?>
            <div class="alert alert-success">
                <p><?php echo htmlspecialchars($success); ?></p>
            </div>
            <?php endif; ?>
            <div class="table-data">
                <div class="order">
                    <form method="POST">
                        <div class="form-group">
                            <label for="ten">Tên:</label>
                            <input type="text" id="ten" name="ten" value="<?php echo isset($_POST['ten']) ? htmlspecialchars($_POST['ten']) : ''; ?>">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>">
                        </div>
                        <div class="form-group">
                            <label for="mat_khau">Mật khẩu:</label>
                            <input type="password" id="mat_khau" name="mat_khau">
                        </div>
                        <div class="form-group">
                            <label for="vai_tro">Vai trò:</label>
                            <select id="vai_tro" name="vai_tro">
                                <option value="">Chọn vai trò</option>
                                <option value="admin" <?php echo (isset($_POST['vai_tro']) && $_POST['vai_tro'] == 'admin') ? 'selected' : ''; ?>>Admin</option>
                                <option value="author" <?php echo (isset($_POST['vai_tro']) && $_POST['vai_tro'] == 'author') ? 'selected' : ''; ?>>Author</option>
                                <option value="user" <?php echo (isset($_POST['vai_tro']) && $_POST['vai_tro'] == 'user') ? 'selected' : ''; ?>>User</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="trang_thai">Trạng thái:</label>
                            <select id="trang_thai" name="trang_thai">
                                <option value="">Chọn trạng thái</option>
                                <option value="1" <?php echo (isset($_POST['trang_thai']) && $_POST['trang_thai'] == '1') ? 'selected' : ''; ?>>Kích hoạt</option>
                                <option value="0" <?php echo (isset($_POST['trang_thai']) && $_POST['trang_thai'] == '0') ? 'selected' : ''; ?>>Khóa</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-submit">Thêm người dùng</button>
                    </form>
                </div>
            </div>
        </main>
    </section>
    <script src="assets/js/dashboard.js"></script>
</body>
</html>