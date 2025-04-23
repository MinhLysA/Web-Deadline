<?php
require_once 'config/database.php'; // Kết nối DB
session_start();

$page_title = "Trang Chi Tiết Địa Điểm Ăn Uống";

// Giả sử ID địa điểm được truyền qua URL (ví dụ: an_uongV2.php?id=1)
$diadiem_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Lấy thông tin địa điểm từ DB
$sql_diadiem = "SELECT * FROM diadiem_anuong WHERE id = ?";
$stmt = $conn->prepare($sql_diadiem);
$stmt->execute([$diadiem_id]);
$diadiem = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$diadiem) {
    die("Không tìm thấy địa điểm.");
}

// Xử lý đặt chỗ
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $adults   = $_POST["adults"];
    $children = $_POST["children"];
    $date     = $_POST["date"];
    $message  = "Đặt chỗ thành công cho $adults người lớn và $children trẻ em vào ngày $date!";
}

include_once 'includes/header.php';
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?php echo htmlspecialchars($page_title); ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f8f8f8;
            color: #333;
        }

        h2, h3 {
            color: #d35400;
        }

        .diadiem-banner img {
            border-radius: 12px;
        }

        .info-booking-container {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .diadiem-info {
            flex: 1 1 55%;
        }

        .diadiem-info h2 {
            margin-top: 0;
            font-size: 28px;
        }

        .diadiem-info p {
            margin: 6px 0;
            line-height: 1.5;
        }

        .booking-section {
            flex: 1 1 35%;
            background: #fdf6f0;
            padding: 20px;
            border-radius: 12px;
        }

        .booking-section h3 {
            margin-top: 0;
            font-size: 22px;
        }

        .booking-section form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .booking-section input[type="number"],
        .booking-section input[type="date"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .booking-section button {
            padding: 10px;
            background-color: #e67e22;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .booking-section button:hover {
            background-color: #d35400;
        }

        .content-container {
            max-width: 1235px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .content-section {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.04);
        }

        .content-section h2 {
            margin-top: 0;
            font-size: 24px;
            color: #2980b9;
        }

        .content-section p {
            font-size: 16px;
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .info-booking-container {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <!-- Hiển thị hình ảnh đại diện địa điểm -->
    <div class="diadiem-banner" style="max-width:1235px; margin:0 auto;">
        <img src="<?php echo htmlspecialchars($diadiem['hinh_anh']); ?>" alt="<?php echo htmlspecialchars($diadiem['ten']); ?>" style="width:100%; max-height:400px; object-fit:cover; border-radius:12px;" />
    </div>

    <!-- Phần thông tin địa điểm và đặt chỗ -->
    <div class="info-booking-container" style="max-width:1235px; margin:40px auto; padding:0 20px;">
        <div class="diadiem-info">
            <h2><?php echo htmlspecialchars($diadiem["ten"]); ?></h2>
            <p>📍 <?php echo htmlspecialchars($diadiem["dia_chi"]); ?></p>
            <p>Loại hình: <?php echo htmlspecialchars($diadiem["loai_hinh"]); ?></p>
            <p>💰 Khoảng giá: <?php echo htmlspecialchars($diadiem["khoang_gia"]); ?></p>
            <p><?php echo nl2br(htmlspecialchars($diadiem["mo_ta"])); ?></p>
        </div>
        <div class="booking-section">
            <h3>Đặt chỗ (Giảm 18%)</h3>
            <form method="POST" action="">
                <label>Người lớn:</label>
                <input type="number" name="adults" value="2" />
                <label>Trẻ em:</label>
                <input type="number" name="children" value="0" />
                <label>Thời gian đến:</label>
                <input type="date" name="date" />
                <button type="submit">Đặt chỗ ngay</button>
            </form>
            <?php if (isset($message)) echo "<p>$message</p>"; ?>
        </div>
    </div>

    <!-- Phần nội dung chi tiết -->
    <div class="content-container">
        <div class="content-section">
            <h2>Thông tin chi tiết</h2>
            <p><?php echo nl2br(htmlspecialchars($diadiem['mo_ta'])); ?></p>
        </div>
    </div>

<?php include_once 'includes/footer.php'; ?>
</body>
</html>