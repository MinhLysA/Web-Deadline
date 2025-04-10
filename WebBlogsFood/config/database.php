<?php
$host = 'localhost';
$dbname = 'webblogfood';
$username = 'root'; // Thay đổi nếu cần
$password = ''; // Thay đổi nếu cần

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Kết nối database thất bại: " . $e->getMessage());
}