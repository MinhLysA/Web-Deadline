<?php
require_once 'config/database.php'; // kết nối DB
session_start();

$page_title = "Trang Chi Tiết Món Ăn";

// Giả sử ID món ăn được truyền qua URL (ví dụ: chitiet.php?id=1)
$monan_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Lấy thông tin món ăn từ DB
$sql_restaurant = "SELECT * FROM monan WHERE id = ?";
$stmt = $conn->prepare($sql_restaurant);
$stmt->execute([$monan_id]);
$restaurant = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$restaurant) {
    die("Không tìm thấy món ăn.");
}

// Lấy các mục nội dung chi tiết của món ăn
$sql_content = "SELECT muc, tieu_de, noi_dung FROM noidung_monan WHERE monan_id = ?";
$stmt = $conn->prepare($sql_content);
$stmt->execute([$monan_id]);
$content_sections = [];
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    // Sử dụng giá trị của cột "muc" làm anchor (ví dụ: de-xuat, tom-tat, bang-gia, quy-dinh)
    $id = $row['muc'];
    $content_sections[$id] = [
        'title'   => $row['tieu_de'],
        'content' => $row['noi_dung']
    ];
}

// Xử lý đặt chỗ
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $adults   = $_POST["adults"];
    $children = $_POST["children"];
    $date     = $_POST["date"];
    $message  = "Đặt chỗ thành công cho $adults người lớn và $children trẻ em vào ngày $date!";
}
?>

<?php include_once 'includes/header.php'; ?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?php echo htmlspecialchars($page_title); ?></title>
    
    <script src="js/kt.js" defer></script>
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

  .monan-banner img {
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

  .restaurant-info {
    flex: 1 1 55%;
  }

  .restaurant-info h2 {
    margin-top: 0;
    font-size: 28px;
  }

  .restaurant-info p {
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

  .menu-container-wrapper {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 30px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.06);
  }

  .menu-nav ul {
    list-style: none;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin: 0;
  }

  .menu-nav ul li a {
    text-decoration: none;
    color: #34495e;
    font-weight: bold;
    padding: 6px 14px;
    background-color: #ecf0f1;
    border-radius: 8px;
    transition: background 0.3s;
  }

  .menu-nav ul li a:hover {
    background-color: #dcdde1;
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

    .menu-nav ul {
      flex-direction: column;
      gap: 10px;
    }
  }
</style>

</head>

<body>
    <!-- Hiển thị hình ảnh đại diện món ăn -->
    <div class="monan-banner" style="max-width:1235px; margin:0 auto;">
        <img src="<?php echo htmlspecialchars($restaurant['hinh_anh']); ?>" alt="<?php echo htmlspecialchars($restaurant['ten']); ?>" style="width:100%; max-height:400px; object-fit:cover; border-radius:12px;" />
    </div>

    <!-- Phần thông tin món ăn và đặt chỗ -->
    <div class="info-booking-container" style="max-width:1235px; margin:40px auto; padding:0 20px;">
        <div class="restaurant-info">
            <h2><?php echo htmlspecialchars($restaurant["ten"]); ?></h2>
            <p>📍 <?php echo htmlspecialchars($restaurant["dia_chi"]); ?></p>
            <p>Loại hình: <?php echo htmlspecialchars($restaurant["loai_hinh"]); ?></p>
            <p>💰 Khoảng giá: <?php echo htmlspecialchars($restaurant["gia"]); ?></p>
            <p><?php echo nl2br(htmlspecialchars($restaurant["mo_ta"])); ?></p>
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

    <!-- Phần menu mục lục và nội dung chi tiết -->
    <div class="content-container">
        <div class="menu-container-wrapper">
            <div class="menu-nav-container">
                <div class="menu-nav">
                    <ul>
                        <?php foreach ($content_sections as $id => $section): ?>
                            <li><a href="#<?php echo $id; ?>"><?php echo htmlspecialchars($section['title']); ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </div>
        </div>
        <?php foreach ($content_sections as $id => $section): ?>
            <div id="<?php echo $id; ?>" class="content-section">
                <h2><?php echo htmlspecialchars($section['title']); ?></h2>
                <p><?php echo nl2br(htmlspecialchars($section['content'])); ?></p>
            </div>
        <?php endforeach; ?>
    </div>

<?php include_once 'includes/footer.php'; ?>
</body>
</html>
