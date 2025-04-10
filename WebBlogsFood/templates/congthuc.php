<!-- filepath: c:\xampp\htdocs\WebBlogsFood\templates\congthuc.php -->
<?php
$title = "Công Thức Nấu Ăn";
include '../config/database.php'; // Kết nối cơ sở dữ liệu
include '../includes/header.php'; // Header
?>

<div class="main-container">
  <section class="main-content">
    <div class="left-section">
      <?php
      // Lấy danh sách bài viết thuộc danh mục "Công thức nấu ăn"
      $search = isset($_GET['search']) ? $_GET['search'] : '';
      $stmt = $conn->prepare("SELECT * FROM baiviet WHERE danh_muc = 'Công thức nấu ăn' AND tieude LIKE :search ORDER BY ngay_dang DESC");
      $searchParam = "%$search%";
      $stmt->bindParam(':search', $searchParam, PDO::PARAM_STR);
      $stmt->execute();
      $baiviets = $stmt->fetchAll(PDO::FETCH_ASSOC);

      foreach ($baiviets as $baiviet) {
        echo "
        <div class='blog-post'>
          <div class='blog-image'>
            <img src='../images/{$baiviet['anh_minh_hoa']}' alt='{$baiviet['tieude']}' />
          </div>
          <div class='blog-details'>
            <div class='blog-meta'>
              <span class='author'>Tác giả: {$baiviet['tacgia_id']}</span>
              <span class='time'>Ngày đăng: {$baiviet['ngay_dang']}</span>
            </div>
            <h3 class='blog-title'>{$baiviet['tieude']}</h3>
            <p class='blog-summary'>" . substr($baiviet['noidung'], 0, 100) . "...</p>
            <a href='baiviet.php?id={$baiviet['id']}' class='read-more-btn'>Đọc thêm »</a>
          </div>
        </div>
        ";
      }
      ?>
    </div>

    <div class="right-section">
      <div class="category-box">
        <h3>Danh mục</h3>
        <ul>
          <?php
          // Lấy danh sách danh mục
          $stmt = $conn->prepare("SELECT DISTINCT danh_muc FROM baiviet");
          $stmt->execute();
          $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

          foreach ($categories as $category) {
            echo "<li><a href='?danh_muc={$category['danh_muc']}'>{$category['danh_muc']}</a></li>";
          }
          ?>
        </ul>
      </div>
    </div>
  </section>
</div>

<?php include '../includes/footer.php'; // Footer ?>