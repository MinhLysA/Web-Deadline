<?php
session_start();
require_once 'config/database.php';

$response = ['success' => false, 'message' => ''];

if (!isset($_SESSION['user_id'])) {
    $response['message'] = 'Bạn cần đăng nhập để thích bài viết!';
    echo json_encode($response);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $baiviet_id = $_POST['baiviet_id'];
    $nguoidung_id = $_SESSION['user_id'];

    // Kiểm tra xem người dùng đã thích chưa
    $stmt = $conn->prepare("SELECT * FROM thich WHERE baiviet_id = ? AND nguoidung_id = ?");
    $stmt->execute([$baiviet_id, $nguoidung_id]);
    if ($stmt->fetch()) {
        $response['message'] = 'Bạn đã thích bài viết này rồi!';
        echo json_encode($response);
        exit();
    }

    // Thêm lượt thích
    $stmt = $conn->prepare("INSERT INTO thich (baiviet_id, nguoidung_id) VALUES (?, ?)");
    if ($stmt->execute([$baiviet_id, $nguoidung_id])) {
        $response['success'] = true;
        $response['message'] = 'Thích bài viết thành công!';
    } else {
        $response['message'] = 'Lỗi khi thích bài viết!';
    }
}

echo json_encode($response);
?>