<?php
session_start();
// Kiểm tra đăng nhập
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: login.php");
    exit();
}

// Kết nối database
require_once 'config/database.php';

// Kiểm tra ID bài viết
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: posts.php");
    exit();
}

$post_id = (int)$_GET['id'];

// Lấy thông tin ảnh minh họa để xóa
$sql = "SELECT anh_minh_hoa FROM baiviet WHERE id = :id";
$stmt = $conn->prepare($sql);
$stmt->execute([':id' => $post_id]);
$post = $stmt->fetch(PDO::FETCH_ASSOC);

if ($post) {
    // Xóa ảnh minh họa nếu có
    if (!empty($post['anh_minh_hoa']) && file_exists('../' . $post['anh_minh_hoa'])) {
        unlink('../' . $post['anh_minh_hoa']);
    }

    // Xóa bài viết khỏi database
    $sql = "DELETE FROM baiviet WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->execute([':id' => $post_id]);
}

// Chuyển hướng về danh sách bài viết
header("Location: posts.php");
exit();