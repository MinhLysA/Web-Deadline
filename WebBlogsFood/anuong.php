<!-- filepath: c:\xampp\htdocs\WebBlogsFood\templates\anuong.php -->
<?php
$title = "Trang Ăn Uống";
require_once 'config/database.php'; // Kết nối cơ sở dữ liệu
include 'includes/header.php'; // Header
?>

<div class="foodie-outer-wrap">
  <div class="foodie-main-content">
    <section class="foodie-primary-content">
      <div class="foodie-label-block">
        <div class="foodie-label-title">Danh sách món ăn</div>
        <div class="foodie-card-grid">
          <?php
          $limit = 4; // Số món ăn hiển thị trên mỗi trang
          $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
          $offset = ($page - 1) * $limit;

          $search = isset($_GET['search']) ? $_GET['search'] : '';
          $stmt = $conn->prepare("SELECT * FROM baiviet WHERE danh_muc = 'Ăn uống' AND tieude LIKE :search LIMIT :limit OFFSET :offset");
          $searchParam = "%$search%";
          $stmt->bindParam(':search', $searchParam, PDO::PARAM_STR);
          $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
          $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
          $stmt->execute();
          $baiviets = $stmt->fetchAll(PDO::FETCH_ASSOC);

          foreach ($baiviets as $baiviet) {
              echo "
              <div class='foodie-card-item'>
                <img src='{$baiviet['anh_minh_hoa']}' alt='{$baiviet['tieude']}' />
                <small>{$baiviet['tieude']}</small>
                <p>{$baiviet['noidung']}</p>
                <button onclick=\"location.href='an_uongV2.php?id={$baiviet['id']}'\">Xem thêm</button>
              </div>
              ";
          }
          ?>
        </div>
        <div class="foodie-page-nav">
          <?php if ($page > 1): ?>
            <a href="?page=<?php echo $page - 1; ?>" class="foodie-prev-link">Trang trước</a>
          <?php endif; ?>
          <a href="?page=<?php echo $page + 1; ?>" class="foodie-next-link">Trang sau</a>
        </div>
      </div>
    </section>

    <div class="foodie-highlight-block">
      <h2>Món ăn nổi bật</h2>
      <div class="foodie-highlight-grid">
        <?php
        $stmt = $conn->prepare("SELECT * FROM baiviet WHERE danh_muc = 'Ăn uống' ORDER BY ngay_dang DESC LIMIT 3");
        $stmt->execute();
        $featured = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($featured as $item) {
            echo "
            <div class='foodie-highlight-item'>
              <img src='{$item['anh_minh_hoa']}' alt='{$item['tieude']}' />
              <h3>{$item['tieude']}</h3>
              <p>" . substr($item['noidung'], 0, 100) . "...</p>
              <a href='an_uongV2.php?id={$item['id']}' class='foodie-view-btn'>Xem thêm</a>
            </div>
            ";
        }
        ?>
      </div>
    </div>

    <div class="foodie-category-block">
      <h2>Danh mục món ăn</h2>
      <ul class="foodie-category-menu">
        <?php
        $stmt = $conn->prepare("SELECT DISTINCT danh_muc FROM baiviet");
        $stmt->execute();
        $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($categories as $category) {
            echo "<li><a href='?danh_muc={$category['danh_muc']}'>{$category['danh_muc']}</a></li>";
        }
        ?>
      </ul>
    </div>

    <div class="foodie-rating-block">
      <h2>Đánh giá món ăn</h2>
      <form method="POST" action="" class="foodie-rating-form">
        <label for="rating">Chọn số sao:</label>
        <select name="rating" id="rating" class="foodie-rating-select">
          <option value="1">1 Sao</option>
          <option value="2">2 Sao</option>
          <option value="3">3 Sao</option>
          <option value="4">4 Sao</option>
          <option value="5">5 Sao</option>
        </select>
        <button type="submit" class="foodie-rating-submit">Gửi đánh giá</button>
      </form>
    </div>
  </div>
</div>

<?php include 'includes/footer.php'; // Footer ?>