<?php
session_start();
// Include file kết nối database
require_once '../WebBlogsFood/config/database.php';

// Lấy dữ liệu bài viết từ bảng baiviet và thongke
$sql_articles = "
    SELECT b.id, b.tieude, b.noidung, b.ngay_dang, b.anh_minh_hoa, t.luot_xem 
    FROM baiviet b 
    LEFT JOIN thongke t ON b.id = t.baiviet_id 
    ORDER BY t.luot_xem DESC 
    LIMIT 6
";
$stmt_articles = $conn->prepare($sql_articles);
$stmt_articles->execute();
$articles = $stmt_articles->fetchAll(PDO::FETCH_ASSOC);

// Lấy dữ liệu bài viết xem nhiều nhất tháng
$sql_popular = "
    SELECT b.id, b.tieude, b.anh_minh_hoa, t.luot_xem 
    FROM baiviet b 
    LEFT JOIN thongke t ON b.id = t.baiviet_id 
    ORDER BY t.luot_xem DESC 
    LIMIT 10
";
$stmt_popular = $conn->prepare($sql_popular);
$stmt_popular->execute();
$popular_articles = $stmt_popular->fetchAll(PDO::FETCH_ASSOC);

// Lấy danh sách tag
$sql_tags = "SELECT ten FROM tag LIMIT 10";
$stmt_tags = $conn->prepare($sql_tags);
$stmt_tags->execute();
$tags = $stmt_tags->fetchAll(PDO::FETCH_ASSOC);

$logged_in = isset($_SESSION['user_id']);
$user_name = ($logged_in && isset($_SESSION['user_name'])) ? $_SESSION['user_name'] : "Người dùng";
?>

<?php include 'includes/header.php'; ?>

<!-- SLIDE -->
<div class="content-slider">
    <div class="slider-images">
        <div class="slider-image">
            <a href=""><img src="../WebBlogsFood/assets/images/home_1.jpg" alt="Slide 1" /></a>
        </div>
        <div class="slider-image">
            <a href=""><img src="../WebBlogsFood/assets/images/home_1.jpg" alt="Slide 2" /></a>
        </div>
        <div class="slider-image">
            <a href=""><img src="../WebBlogsFood/assets/images/home_1.jpg" alt="Slide 3" /></a>
        </div>
    </div>
    <button class="slider-prev" onclick="moveSlide(-1)">❮</button>
    <button class="slider-next" onclick="moveSlide(1)">❯</button>
</div>

<!-- DANH SÁCH BÀI VIẾT XEM NHIỀU NHẤT THÁNG -->
<div class="popular-posts">
    <h2>Xem nhiều nhất tháng</h2>
    <div class="popular-slider">
        <div class="popular-track">
            <?php foreach ($popular_articles as $article): ?>
            <div class="popular-item">
                <img src="<?php echo $article['anh_minh_hoa']; ?>" alt="Popular" />
                <p>
                    <a href="an_uongV2.php?id=<?php echo $article['id']; ?>">
                        <?php echo htmlspecialchars($article['tieude']); ?>
                    </a>
                </p>
            </div>
            <?php endforeach; ?>
        </div>
        <button class="popular-btn-next" onclick="slideMove(1)">❯</button>
        <button class="popular-btn-prev" onclick="slideMove(-1)">❮</button>
    </div>
</div>

<!-- NỘI DUNG CHÍNH -->
<div class="content-main">
    <div class="content-primary">
        <?php foreach ($articles as $article): ?>
        <div class="article-card">
            <img src="<?php echo $article['anh_minh_hoa']; ?>" alt="<?php echo htmlspecialchars($article['tieude']); ?>" />
            <div class="article-card-content">
                <p class="article-date">
                    📅 <?php echo date("d/m/Y", strtotime($article['ngay_dang'])); ?>
                </p>
                <h3><?php echo htmlspecialchars($article['tieude']); ?></h3>
                <p><?php echo htmlspecialchars(substr($article['noidung'], 0, 100)) . '...'; ?></p>
            </div>
        </div>
        <?php endforeach; ?>
        <div class="content-primary1">
    <div class="section-header1">
        <h2>Địa Điểm Ăn Uống</h2>
        <a href="anuong.php">Xem thêm ➝</a>
    </div>
    <?php
    // Lấy dữ liệu địa điểm ăn uống từ bảng diadiem_anuong
    $sql_locations = "
        SELECT id, ten, mo_ta, ngay_them, hinh_anh 
        FROM diadiem_anuong 
        ORDER BY ngay_them DESC 
        LIMIT 4
    ";
    $stmt_locations = $conn->prepare($sql_locations);
    $stmt_locations->execute();
    $locations = $stmt_locations->fetchAll(PDO::FETCH_ASSOC);

    foreach ($locations as $location): ?>
        <div class="article-card1">
            <img src="<?php echo htmlspecialchars($location['hinh_anh']); ?>" alt="<?php echo htmlspecialchars($location['ten']); ?>" />
            <div class="article-card-content1">
                <h3><?php echo htmlspecialchars($location['ten']); ?></h3>
                <p class="article-date1">
                    📅 <?php echo date("d/m/Y", strtotime($location['ngay_them'])); ?>
                </p>
                <p><?php echo htmlspecialchars(substr($location['mo_ta'], 0, 100)) . '...'; ?></p>
                <a href="an_uongV2.php?id=<?php echo $location['id']; ?>" class="btn-view">Xem chi tiết</a>
            </div>
        </div>
    <?php endforeach; ?>
</div>

    </div>
    <div class="content-sidebar">
        <input type="text" placeholder="Blogs: công thức nấu ăn, sức khỏe, ..." />
        <div class="tags-section">Từ khóa:</div>
        <div class="tags-list">
            <?php foreach ($tags as $tag): ?>
            <div class="tag-item" onclick="searchKeyword(this)">
                <?php echo htmlspecialchars($tag['ten']); ?>
            </div>
            <?php endforeach; ?>
        </div>
        <?php foreach ($articles as $article): ?>
            <img src="<?php echo $article['anh_minh_hoa']; ?>" alt="<?php echo htmlspecialchars($article['tieude']); ?>" />
        <?php endforeach; ?>
    </div>
    
</div>
<?php include 'includes/footer.php'; ?>
</body>
</html>