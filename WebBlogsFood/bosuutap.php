<!-- filepath: c:\xampp\htdocs\WebBlogsFood\templates\bosuutap.php -->
<?php
$title = "Trang Bộ Sưu Tập";
include 'config/database.php'; // Kết nối cơ sở dữ liệu
include 'includes/header.php'; // Header

// Số bài viết trên mỗi trang
$posts_per_page = 8;

// Xác định trang hiện tại
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
if ($page < 1) $page = 1;

// Tính offset (vị trí bắt đầu của bài viết)
$offset = ($page - 1) * $posts_per_page;

// Tìm kiếm và lọc theo danh mục
$search = isset($_GET['search']) ? $_GET['search'] : '';
$location = isset($_GET['location']) ? $_GET['location'] : '';

// Đếm tổng số bài viết để tính số trang
$query_count = "SELECT COUNT(*) as total FROM baiviet WHERE tieude LIKE :search";
if (!empty($location)) {
    $query_count .= " AND danh_muc = :location";
}
$stmt_count = $conn->prepare($query_count);
$searchParam = "%$search%";
$stmt_count->bindParam(':search', $searchParam, PDO::PARAM_STR);
if (!empty($location)) {
    $stmt_count->bindParam(':location', $location, PDO::PARAM_STR);
}
$stmt_count->execute();
$total_posts = $stmt_count->fetch(PDO::FETCH_ASSOC)['total'];

// Tính tổng số trang
$total_pages = ceil($total_posts / $posts_per_page);
if ($page > $total_pages && $total_pages > 0) {
    $page = $total_pages;
    $offset = ($page - 1) * $posts_per_page;
}
?>

<div class="main-container">
  <section class="bs-content">
    <div class="bs-label-section">
      <div class="bs-label-title">Bộ Sưu Tập Nổi Bật</div>
      <div class="bs-slider">
        <div class="bs-slider-wrapper">
          <?php
          // Lấy bài viết nổi bật (giả sử bài viết mới nhất là nổi bật)
          $stmt = $conn->prepare("SELECT * FROM baiviet ORDER BY ngay_dang DESC LIMIT 3");
          $stmt->execute();
          $featuredPosts = $stmt->fetchAll(PDO::FETCH_ASSOC);

          foreach ($featuredPosts as $featured) {
            echo "
            <div class='bs-slider-item'>
              <a href='baiviet.php?id={$featured['id']}'>
                <img src='/WebBlogsFood/{$featured['anh_minh_hoa']}' alt='{$featured['tieude']}' />
              </a>
              <p>{$featured['tieude']}</p>
            </div>
            ";
          }
          ?>
        </div>
        <button class="bs-slider-prev">&lt;</button>
        <button class="bs-slider-next">&gt;</button>
      </div>
    </div>

    <div class="bs-card-section">
      <?php
      // Lấy danh sách bài viết với phân trang
      $query = "SELECT * FROM baiviet WHERE tieude LIKE :search";
      if (!empty($location)) {
        $query .= " AND danh_muc = :location";
      }
      $query .= " LIMIT :limit OFFSET :offset";
      
      $stmt = $conn->prepare($query);
      $searchParam = "%$search%";
      $stmt->bindParam(':search', $searchParam, PDO::PARAM_STR);
      if (!empty($location)) {
        $stmt->bindParam(':location', $location, PDO::PARAM_STR);
      }
      $stmt->bindParam(':limit', $posts_per_page, PDO::PARAM_INT);
      $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
      $stmt->execute();
      $baiviets = $stmt->fetchAll(PDO::FETCH_ASSOC);

      foreach ($baiviets as $baiviet) {
        echo "
        <div class='bs-card'>
          <div class='bs-card-image'>
            <img src='/WebBlogsFood/{$baiviet['anh_minh_hoa']}' alt='{$baiviet['tieude']}' />
          </div>
          <div class='bs-card-content'>
            <p>{$baiviet['tieude']}</p>
            <a href='an_uongV2.php?id={$baiviet['id']}' class='btn-view'>Xem thêm</a>
          </div>
        </div>
        ";
      }
      ?>
    </div>

    <div class="pagination">
      <?php
      // Hiển thị các liên kết phân trang
      $query_string = http_build_query([
          'search' => $search,
          'location' => $location
      ]);

      // Liên kết "Trang trước"
      if ($page > 1) {
          echo "<a href='bosuutap.php?page=" . ($page - 1) . "&$query_string' class='pagination-link'>Trang trước</a>";
      }

      // Hiển thị các số trang
      for ($i = 1; $i <= $total_pages; $i++) {
          if ($i == $page) {
              echo "<a href='bosuutap.php?page=$i&$query_string' class='pagination-link active'>$i</a>";
          } else {
              echo "<a href='bosuutap.php?page=$i&$query_string' class='pagination-link'>$i</a>";
          }
      }

      // Liên kết "Trang sau"
      if ($page < $total_pages) {
          echo "<a href='bosuutap.php?page=" . ($page + 1) . "&$query_string' class='pagination-link'>Trang sau</a>";
      }
      ?>
    </div>
  </section>
</div>

<?php include 'includes/footer.php'; // Footer ?>
