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
        $message_type = "success";
    } else {
        $message = "Token không hợp lệ hoặc đã hết hạn!";
        $message_type = "error";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kích hoạt tài khoản</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .animate-slide-up {
            animation: slideUp 0.5s ease-out;
        }
        @keyframes slideUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        .gradient-bg {
            background: linear-gradient(135deg, #f3e7ff 0%, #e0f2ff 100%);
        }
    </style>
</head>
<body class="gradient-bg min-h-screen flex items-center justify-center p-4">
    <div class="activate-container bg-white rounded-2xl shadow-2xl p-8 w-full max-w-md animate-slide-up">
        <div class="text-center">
            <div class="mb-6">
                <i class="fas <?php echo isset($message_type) && $message_type === 'success' ? 'fa-check-circle text-green-500' : 'fa-exclamation-circle text-red-500'; ?> text-4xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800 mb-4">Kích hoạt tài khoản</h2>
            <p class="text-gray-600 mb-6 <?php echo isset($message_type) && $message_type === 'success' ? 'text-green-600 font-semibold' : 'text-red-600 font-semibold'; ?>">
                <?php echo $message ?? 'Đang xử lý...'; ?>
            </p>
            <a href="../login.php" 
               class="inline-block bg-red-500 text-white font-semibold py-2 px-6 rounded-lg hover:bg-red-600 transition duration-300 transform hover:scale-105">
                Đăng nhập
            </a>
        </div>
    </div>
</body>
</html>