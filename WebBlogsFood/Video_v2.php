<?php
require_once 'config/database.php'; // Kết nối DB
session_start();

$restaurant_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($restaurant_id === 0) {
    die("Nhà hàng không tồn tại.");
}

// Lấy thông tin nhà hàng
$sql_restaurant = "SELECT * FROM restaurants WHERE id = ?";
$stmt = $conn->prepare($sql_restaurant);
$stmt->execute([$restaurant_id]);
$restaurant = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$restaurant) {
    die("Không tìm thấy nhà hàng.");
}

// Lấy video
$sql_video = "SELECT * FROM videos WHERE restaurant_id = ?";
$stmt = $conn->prepare($sql_video);
$stmt->execute([$restaurant_id]);
$video = $stmt->fetch(PDO::FETCH_ASSOC);

// Lấy thực đơn đặc biệt
$sql_menus = "SELECT * FROM special_menus WHERE restaurant_id = ?";
$stmt = $conn->prepare($sql_menus);
$stmt->execute([$restaurant_id]);
$menus = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy ưu đãi
$sql_offers = "SELECT * FROM offers WHERE restaurant_id = ?";
$stmt = $conn->prepare($sql_offers);
$stmt->execute([$restaurant_id]);
$offers = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<?php include 'includes/header.php'; ?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($restaurant['name']); ?></title>
    <style>
        .video-page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
            font-family: Arial, sans-serif;
        }

        .video-header h1 {
            font-size: 32px;
            color: #333;
        }

        .video-header p {
            font-size: 16px;
            color: #555;
        }

        .video-player-section video {
            width: 100%;
            max-height: 500px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .menu-items {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .menu-item, .offer {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 12px;
            flex: 1 1 45%;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .menu-item img {
            width: 100%;
            border-radius: 10px;
            object-fit: cover;
            height: 200px;
            margin-bottom: 10px;
        }

        h2 {
            margin-top: 40px;
            font-size: 24px;
            color: #222;
        }

        .see-more {
            display: inline-block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }

        .see-more:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="video-page-wrapper">
    <div class="video-header">
        <h1><?php echo htmlspecialchars($restaurant['name']); ?></h1>
        <p><?php echo nl2br(htmlspecialchars($restaurant['description'])); ?></p>
    </div>

    <?php if ($video): ?>
        <div class="video-player-section">
        <?php
            $video_url = htmlspecialchars($video['video_url']);
            if (strpos($video_url, 'youtube.com') !== false || strpos($video_url, 'youtu.be') !== false):
                // Lấy ID video từ URL
                preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/)([^\&\?\/]+)/', $video_url, $matches);
                $youtube_id = $matches[1] ?? '';
            ?>
                <iframe width="100%" height="500" src="https://www.youtube.com/embed/<?php echo $youtube_id; ?>" 
                    frameborder="0" allowfullscreen style="border-radius: 12px; margin: 20px 0;"></iframe>
            <?php else: ?>
                <video controls>
                    <source src="<?php echo $video_url; ?>" type="video/mp4">
                    Trình duyệt của bạn không hỗ trợ video.
    </video>
<?php endif; ?>

            <p><?php echo nl2br(htmlspecialchars($video['description'])); ?></p>
        </div>
    <?php else: ?>
        <p>Hiện nhà hàng chưa có video.</p>
    <?php endif; ?>

    <h2>Thực đơn đặc biệt</h2>
    <div class="menu-items">
        <?php foreach ($menus as $menu): ?>
            <div class="menu-item">
                <img src="<?php echo htmlspecialchars($menu['image_url']); ?>" alt="<?php echo htmlspecialchars($menu['name']); ?>">
                <h3><?php echo htmlspecialchars($menu['name']); ?></h3>
                <p><?php echo nl2br(htmlspecialchars($menu['description'])); ?></p>
            </div>
        <?php endforeach; ?>
    </div>
    <a href="menu.php?id=<?php echo $restaurant_id; ?>" class="see-more">Xem chi tiết thực đơn</a>

    <h2>Ưu đãi và khuyến mãi</h2>
    <div class="offers">
        <?php foreach ($offers as $offer): ?>
            <div class="offer">
                <h3><?php echo htmlspecialchars($offer['title']); ?></h3>
                <p><?php echo nl2br(htmlspecialchars($offer['description'])); ?></p>
            </div>
        <?php endforeach; ?>
    </div>
    <a href="offers.php?id=<?php echo $restaurant_id; ?>" class="see-more">Xem chi tiết ưu đãi</a>
</div>

<?php include 'includes/footer.php'; ?>
</body>
</html>
