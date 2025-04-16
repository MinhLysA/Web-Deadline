<?php
session_start();
require_once 'config/database.php';

// Lấy ID bài viết từ URL
$baiviet_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Lấy thông tin bài viết
$stmt = $conn->prepare("
    SELECT b.id, b.tieude, b.noidung, b.ngay_dang, b.anh_minh_hoa, b.danh_muc, 
           b.thoi_gian_chuan_bi, b.thoi_gian_nau, b.so_khau_phan, b.muc_do_kho, 
           b.thong_tin_dinh_duong, n.ten AS tacgia 
    FROM baiviet b 
    JOIN nguoidung n ON b.tacgia_id = n.id 
    WHERE b.id = ?
");
$stmt->execute([$baiviet_id]);
$recipe = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$recipe) {
    die("Công thức không tồn tại!");
}

// Lấy nguyên liệu
$stmt = $conn->prepare("
    SELECT cn.so_luong, cn.ghi_chu, n.ten AS nguyenlieu, n.mota, n.anh_minh_hoa, n.don_vi 
    FROM congthuc_nguyenlieu cn 
    JOIN nguyenlieu n ON cn.nguyenlieu_id = n.id 
    WHERE cn.baiviet_id = ?
");
$stmt->execute([$baiviet_id]);
$nguyenlieu = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy các bước làm
$stmt = $conn->prepare("
    SELECT buoc_so, noi_dung, anh_minh_hoa, thoi_gian_thuc_hien 
    FROM cac_buoc_lam 
    WHERE baiviet_id = ? 
    ORDER BY buoc_so
");
$stmt->execute([$baiviet_id]);
$buoc_lam = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy mẹo nấu ăn
$stmt = $conn->prepare("
    SELECT noi_dung, loai 
    FROM meo_nau_an 
    WHERE baiviet_id = ?
");
$stmt->execute([$baiviet_id]);
$meo_nau_an = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy danh sách ảnh minh họa
$stmt = $conn->prepare("SELECT image_url FROM baiviet_images WHERE baiviet_id = ?");
$stmt->execute([$baiviet_id]);
$images = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy danh sách bình luận
$stmt = $conn->prepare("
    SELECT bl.id, bl.noidung, bl.thoi_gian, n.ten AS nguoidung_ten, n.avatar 
    FROM binhluan bl 
    JOIN nguoidung n ON bl.nguoidung_id = n.id 
    WHERE bl.baiviet_id = ? 
    ORDER BY bl.thoi_gian DESC
");
$stmt->execute([$baiviet_id]);
$comments = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy số lượt thích
$stmt = $conn->prepare("SELECT COUNT(*) AS luot_thich FROM thich WHERE baiviet_id = ?");
$stmt->execute([$baiviet_id]);
$luot_thich = $stmt->fetch(PDO::FETCH_ASSOC)['luot_thich'];

// Lấy điểm đánh giá trung bình
$stmt = $conn->prepare("
    SELECT AVG(diem) AS diem_trung_binh, COUNT(*) AS so_danh_gia 
    FROM danhgia 
    WHERE baiviet_id = ?
");
$stmt->execute([$baiviet_id]);
$rating = $stmt->fetch(PDO::FETCH_ASSOC);
$diem_trung_binh = round($rating['diem_trung_binh'], 1);
$so_danh_gia = $rating['so_danh_gia'];
?>

<?php include 'includes/header.php'; ?>

<div class="recipe-container">
    <!-- Nội dung công thức (2/3) -->
    <div class="recipe-content">
        <h1><?php echo htmlspecialchars($recipe['tieude']); ?></h1>
        <div class="recipe-meta">
            <span>Tác giả: <?php echo htmlspecialchars($recipe['tacgia']); ?></span>
            <span>Ngày đăng: <?php echo $recipe['ngay_dang']; ?></span>
            <span>Danh mục: <?php echo htmlspecialchars($recipe['danh_muc']); ?></span>
            <span>Thời gian chuẩn bị: <?php echo $recipe['thoi_gian_chuan_bi']; ?> phút</span>
            <span>Thời gian nấu: <?php echo $recipe['thoi_gian_nau']; ?> phút</span>
            <span>Khẩu phần: <?php echo $recipe['so_khau_phan']; ?> người</span>
            <span>Mức độ khó: <?php echo $recipe['muc_do_kho']; ?></span>
        </div>
        <img src="<?php echo htmlspecialchars($recipe['anh_minh_hoa']); ?>" alt="Ảnh minh họa" class="main-image">
        <div class="content">
            <?php echo nl2br(htmlspecialchars($recipe['noidung'])); ?>
        </div>

        <!-- Thông tin dinh dưỡng -->
        <?php if ($recipe['thong_tin_dinh_duong']): ?>
            <div class="nutrition-info">
                <h3>Thông tin dinh dưỡng</h3>
                <p><?php echo nl2br(htmlspecialchars($recipe['thong_tin_dinh_duong'])); ?></p>
            </div>
        <?php endif; ?>

        <!-- Nguyên liệu -->
        <div class="ingredients">
            <h3>Nguyên liệu</h3>
            <ul>
                <?php foreach ($nguyenlieu as $item): ?>
                    <li>
                        <?php if ($item['anh_minh_hoa']): ?>
                            <img src="<?php echo htmlspecialchars($item['anh_minh_hoa']); ?>" alt="<?php echo htmlspecialchars($item['nguyenlieu']); ?>">
                        <?php endif; ?>
                        <div class="info">
                            <strong><?php echo htmlspecialchars($item['nguyenlieu']); ?></strong>
                            (<?php echo htmlspecialchars($item['so_luong']); ?> <?php echo htmlspecialchars($item['don_vi']); ?>)
                            <?php if ($item['ghi_chu']): ?>
                                <p class="note"><?php echo htmlspecialchars($item['ghi_chu']); ?></p>
                            <?php endif; ?>
                            <?php if ($item['mota']): ?>
                                <p class="mota"><?php echo htmlspecialchars($item['mota']); ?></p>
                            <?php endif; ?>
                        </div>
                    </li>
                <?php endforeach; ?>
            </ul>
        </div>

        <!-- Các bước làm -->
        <div class="steps">
            <h3>Các bước làm</h3>
            <ol>
                <?php foreach ($buoc_lam as $buoc): ?>
                    <li>
                        <?php echo htmlspecialchars($buoc['noi_dung']); ?>
                        <?php if ($buoc['anh_minh_hoa']): ?>
                        <?php endif; ?>
                        <?php if ($buoc['thoi_gian_thuc_hien']): ?>
                            <p class="time">(Thời gian: <?php echo $buoc['thoi_gian_thuc_hien']; ?> phút)</p>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ol>
        </div>

        <!-- Mẹo nấu ăn -->
        <?php if ($meo_nau_an): ?>
            <div class="tips">
                <h3>Mẹo và Lưu ý</h3>
                <ul>
                    <?php foreach ($meo_nau_an as $meo): ?>
                        <li>
                            <strong><?php echo htmlspecialchars($meo['loai']); ?>:</strong>
                            <?php echo htmlspecialchars($meo['noi_dung']); ?>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
    </div>

    <!-- Sidebar (1/3) -->
    <div class="recipe-sidebar">
        <!-- Hình ảnh món ăn -->
        <?php foreach ($images as $image): ?>
            <img src="<?php echo htmlspecialchars($image['image_url']); ?>" alt="Ảnh món ăn">
        <?php endforeach; ?>

        <!-- Phần đánh giá -->
        <div class="rating-section">
            <h3>Đánh giá công thức</h3>
            <div class="rating-stars" data-baiviet-id="<?php echo $baiviet_id; ?>">
                <?php for ($i = 1; $i <= 5; $i++): ?>
                    <span class="star" data-value="<?php echo $i; ?>">★</span>
                <?php endfor; ?>
            </div>
            <div class="rating-info">
                Điểm trung bình: <?php echo $diem_trung_binh; ?>/5 (<?php echo $so_danh_gia; ?> đánh giá)
            </div>
        </div>

        <!-- Phần bình luận -->
        <div class="comment-section">
            <div class="comment-actions">
                <button class="like-btn">Thích <?php echo $luot_thich; ?></button>
                <button class="share-btn">Chia sẻ</button>
            </div>
            <div class="comment-count">
                <?php echo count($comments); ?> bình luận
            </div>
            <div class="comment-form">
                <?php
                $user_avatar = 'assets/images/default-avatar.jpg';
                if (isset($_SESSION['user_id'])) {
                    $stmt = $conn->prepare("SELECT avatar FROM nguoidung WHERE id = ?");
                    $stmt->execute([$_SESSION['user_id']]);
                    $user = $stmt->fetch(PDO::FETCH_ASSOC);
                    if ($user && $user['avatar'] && file_exists($user['avatar'])) {
                        $user_avatar = htmlspecialchars($user['avatar']);
                    }
                }
                ?>
    <img src="<?php echo $user_avatar; ?>" alt="Avatar">
    <textarea placeholder="Bình luận..." id="comment-content"></textarea>
</div>
            <div class="comment-list">
                <?php foreach ($comments as $comment): ?>
                    <div class="comment">
                        <img src="<?php echo $comment['avatar'] ? htmlspecialchars($comment['avatar']) : 'assets/images/default-avatar.jpg'; ?>" alt="Avatar">
                        <div class="comment-content">
                            <p><strong><?php echo htmlspecialchars($comment['nguoidung_ten']); ?></strong></p>
                            <p><?php echo htmlspecialchars($comment['noidung']); ?></p>
                            <div class="meta"><?php echo $comment['thoi_gian']; ?></div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</div>

<?php include 'includes/footer.php'; ?>

<script>
// Xử lý đánh giá sao
document.querySelectorAll('.rating-stars .star').forEach(star => {
    star.addEventListener('click', function() {
        const rating = this.getAttribute('data-value');
        const baivietId = this.parentElement.getAttribute('data-baiviet-id');

        fetch('submit_rating.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `baiviet_id=${baivietId}&diem=${rating}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Đánh giá thành công!');
                location.reload();
            } else {
                alert('Lỗi: ' + data.message);
            }
        })
        .catch(error => console.error('Lỗi:', error));
    });
});

// Xử lý gửi bình luận
document.querySelector('.comment-form textarea').addEventListener('keypress', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        const noidung = this.value.trim();
        const baivietId = <?php echo $baiviet_id; ?>;

        if (noidung) {
            fetch('submit_comment.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `baiviet_id=${baivietId}&noidung=${encodeURIComponent(noidung)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Bình luận thành công!');
                    location.reload();
                } else {
                    alert('Lỗi: ' + data.message);
                }
            })
            .catch(error => console.error('Lỗi:', error));
        }
    }
});

// Xử lý nút Thích
document.querySelector('.like-btn').addEventListener('click', function() {
    const baivietId = <?php echo $baiviet_id; ?>;

    fetch('submit_like.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `baiviet_id=${baivietId}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Thích bài viết thành công!');
            location.reload();
        } else {
            alert('Lỗi: ' + data.message);
        }
    })
    .catch(error => console.error('Lỗi:', error));
});
</script>
</body>
</html>