<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "blogsfood";

// Kết nối với MySQL
$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}
echo "Kết nối thành công!";
?>
