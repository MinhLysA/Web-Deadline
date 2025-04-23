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
    header("Location: users.php?error=ID người dùng không hợp lệ.");
    exit();
}

$user_id = (int)$_GET['id'];

try {
    // Bắt đầu giao dịch
    $conn->beginTransaction();

    // Kiểm tra xem người dùng có bài viết liên quan không
    $sql = "SELECT COUNT(*) as total FROM baiviet WHERE tacgia_id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->execute(['id' => $user_id]);
    $total_posts = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

    if ($total_posts > 0) {
        $conn->rollBack();
        header("Location: users.php?error=Không thể xóa người dùng vì họ có bài viết liên quan.");
        exit();
    }

    // Xóa các bản ghi liên quan trong account_activation
    $sql = "DELETE FROM account_activation WHERE nguoidung_id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->execute(['id' => $user_id]);

    // Xóa người dùng
    $sql = "DELETE FROM nguoidung WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->execute(['id' => $user_id]);

    // Cam kết giao dịch
    $conn->commit();

    // Chuyển hướng về danh sách người dùng
    header("Location: users.php?success=Xóa người dùng thành công.");
    exit();
} catch (PDOException $e) {
    // Hoàn tác giao dịch nếu có lỗi
    $conn->rollBack();
    header("Location: users.php?error=Lỗi: " . urlencode($e->getMessage()));
    exit();
}
