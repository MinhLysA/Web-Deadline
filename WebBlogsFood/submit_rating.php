<?php
session_start();
require_once 'config/database.php';

$response = ['success' => false, 'message' => ''];

if (!isset($_SESSION['user_id'])) {
    $response['message'] = 'Bạn cần đăng nhập để đánh giá!';
    echo json_encode($response);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $baiviet_id = $_POST['baiviet_id'];
    $diem = $_POST['diem'];
    $nguoidung_id = $_SESSION['user_id'];

    // Kiểm tra xem người dùng đã đánh giá chưa
    $stmt = $conn->prepare("SELECT * FROM danhgia WHERE baiviet_id = ? AND nguoidung_id = ?");
    $stmt->execute([$baiviet_id, $nguoidung_id]);
    if ($stmt->fetch()) {
        $response['message'] = 'Bạn đã đánh giá công thức này rồi!';
        echo json_encode($response);
        exit();
    }

    // Thêm đánh giá
    $stmt = $conn->prepare("INSERT INTO danhgia (baiviet_id, nguoidung_id, diem) VALUES (?, ?, ?)");
    if ($stmt->execute([$baiviet_id, $nguoidung_id, $diem])) {
        $response['success'] = true;
        $response['message'] = 'Đánh giá thành công!';
    } else {
        $response['message'] = 'Lỗi khi gửi đánh giá!';
    }
}

echo json_encode($response);
?>