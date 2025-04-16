<?php
session_start();
require_once 'config/database.php';

$page_title = "Tìm kiếm công thức món ăn";

// Lấy truy vấn tìm kiếm và địa điểm từ tham số GET
$search_query = isset($_GET['query']) ? trim($_GET['query']) : '';
$location = isset($_GET['location']) ? trim($_GET['location']) : '';

// Khởi tạo biến
$recipes = [];
$search_performed = !empty($search_query);

if ($search_performed) {
    // Chuẩn bị câu lệnh SQL để tìm kiếm công thức theo tiêu đề, thẻ hoặc nguyên liệu
    $sql = "
        SELECT DISTINCT b.id, b.tieude, b.noidung, b.ngay_dang, b.anh_minh_hoa, t.luot_xem 
        FROM baiviet b 
        LEFT JOIN thongke t ON b.id = t.baiviet_id
        LEFT JOIN baiviet_tag bt ON b.id = bt.baiviet_id
        LEFT JOIN tag tg ON bt.tag_id = tg.id
        LEFT JOIN congthuc_nguyenlieu cn ON b.id = cn.baiviet_id
        LEFT JOIN nguyenlieu n ON cn.nguyenlieu_id = n.id
        WHERE b.danh_muc = 'Công thức nấu ăn'
        AND (
            b.tieude LIKE :query
            OR tg.ten LIKE :query
            OR n.ten LIKE :query
        )
        ORDER BY t.luot_xem DESC 
        LIMIT 20
    ";
    
    $stmt = $conn->prepare($sql);
    $search_param = "%$search_query%";
    $stmt->bindParam(':query', $search_param, PDO::PARAM_STR);
    $stmt->execute();
    $recipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

$logged_in = isset($_SESSION['user_id']);
$user_name = ($logged_in && isset($_SESSION['user_name'])) ? $_SESSION['user_name'] : "Người dùng";
?>

<?php include 'includes/header.php'; ?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?php echo htmlspecialchars($page_title); ?></title>
    <style>
        .search-results {
            max-width: 1235px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .search-results h2 {
            color: #d35400;
            font-size: 28px;
            margin-bottom: 20px;
        }
        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .recipe-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .recipe-card:hover {
            transform: translateY(-5px);
        }
        .recipe-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .recipe-card-content {
            padding: 15px;
        }
        .recipe-card-content h3 {
            margin: 0 0 10px;
            font-size: 20px;
            color: #333;
        }
        .recipe-card-content p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }
        .recipe-card-content .article-date {
            color: #e67e22;
            font-weight: bold;
        }
        .no-results {
            text-align: center;
            color: #666;
            font-size: 18px;
            margin: 40px 0;
        }
    </style>
</head>
<body>
    <div class="search-results">
        <h2>Kết quả tìm kiếm cho "<?php echo htmlspecialchars($search_query); ?>"</h2>
        <?php if ($search_performed): ?>
            <?php if (count($recipes) > 0): ?>
                <div class="recipe-grid">
                    <?php foreach ($recipes as $recipe): ?>
                        <div class="recipe-card">
                            <a href="CongThucV2.php?id=<?php echo $recipe['id']; ?>">
                                <img src="<?php echo htmlspecialchars($recipe['anh_minh_hoa']); ?>" alt="<?php echo htmlspecialchars($recipe['tieude']); ?>" />
                            </a>
                            <div class="recipe-card-content">
                                <h3><a href="CongThucV2.php?id=<?php echo $recipe['id']; ?>"><?php echo htmlspecialchars($recipe['tieude']); ?></a></h3>
                                <p class="article-date">📅 <?php echo date("d/m/Y", strtotime($recipe['ngay_dang'])); ?></p>
                                <p><?php echo htmlspecialchars(substr($recipe['noidung'], 0, 100)) . '...'; ?></p>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <p class="no-results">Không tìm thấy công thức nào phù hợp với từ khóa "<?php echo htmlspecialchars($search_query); ?>".</p>
            <?php endif; ?>
        <?php else: ?>
            <p class="no-results">Vui lòng nhập từ khóa để tìm kiếm công thức món ăn.</p>
        <?php endif; ?>
    </div>

    <?php include 'includes/footer.php'; ?>
</body>
</html>