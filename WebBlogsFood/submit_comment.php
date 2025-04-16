<?php
session_start();
require_once 'config/database.php';

$response = ['success' => false, 'message' => ''];

if (!isset($_SESSION['user_id'])) {
    $response['message'] = 'Bạn cần đăng nhập để bình luận!';
    echo json_encode($response);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $baiviet_id = $_POST['baiviet_id'];
    $noidung = $_POST['noidung'];
    $nguoidung_id = $_SESSION['user_id'];

    $stmt = $conn->prepare("INSERT INTO binhluan (noidung, baiviet_id, nguoidung_id) VALUES (?, ?, ?)");
    if ($stmt->execute([$noidung, $baiviet_id, $nguoidung_id])) {
        $response['success'] = true;
        $response['message'] = 'Bình luận thành công!';
    } else {
        $response['message'] = 'Lỗi khi gửi bình luận!';
    }
}

echo json_encode($response);
?>