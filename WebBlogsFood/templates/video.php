<?php
// video.php

// Kết nối database
require_once '../config/database.php';

// Lấy video nổi bật (giả định bài viết có lượt xem cao nhất)
$stmt_featured = $conn->prepare("
    SELECT b.*, t.luot_xem 
    FROM baiviet b 
    LEFT JOIN thongke t ON b.id = t.baiviet_id 
    ORDER BY t.luot_xem DESC 
    LIMIT 1
");
$stmt_featured->execute();
$featured_video = $stmt_featured->fetch(PDO::FETCH_ASSOC);

// Lấy danh sách video (4 bài viết mới nhất)
$stmt_list = $conn->prepare("
    SELECT b.* 
    FROM baiviet b 
    WHERE b.danh_muc = 'video' 
    ORDER BY b.ngay_dang DESC 
    LIMIT 4
");
$stmt_list->execute();
$video_list = $stmt_list->fetchAll(PDO::FETCH_ASSOC);

// Lấy tất cả video (2 bài đầu tiên, có thể mở rộng bằng "Tải thêm")
$stmt_all = $conn->prepare("
    SELECT b.* 
    FROM baiviet b 
    WHERE b.danh_muc = 'video' 
    ORDER BY b.ngay_dang DESC 
    LIMIT 2 OFFSET 4
");
$stmt_all->execute();
$all_videos = $stmt_all->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Trang Video</title>
    <link rel="stylesheet" href="css/header.css" />
    <link rel="stylesheet" href="css/style_video.css" />
    <script src="js/kt.js" defer></script>
</head>
<body>
    <!-- HEADER -->
    <?php include '../includes/header.php'; ?>


    <!-- NỘI DUNG VIDEO -->
    <div class="content-container">
        <!-- Video Nổi Bật -->
        <div class="section-container">
            <h2 class="section-title">Video Nổi Bật</h2>
            <div class="main-video-section">
                <?php if ($featured_video): ?>
                    <a href="video_detail.php?id=<?php echo $featured_video['id']; ?>" class="video-link" aria-label="Xem video nổi bật">
                        <div class="video-placeholder" style="background-image: url('<?php echo $featured_video['anh_minh_hoa']; ?>');"></div>
                    </a>
                    <a href="video_detail.php?id=<?php echo $featured_video['id']; ?>" class="play-button" aria-label="Phát video">▶</a>
                    <p class="video-description"><?php echo htmlspecialchars($featured_video['tieude']); ?></p>
                <?php else: ?>
                    <p>Chưa có video nổi bật.</p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Danh Sách Video -->
        <div class="section-container">
            <h2 class="section-title">Danh Sách Video</h2>
            <div class="video-thumbnails">
                <?php foreach ($video_list as $video): ?>
                    <div class="thumbnail">
                        <a href="video_detail.php?id=<?php echo $video['id']; ?>" class="video-link" aria-label="Xem video <?php echo htmlspecialchars($video['tieude']); ?>">
                            <div class="video-placeholder" style="background-image: url('<?php echo $video['anh_minh_hoa']; ?>');"></div>
                        </a>
                        <p class="video-description"><?php echo htmlspecialchars($video['tieude']); ?></p>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- Tất Cả Video -->
        <div class="section-container">
            <h2 class="section-title">Tất Cả Video</h2>
            <div class="video-grid">
                <?php foreach ($all_videos as $video): ?>
                    <div class="video-grid-item">
                        <a href="video_detail.php?id=<?php echo $video['id']; ?>" class="video-link" aria-label="Xem video <?php echo htmlspecialchars($video['tieude']); ?>">
                            <div class="video-placeholder" style="background-image: url('<?php echo $video['anh_minh_hoa']; ?>');"></div>
                        </a>
                        <p class="video-description"><?php echo htmlspecialchars($video['tieude']); ?></p>
                        <a href="video_detail.php?id=<?php echo $video['id']; ?>" class="btn-view">Xem thêm</a>
                    </div>
                <?php endforeach; ?>
            </div>
            <button class="load-more-btn">Tải thêm video</button>
        </div>
    </div>

    <!-- FOOTER -->
    <?php include '../includes/footer.php'; ?>
</body>
</html>