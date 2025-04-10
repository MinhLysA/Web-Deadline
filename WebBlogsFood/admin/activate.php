<?php
require_once '../config/database.php';

if (isset($_GET['token'])) {
    $token = $_GET['token'];

    // Kiểm tra token
    $stmt = $conn->prepare("SELECT nguoidung_id, thoi_gian_het_han FROM account_activation WHERE token = ?");
    $stmt->execute([$token]);
    $activation = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($activation && strtotime($activation['thoi_gian_het_han']) > time()) {
        // Kích hoạt tài khoản
        $stmt = $conn->prepare("UPDATE nguoidung SET trang_thai = 1 WHERE id = ?");
        $stmt->execute([$activation['nguoidung_id']]);

        // Xóa token sau khi kích hoạt
        $stmt = $conn->prepare("DELETE FROM account_activation WHERE token = ?");
        $stmt->execute([$token]);

        $message = "Tài khoản của bạn đã được kích hoạt thành công! Vui lòng đăng nhập.";
    } else {
        $message = "Token không hợp lệ hoặc đã hết hạn!";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kích hoạt tài khoản</title>
    <link rel="stylesheet" href="../WebBlogsFood/assets/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }

        .activate-container {
            width: 1000px; /* Đồng bộ với login, register, forgot_password */
            height: 500px; /* Đồng bộ với login, register, forgot_password */
            background: #fff;
            padding: 50px;
            margin: 80px auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            top: -30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .activate-container h2 {
            margin-bottom: 20px;
            font-size: 24px; /* Đồng bộ với login, register, forgot_password */
            color: #333;
        }

        .activate-container p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }

        .activate-container a {
            color: red; /* Màu đỏ, đồng bộ với login, register, forgot_password */
            font-weight: bold; /* In đậm, đồng bộ với login, register, forgot_password */
            text-decoration: none;
            font-size: 16px;
        }

        .activate-container a:hover {
            text-decoration: underline; 
        }

     
        .activate-container p[style*="color:green"] {
            color: green;
            font-weight: bold;
        }

        .activate-container p[style*="color:red"] {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Kích hoạt tài khoản</h2>
        <p><?php echo $message ?? 'Đang xử lý...'; ?></p>
        <a href="../login.php">Đăng nhập</a>
    </div>
</body>
</html>