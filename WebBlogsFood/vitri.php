<?php
// vitri.php

// Kết nối database
require_once 'config/database.php';

// Lấy danh sách địa điểm (giả định danh_muc = 'diadiem')
$stmt_locations = $conn->prepare("
    SELECT b.* 
    FROM baiviet b 
    WHERE b.danh_muc = 'diadiem' 
    ORDER BY b.ngay_dang DESC 
    LIMIT 4
");
$stmt_locations->execute();
$locations = $stmt_locations->fetchAll(PDO::FETCH_ASSOC);
?>

<?php include 'includes/header.php'; ?>
<body>
     
        <div class="vt-page-header">
            <h1>Khám Phá Địa Điểm Gần Bạn</h1>
            <p>Tìm kiếm các nhà hàng, quán ăn và địa điểm thú vị gần bạn với bản đồ trực quan.</p>
        </div>

        <div class="vt-container">
            <div class="vt-left-panel">
                <?php if ($locations): ?>
                    <?php foreach ($locations as $location): ?>
                        <div class="vt-image-box">
                            <img src="<?php echo htmlspecialchars($location['anh_minh_hoa']); ?>" alt="<?php echo htmlspecialchars($location['tieude']); ?>">
                            <p><?php echo htmlspecialchars($location['tieude']); ?></p>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p>Chưa có địa điểm nào.</p>
                <?php endif; ?>
            </div>
            <div class="vt-map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.610567551395!2d106.69123561474514!3d10.76307139232812!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f1c3216972b%3A0x19a9f77f6b96b444!2zTcOhIHBoxqFuIHPDuqFuIEjGsG5nIFBoxrF0!5e0!3m2!1svi!2svi!4v1684307527961!5m2!1svi!2svi" allowfullscreen></iframe>
                <div class="vt-info-box">
                    <h3>Thông tin thêm</h3>
                    <ul>
                        <li>Điểm nổi bật 1</li>
                        <li>Điểm nổi bật 2</li>
                        <li>Điểm nổi bật 3</li>
                        <li>Điểm nổi bật 4</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <?php include 'includes/footer.php'; ?>
    </div>
</body>
</html>