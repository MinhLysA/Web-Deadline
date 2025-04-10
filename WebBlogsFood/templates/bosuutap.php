<!-- filepath: c:\xampp\htdocs\WebBlogsFood\templates\bosuutap.php -->
<?php
$title = "Trang Bộ Sưu Tập";
include '../config/database.php'; // Kết nối cơ sở dữ liệu
include '../includes/header.php'; // Header
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
                <img src='../images/{$featured['anh_minh_hoa']}' alt='{$featured['tieude']}' />
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
      // Lấy danh sách bài viết
      $search = isset($_GET['search']) ? $_GET['search'] : '';
      $location = isset($_GET['location']) ? $_GET['location'] : '';
      $query = "SELECT * FROM baiviet WHERE tieude LIKE :search";
      if (!empty($location)) {
        $query .= " AND danh_muc = :location";
      }
      $stmt = $conn->prepare($query);
      $searchParam = "%$search%";
      $stmt->bindParam(':search', $searchParam, PDO::PARAM_STR);
      if (!empty($location)) {
        $stmt->bindParam(':location', $location, PDO::PARAM_STR);
      }
      $stmt->execute();
      $baiviets = $stmt->fetchAll(PDO::FETCH_ASSOC);

      foreach ($baiviets as $baiviet) {
        echo "
        <div class='bs-card'>
          <div class='bs-card-image'>
            <img src='../images/{$baiviet['anh_minh_hoa']}' alt='{$baiviet['tieude']}' />
          </div>
          <div class='bs-card-content'>
            <p>{$baiviet['tieude']}</p>
            <a href='baiviet.php?id={$baiviet['id']}' class='btn-view'>Xem thêm</a>
          </div>
        </div>
        ";
      }
      ?>
    </div>

    <div class="pagination">
      <a href="?page=1" class="pagination-link">1</a>
      <a href="?page=2" class="pagination-link">2</a>
      <a href="?page=3" class="pagination-link">3</a>
    </div>
  </section>
</div>

<?php include '../includes/footer.php'; // Footer ?>