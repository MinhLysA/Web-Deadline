<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once '../config/database.php';

// Kiểm tra ID bài viết
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: posts.php");
    exit();
}

$post_id = (int)$_GET['id'];

// Lấy thông tin bài viết
$sql = "SELECT * FROM baiviet WHERE id = :id";
$stmt = $conn->prepare($sql);
$stmt->execute([':id' => $post_id]);
$post = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$post) {
    header("Location: posts.php");
    exit();
}

// Lấy danh sách người dùng (tác giả)
$sql_users = "SELECT id, ten FROM nguoidung WHERE vai_tro IN ('admin', 'author')";
$stmt_users = $conn->prepare($sql_users);
$stmt_users->execute();
$users = $stmt_users->fetchAll(PDO::FETCH_ASSOC);

$errors = [];
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $tieude = trim($_POST['tieude']);
    $noidung = trim($_POST['noidung']);
    $tacgia_id = $_POST['tacgia_id'];
    $danh_muc = trim($_POST['danh_muc']);
    $thoi_gian_chuan_bi = !empty($_POST['thoi_gian_chuan_bi']) ? (int)$_POST['thoi_gian_chuan_bi'] : null;
    $thoi_gian_nau = !empty($_POST['thoi_gian_nau']) ? (int)$_POST['thoi_gian_nau'] : null;
    $so_khau_phan = !empty($_POST['so_khau_phan']) ? (int)$_POST['so_khau_phan'] : null;
    $muc_do_kho = $_POST['muc_do_kho'];
    $thong_tin_dinh_duong = trim($_POST['thong_tin_dinh_duong']);

    // Xử lý upload ảnh minh họa
    $anh_minh_hoa = $post['anh_minh_hoa'];
    if (isset($_FILES['anh_minh_hoa']) && $_FILES['anh_minh_hoa']['error'] === UPLOAD_ERR_OK) {
        $file_tmp = $_FILES['anh_minh_hoa']['tmp_name'];
        $file_name = basename($_FILES['anh_minh_hoa']['name']);
        $upload_dir = '../assets/images/';
        $file_path = $upload_dir . time() . '_' . $file_name;

        if (move_uploaded_file($file_tmp, $file_path)) {
            $anh_minh_hoa = 'assets/images/' . time() . '_' . $file_name;
            // Xóa ảnh cũ nếu có
            if (!empty($post['anh_minh_hoa']) && file_exists('../' . $post['anh_minh_hoa'])) {
                unlink('../' . $post['anh_minh_hoa']);
            }
        } else {
            $errors[] = "Không thể tải lên ảnh minh họa.";
        }
    }

    // Kiểm tra lỗi
    if (empty($tieude)) $errors[] = "Tiêu đề không được để trống.";
    if (empty($noidung)) $errors[] = "Nội dung không được để trống.";
    if (empty($tacgia_id)) $errors[] = "Vui lòng chọn tác giả.";

    // Cập nhật database nếu không có lỗi
    if (empty($errors)) {
        $sql = "UPDATE baiviet SET 
                tieude = :tieude, 
                noidung = :noidung, 
                tacgia_id = :tacgia_id, 
                anh_minh_hoa = :anh_minh_hoa, 
                danh_muc = :danh_muc, 
                thoi_gian_chuan_bi = :thoi_gian_chuan_bi, 
                thoi_gian_nau = :thoi_gian_nau, 
                so_khau_phan = :so_khau_phan, 
                muc_do_kho = :muc_do_kho, 
                thong_tin_dinh_duong = :thong_tin_dinh_duong 
                WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            ':tieude' => $tieude,
            ':noidung' => $noidung,
            ':tacgia_id' => $tacgia_id,
            ':anh_minh_hoa' => $anh_minh_hoa,
            ':danh_muc' => $danh_muc,
            ':thoi_gian_chuan_bi' => $thoi_gian_chuan_bi,
            ':thoi_gian_nau' => $thoi_gian_nau,
            ':so_khau_phan' => $so_khau_phan,
            ':muc_do_kho' => $muc_do_kho,
            ':thong_tin_dinh_duong' => $thong_tin_dinh_duong,
            ':id' => $post_id
        ]);

        $success = "Cập nhật bài viết thành công!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Bài viết - Blog Ẩm Thực</title>
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="../assets/css/dashboard.css">
</head>
<body>
    <!-- SIDEBAR -->
    <section id="sidebar">
        <!-- Giữ nguyên sidebar từ posts.php -->
        <!-- ... (Copy từ posts.php) ... -->
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
            <a href="#" class="profile">
                <img src="../assets/images/people.png">
            </a>
        </nav>

        <!-- MAIN -->
        <main>
            <div class="head-title">
                <div class="left">
                    <h1>Sửa Bài viết</h1>
                    <ul class="breadcrumb">
                        <li><a href="admin.php">Dashboard</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a href="posts.php">Quản lý Bài viết</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a class="active" href="#">Sửa Bài viết</a></li>
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
                    <form method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="tieude">Tiêu đề:</label>
                            <input type="text" id="tieude" name="tieude" value="<?php echo htmlspecialchars($post['tieude']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="noidung">Nội dung:</label>
                            <textarea id="noidung" name="noidung" rows="10"><?php echo htmlspecialchars($post['noidung']); ?></textarea>
                        </div>
                        <div class="form-group">
                            <label for="tacgia_id">Tác giả:</label>
                            <select id="tacgia_id" name="tacgia_id">
                                <option value="">Chọn tác giả</option>
                                <?php foreach ($users as $user): ?>
                                    <option value="<?php echo $user['id']; ?>" <?php echo ($post['tacgia_id'] == $user['id']) ? 'selected' : ''; ?>>
                                        <?php echo htmlspecialchars($user['ten']); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="anh_minh_hoa">Ảnh minh họa:</label>
                            <?php if (!empty($post['anh_minh_hoa'])): ?>
                                <img src="../<?php echo $post['anh_minh_hoa']; ?>" alt="Ảnh minh họa" style="max-width: 200px;">
                            <?php endif; ?>
                            <input type="file" id="anh_minh_hoa" name="anh_minh_hoa" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label for="danh_muc">Danh mục:</label>
                            <input type="text" id="danh_muc" name="danh_muc" value="<?php echo htmlspecialchars($post['danh_muc']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="thoi_gian_chuan_bi">Thời gian chuẩn bị (phút):</label>
                            <input type="number" id="thoi_gian_chuan_bi" name="thoi_gian_chuan_bi" value="<?php echo htmlspecialchars($post['thoi_gian_chuan_bi']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="thoi_gian_nau">Thời gian nấu (phút):</label>
                            <input type="number" id="thoi_gian_nau" name="thoi_gian_nau" value="<?php echo htmlspecialchars($post['thoi_gian_nau']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="so_khau_phan">Số khẩu phần (người):</label>
                            <input type="number" id="so_khau_phan" name="so_khau_phan" value="<?php echo htmlspecialchars($post['so_khau_phan']); ?>">
                        </div>
                        <div class="form-group">
                            <label for="muc_do_kho">Mức độ khó:</label>
                            <select id="muc_do_kho" name="muc_do_kho">
                                <option value="">Chọn mức độ</option>
                                <option value="Dễ" <?php echo ($post['muc_do_kho'] == 'Dễ') ? 'selected' : ''; ?>>Dễ</option>
                                <option value="Trung bình" <?php echo ($post['muc_do_kho'] == 'Trung bình') ? 'selected' : ''; ?>>Trung bình</option>
                                <option value="Khó" <?php echo ($post['muc_do_kho'] == 'Khó') ? 'selected' : ''; ?>>Khó</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="thong_tin_dinh_duong">Thông tin dinh dưỡng:</label>
                            <textarea id="thong_tin_dinh_duong" name="thong_tin_dinh_duong" rows="4"><?php echo htmlspecialchars($post['thong_tin_dinh_duong']); ?></textarea>
                        </div>
                        <button type="submit" class="btn-submit">Cập nhật bài viết</button>
                    </form>
                </div>
            </div>
        </main>
    </section>

    <script src="../assets/js/dashboard.js"></script>
</body>
</html>