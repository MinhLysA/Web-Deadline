-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 23, 2025 lúc 10:53 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webblogfood`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account_activation`
--

CREATE TABLE `account_activation` (
  `id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `thoi_gian_het_han` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `baiviet`
--

CREATE TABLE `baiviet` (
  `id` int(11) NOT NULL,
  `tieude` varchar(255) NOT NULL,
  `noidung` text NOT NULL,
  `tacgia_id` int(11) DEFAULT NULL,
  `ngay_dang` date DEFAULT curdate(),
  `anh_minh_hoa` varchar(255) DEFAULT NULL,
  `danh_muc` varchar(50) DEFAULT NULL,
  `thoi_gian_chuan_bi` int(11) DEFAULT NULL COMMENT 'Thời gian chuẩn bị (phút)',
  `thoi_gian_nau` int(11) DEFAULT NULL COMMENT 'Thời gian nấu (phút)',
  `so_khau_phan` int(11) DEFAULT NULL COMMENT 'Số khẩu phần (người)',
  `muc_do_kho` enum('Dễ','Trung bình','Khó') DEFAULT NULL COMMENT 'Mức độ khó của công thức',
  `thong_tin_dinh_duong` text DEFAULT NULL COMMENT 'Thông tin dinh dưỡng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `baiviet`
--

INSERT INTO `baiviet` (`id`, `tieude`, `noidung`, `tacgia_id`, `ngay_dang`, `anh_minh_hoa`, `danh_muc`, `thoi_gian_chuan_bi`, `thoi_gian_nau`, `so_khau_phan`, `muc_do_kho`, `thong_tin_dinh_duong`) VALUES
(1, 'Phở 24 ', 'Hướng dẫn chi tiết cách làm bánh mì ngon tại nhà...', 65, '2025-03-25', 'images/pho.jpg', 'Món Việt', NULL, NULL, NULL, NULL, NULL),
(2, 'Bún Chả Hàng Mành', 'Công thức chế biến món chay hấp dẫn...', 2, '2025-03-26', 'images/buncha.jpg', 'Món Âu', NULL, NULL, NULL, NULL, NULL),
(3, 'Cơm Tấm Ba Ghiền', 'Bí quyết để có tô phở bò thơm ngon...', 13, '2025-03-24', 'images/comtam.jpg', 'Món chay', NULL, NULL, NULL, NULL, NULL),
(4, 'Lẩu Thái 123', 'Hướng dẫn từng bước để làm bánh mì thơm ngon...', 66, '2025-03-25', 'images/lauthai.jpg', 'Món nướng', NULL, NULL, NULL, NULL, NULL),
(5, 'Món chay giàu dinh dưỡng', 'Hướng dẫn chế biến các món chay tốt cho sức khỏe...', 15, '2025-03-26', 'images/monchay.jpg', 'Món tráng miệng', NULL, NULL, NULL, NULL, NULL),
(6, 'Bí quyết làm phở bò thơm ngon', 'Bí quyết nấu phở bò chuẩn vị truyền thống...', 3, '2025-03-27', 'images/pho.jpg', 'Món hải sản', NULL, NULL, NULL, NULL, NULL),
(7, 'Cách làm pizza tại nhà', 'Công thức làm pizza đơn giản và ngon như ngoài tiệm...', 1, '2025-03-28', 'images/pizza.jpg', 'Món ăn sáng', NULL, NULL, NULL, NULL, NULL),
(8, 'Salad trộn thanh mát', 'Hướng dẫn làm salad trộn nhanh chóng và ngon miệng...', 62, '2025-03-29', 'images/salad.jpg', 'Món ăn vặt', NULL, NULL, NULL, NULL, NULL),
(22, 'Xôi Xéo', 'Xôi xéo là món ăn sáng phổ biến ở miền Bắc Việt Nam, được làm từ gạo nếp dẻo, đậu xanh nghiền, hành phi và mỡ gà.', 1, '2025-04-08', 'images/xoi_xeo.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(23, 'Phở Hà Nội', 'Phở Hà Nội là món ăn truyền thống nổi tiếng với nước dùng đậm đà.', 1, '2025-04-08', 'images/pho.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(24, 'Bún Chả', 'Bún chả là món ăn đặc trưng của Hà Nội với thịt nướng thơm ngon.', 68, '2025-04-08', 'images/buncha.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(25, 'Cơm Tấm', 'Cơm tấm là món ăn đặc sản của miền Nam, gồm cơm tấm, sườn nướng.', 1, '2025-04-08', 'images/comtam.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(26, 'Bánh Canh', 'Bánh canh là món ăn truyền thống với sợi bánh canh mềm dai, nước dùng đậm đà, thường được ăn kèm với tôm, cua, hoặc thịt.', 64, '2025-04-08', 'images/banhcanh.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(27, 'Hủ Tiếu', 'Hủ tiếu là món ăn phổ biến ở miền Nam Việt Nam, với nước dùng thanh ngọt, sợi hủ tiếu mềm, ăn kèm thịt heo, tôm, và rau sống.', 1, '2025-04-08', 'images/hutieu.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(28, 'Bánh Bèo', 'Bánh bèo là món ăn đặc sản miền Trung, được làm từ bột gạo, ăn kèm tôm cháy, hành phi, và nước mắm chua ngọt.', 63, '2025-04-08', 'images/banhbeo.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(29, 'Nem Rán', 'Nem rán là món ăn truyền thống của Việt Nam, được làm từ thịt băm, miến, mộc nhĩ, cuốn trong bánh tráng và chiên giòn.', 1, '2025-04-08', 'images/nemran.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(30, 'Chả Giò', 'Chả giò là món ăn tương tự nem rán, nhưng thường được làm với nhân tôm, thịt, và rau củ, cuốn trong bánh tráng mỏng.', 1, '2025-04-08', 'images/chagio.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(31, 'Bún Riêu', 'Bún riêu là món ăn đặc trưng với nước dùng chua thanh, riêu cua, cà chua, và bún tươi.', 1, '2025-04-08', 'images/bunrieu.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(32, 'Bánh Tét', 'Bánh tét là món ăn truyền thống ngày Tết, được làm từ gạo nếp, nhân đậu xanh, thịt mỡ, và gói trong lá chuối.', 67, '2025-04-08', 'images/banhtet.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(33, 'Gà Nướng Mật Ong', 'Gà nướng mật ong là món ăn hấp dẫn với lớp da gà giòn, thơm mùi mật ong, thịt gà mềm ngọt.', 1, '2025-04-08', 'images/ganuong.jpg', 'Ăn uống', NULL, NULL, NULL, NULL, NULL),
(84, 'Đồ Chiên Ăn Vặt – Món Ngon Giòn Rụm Dễ Làm Tại Nhà', 'Đồ chiên ăn vặt như khoai tây chiên, cánh gà chiên giòn là lựa chọn hoàn hảo cho buổi tụ họp bạn bè. Công thức này đơn giản, dễ làm, đảm bảo giòn ngon khó cưỡng!', 61, '2025-04-13', 'images/dochienga.jpg', 'Công thức nấu ăn', 20, 20, 4, 'Dễ', 'Calo: 400 kcal/phần, Protein: 18g, Chất béo: 25g'),
(85, 'Hoa Bánh Căn – Món Bánh Giòn Ngon Đặc Sản Miền Trung', 'Bánh căn là đặc sản miền Trung, nổi tiếng với lớp vỏ giòn rụm, nhân đa dạng như trứng, tôm, mực, ăn kèm nước chấm đậm đà. Hãy thử công thức này để mang hương vị Nha Trang vào căn bếp của bạn!', 62, '2025-04-13', 'images/hoabanhcan.jpg', 'Công thức nấu ăn', 20, 20, 4, 'Trung bình', 'Calo: 300 kcal/phần, Protein: 12g, Chất béo: 15g'),
(86, 'Bánh Mì Chả Cá – Món Ăn Sáng Tiện Lợi Và Đầy Dinh Dưỡng', 'Bánh mì chả cá là món ăn sáng quen thuộc của người Việt, kết hợp vị giòn thơm của bánh mì với chả cá dai ngon và rau sống tươi mát. Hãy thử công thức này để làm bữa sáng nhanh chóng, bổ dưỡng!', 63, '2025-04-13', 'images/banhmichaca.jpg', 'Công thức nấu ăn', 15, 10, 4, 'Dễ', 'Calo: 350 kcal/phần, Protein: 15g, Chất béo: 10g'),
(87, 'Bún Bò Huế – Hương Vị Đậm Đà Khó Quên', 'Bún bò Huế là món ăn đặc trưng của miền Trung Việt Nam, nổi tiếng với nước dùng đậm đà, cay nồng và hương vị độc đáo. Hãy cùng khám phá cách làm món ăn này tại nhà!', 64, '2025-04-04', 'images/bunbohue.jpg', 'Công thức nấu ăn', 30, 120, 4, 'Trung bình', 'Calo: 600 kcal/phần, Protein: 30g, Chất béo: 20g'),
(88, 'Cách Làm Kem Truyền Thống Thơm Ngon Tại Nhà – Mát Lạnh Mùa Hè', 'Kem truyền thống với vị ngọt béo từ sữa và hương vani thơm lừng là món tráng miệng hoàn hảo cho mọi gia đình. Hãy thử công thức đơn giản này để tự làm kem tại nhà mà không cần máy!', 65, '2025-04-13', 'images/kem.jpg', 'Công thức nấu ăn', 20, 0, 6, 'Trung bình', 'Calo: 220 kcal/phần, Protein: 5g, Chất béo: 12g'),
(89, 'Cách Làm Kem Chuối Sữa Chua Béo Ngậy – Món Tráng Miệng Giải Nhiệt', 'Kem chuối sữa chua là món tráng miệng đơn giản, thơm ngon với vị ngọt tự nhiên của chuối và sự béo ngậy của sữa chua. Thử ngay công thức dễ làm này để giải nhiệt mùa hè!', 66, '2025-04-13', 'images/kemchuoi.jpg', 'Công thức nấu ăn', 15, 0, 4, 'Dễ', 'Calo: 180 kcal/phần, Protein: 4g, Chất béo: 6g'),
(90, 'Tiramisu – Hương Vị Tinh Tế Chinh Phục Mọi Tín Đồ Ẩm Thực', 'Tiramisu là món tráng miệng Ý kinh điển, kết hợp vị béo ngậy của kem mascarpone, hương thơm cà phê đậm đà và chút nồng nàn của rượu. Hãy thử công thức này để mang hương vị Ý vào căn bếp của bạn!', 67, '2025-04-13', 'images/tiramisu.jpg', 'Công thức nấu ăn', 30, 0, 6, 'Trung bình', 'Calo: 350 kcal/phần, Protein: 7g, Chất béo: 25g'),
(91, 'Bánh Flan Mềm Mịn Tại Nhà – Tráng Miệng Tuyệt Hảo', 'Bánh flan (caramel custard) là món tráng miệng ngọt ngào với lớp caramel vàng óng và phần bánh mềm mịn, tan ngay trong miệng. Hãy thử công thức đơn giản này để làm bánh flan tại nhà!', 97, '2025-04-13', 'images/flan.jpg', 'Công thức nấu ăn', 15, 45, 6, 'Dễ', 'Calo: 200 kcal/phần, Protein: 6g, Chất béo: 8g'),
(92, 'Chè Đậu Xanh Thơm Ngon Tại Nhà – Món Tráng Miệng Dân Dã', 'Chè đậu xanh là món tráng miệng quen thuộc của người Việt, với vị ngọt thanh, bùi bùi của đậu xanh hòa quyện cùng nước cốt dừa béo ngậy. Hãy thử nấu món chè này tại nhà với công thức đơn giản, dễ làm!', 98, '2025-04-13', 'images/chedauxanh.jpg', 'Công thức nấu ăn', 15, 45, 4, 'Dễ', 'Calo: 250 kcal/phần, Protein: 5g, Chất béo: 10g'),
(93, 'Bánh Xèo Giòn Rụm Tại Nhà – Hương Vị Dân Dã', 'Bánh xèo là món ăn đặc trưng của miền Nam Việt Nam, nổi tiếng với lớp vỏ giòn rụm, nhân tôm thịt đậm đà và rau sống tươi ngon. Hãy cùng khám phá cách làm bánh xèo tại nhà với công thức đơn giản, dễ thực hiện!', 96, '2025-04-13', 'images/banhxeo.jpg', 'Công thức nấu ăn', 20, 30, 4, 'Trung bình', 'Calo: 450 kcal/phần, Protein: 15g, Chất béo: 25g'),
(94, 'Cách làm Phở Bò Hà Nội', 'Video hướng dẫn nấu phở bò truyền thống Hà Nội.', 59, '2025-04-01', 'images/phobo.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(95, 'Bún Chả Obama', 'Video cách làm bún chả ngon như ở Hà Nội.', 60, '2025-04-02', 'images/buncha.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(96, 'Cơm Tấm Sài Gòn', 'Hướng dẫn làm cơm tấm chuẩn vị miền Nam.', 61, '2025-04-03', 'images/comtam.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(97, 'Lẩu Thái Hải Sản', 'Cách nấu lẩu Thái chua cay tại nhà.', 15, '2025-04-04', 'images/lauthai.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(98, 'Bánh Xèo Miền Tây', 'Video làm bánh xèo giòn rụm.', 17, '2025-04-05', 'images/banhxeo.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(99, 'Chè Ba Màu', 'Cách làm chè ba màu mát lạnh.', 20, '2025-04-06', 'images/chebamau.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(100, 'Gỏi Cuốn Tôm Thịt', 'Video cuốn gỏi tươi ngon.', 1, '2025-04-07', 'images/goicuon.jpg', 'video', NULL, NULL, NULL, NULL, NULL),
(101, 'Nhà hàng Phở 24 - Hà Nội', 'Phở 24 là một địa điểm nổi tiếng với món phở bò truyền thống.', 59, '2025-04-01', 'images/pho.jpg', 'diadiem', NULL, NULL, NULL, NULL, NULL),
(102, 'Quán Bún Chả Hàng Mành - Hà Nội', 'Bún chả Hàng Mành nổi tiếng với hương vị đậm đà.', 60, '2025-04-02', 'images/buncha.jpg', 'diadiem', NULL, NULL, NULL, NULL, NULL),
(103, 'Nhà hàng Cơm Tấm Ba Ghiền - TP.HCM', 'Cơm tấm Ba Ghiền là địa chỉ yêu thích tại Sài Gòn.', 61, '2025-04-03', 'images/comtam.jpg', 'diadiem', NULL, NULL, NULL, NULL, NULL),
(104, 'Quán Lẩu Thái 123 - Đà Nẵng', 'Lẩu Thái 123 mang đến trải nghiệm ẩm thực chua cay đặc trưng.', 15, '2025-04-04', 'images/lauthai.jpg', 'diadiem', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `baiviet_images`
--

CREATE TABLE `baiviet_images` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `baiviet_images`
--

INSERT INTO `baiviet_images` (`id`, `baiviet_id`, `image_url`) VALUES
(1, 87, 'images/bunbohue_1.jpg'),
(2, 87, 'images/bunbohue_2.jpg'),
(3, 93, 'images/banhxeo_1.jpg'),
(4, 93, 'images/banhxeo_2.jpg'),
(5, 93, 'images/banhxeo_3.jpg'),
(6, 93, 'images/banhxeo_4.jpg'),
(7, 87, 'images/bunbohue_3.jpg'),
(8, 87, 'images/bunbohue_4.jpg'),
(9, 92, 'images/chedauxanh_1.jpg'),
(10, 92, 'images/chedauxanh_2.jpg'),
(11, 92, 'images/chedauxanh_3.jpg'),
(12, 92, 'images/chedauxanh_4.jpg'),
(13, 91, 'images/flan_1.jpg'),
(14, 91, 'images/flan_2.jpg'),
(15, 91, 'images/flan_3.jpg'),
(16, 91, 'images/flan_4.jpg'),
(21, 90, 'images/tiramisu_1.jpg'),
(22, 90, 'images/tiramisu_2.jpg'),
(23, 90, 'images/tiramisu_3.jpg'),
(24, 90, 'images/tiramisu_4.jpg'),
(25, 89, 'images/kemchuoi_1.jpg'),
(26, 89, 'images/kemchuoi_2.jpg'),
(27, 89, 'images/kemchuoi_3.jpg'),
(28, 89, 'images/kemchuoi_4.jpg'),
(29, 88, 'images/kem_1.jpg'),
(30, 88, 'images/kem_2.jpg'),
(31, 88, 'images/kem_3.jpg'),
(32, 88, 'images/kem_4.jpg'),
(33, 86, 'images/banhmi_1.jpg'),
(34, 86, 'images/banhmi_2.jpg'),
(35, 86, 'images/banhmi_3.jpg'),
(36, 86, 'images/banhmi_4.jpg'),
(37, 85, 'images/banhcan_1.jpg'),
(38, 85, 'images/banhcan_2.jpg'),
(39, 85, 'images/banhcan_3.jpg'),
(40, 85, 'images/banhcan_4.jpg'),
(41, 84, 'images/dochien_1.jpg'),
(42, 84, 'images/dochien_2.jpg'),
(43, 84, 'images/dochien_3.jpg'),
(44, 84, 'images/dochien_4.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `baiviet_tag`
--

CREATE TABLE `baiviet_tag` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `baiviet_theloai`
--

CREATE TABLE `baiviet_theloai` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `theloai_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `binhluan`
--

CREATE TABLE `binhluan` (
  `id` int(11) NOT NULL,
  `noidung` text NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `thoi_gian` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `binhluan`
--

INSERT INTO `binhluan` (`id`, `noidung`, `baiviet_id`, `nguoidung_id`, `thoi_gian`) VALUES
(1, 'Hay', 92, 102, '2025-04-13'),
(2, 'Món ăn rất hấp dẫn !!!', 91, 102, '2025-04-13'),
(3, 'Hay qua', 91, 102, '2025-04-13'),
(4, 'Ngon', 93, 103, '2025-04-13'),
(5, 'Ngon', 91, 103, '2025-04-13'),
(6, 'hay quá !!!', 86, 102, '2025-04-16'),
(7, 'Cảm ơn đã chia sẻ công thức', 86, 102, '2025-04-16'),
(8, 'Xin chào', 85, 103, '2025-04-17'),
(9, 'xin chào', 84, 103, '2025-04-17'),
(10, 'Cảm ơn bạn đã chia sẻ công thức', 84, 102, '2025-04-17'),
(11, 'Bánh mì ngon quá', 86, 103, '2025-04-17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cac_buoc_lam`
--

CREATE TABLE `cac_buoc_lam` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `buoc_so` int(11) NOT NULL,
  `noi_dung` text NOT NULL,
  `anh_minh_hoa` varchar(255) DEFAULT NULL,
  `thoi_gian_thuc_hien` int(11) DEFAULT NULL COMMENT 'Thời gian thực hiện bước (phút)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cac_buoc_lam`
--

INSERT INTO `cac_buoc_lam` (`id`, `baiviet_id`, `buoc_so`, `noi_dung`, `anh_minh_hoa`, `thoi_gian_thuc_hien`) VALUES
(1, 87, 1, 'Rửa sạch xương bò, chần qua nước sôi để loại bỏ bọt bẩn. Cho xương vào nồi, thêm 3 lít nước và ninh trong 2 giờ.', 'images/buoc1_ninhxuong.jpg', 120),
(2, 87, 2, 'Đập dập sả, băm nhỏ hành tím và tỏi. Phi thơm hành, tỏi, sả với 2 muỗng canh dầu ăn, sau đó cho mắm ruốc đã pha loãng vào, khuấy đều.', 'images/buoc2_phi.jpg', 10),
(3, 87, 3, 'Thêm hỗn hợp phi thơm và mắm ruốc vào nồi nước dùng. Nêm nếm với muối, đường, và ớt bột để tạo vị cay.', 'images/buoc3_nem.jpg', 5),
(4, 87, 4, 'Thái mỏng thịt bò bắp, trụng sơ qua nước sôi. Chuẩn bị bún tươi, rau sống (giá, hành lá, rau thơm).', 'images/buoc4_thitbo.jpg', 10),
(5, 87, 5, 'Múc bún vào tô, xếp thịt bò, chan nước dùng nóng. Thêm rau sống, ớt tươi và thưởng thức!', 'images/buoc5_trinhbay.jpg', 5),
(6, 93, 1, 'Pha bột: Trộn bột gạo, bột nghệ, muối với nước cốt dừa, bia và 250ml nước lọc. Thêm hành lá thái nhỏ, khuấy đều, để bột nghỉ 30 phút.', 'images/buoc1_phabot.jpg', 10),
(7, 93, 2, 'Sơ chế nhân: Ướp thịt ba chỉ với muối, tiêu, tỏi băm. Rửa sạch tôm, giá đỗ. Thái hành tây thành múi cau.', 'images/buoc2_soche.jpg', 10),
(8, 93, 3, 'Chiên bánh: Làm nóng chảo với 2 muỗng canh dầu ăn. Xào sơ tôm và thịt ba chỉ, để riêng. Đổ một vá bột vào chảo, xoay đều để tạo lớp vỏ mỏng. Thêm nhân tôm, thịt, giá đỗ, hành tây lên một nửa bánh.', 'images/buoc3_chien.jpg', 5),
(9, 93, 4, 'Gập bánh: Chiên ở lửa vừa khoảng 2-3 phút đến khi vỏ giòn và vàng. Gập đôi bánh, chiên thêm 1 phút. Lấy ra, để ráo dầu.', 'images/buoc4_gap.jpg', 3),
(10, 93, 5, 'Pha nước chấm: Hòa tan nước mắm, đường, nước lọc, nước cốt chanh. Thêm tỏi băm, ớt băm. Chuẩn bị rau sống và thưởng thức!', 'images/buoc5_nuoccham.jpg', 5),
(11, 92, 1, 'Sơ chế đậu xanh: Ngâm đậu xanh trong nước 4-6 giờ (nếu dùng đậu nguyên vỏ). Vo sạch, để ráo.', 'images/buoc1_soche.jpg', 5),
(12, 92, 2, 'Nấu đậu: Cho đậu xanh vào nồi, thêm 1 lít nước và lá dứa. Nấu ở lửa vừa đến khi đậu chín mềm (khoảng 30 phút).', 'images/buoc2_naudau.jpg', 30),
(13, 92, 3, 'Nêm gia vị: Thêm đường cát và muối vào nồi đậu, khuấy đều cho tan. Nấu thêm 5 phút để ngấm vị.', 'images/buoc3_nem.jpg', 5),
(14, 92, 4, 'Tạo độ sánh (tùy chọn): Pha bột sắn dây với 50ml nước lạnh, đổ từ từ vào nồi, khuấy đều đến khi chè sánh nhẹ.', 'images/buoc4_sanh.jpg', 3),
(15, 92, 5, 'Hoàn thành: Múc chè ra chén, rưới nước cốt dừa lên trên. Có thể dùng nóng hoặc thêm đá tùy sở thích!', 'images/buoc5_trinhbay.jpg', 2),
(16, 91, 1, 'Làm caramel: Đun chảy 100g đường với 50ml nước trên chảo nhỏ ở lửa vừa. Khuấy đều đến khi đường tan và chuyển màu vàng nâu. Đổ caramel vào đáy khuôn.', 'images/buoc1_caramel.jpg', 5),
(17, 91, 2, 'Trộn hỗn hợp bánh: Đánh tan 4 quả trứng gà. Thêm sữa tươi, sữa đặc, và vani, khuấy đều đến khi mịn. Lọc hỗn hợp qua rây để loại bỏ bọt khí.', 'images/buoc2_tron.jpg', 5),
(18, 91, 3, 'Đổ khuôn: Rót hỗn hợp trứng sữa vào khuôn đã có caramel. Không đổ đầy quá 3/4 khuôn.', 'images/buoc3_dokhuon.jpg', 3),
(19, 91, 4, 'Hấp bánh: Đặt khuôn vào nồi hấp hoặc lò nướng cách thủy (170°C). Hấp khoảng 30-40 phút đến khi bánh đông lại. Kiểm tra bằng tăm, nếu tăm sạch là bánh chín.', 'images/buoc4_hap.jpg', 30),
(20, 91, 5, 'Hoàn thành: Để bánh nguội, cho vào tủ lạnh 2-3 giờ. Úp ngược khuôn để lấy bánh ra đĩa, thưởng thức với cà phê hoặc trà!', 'images/buoc5_trinhbay.jpg', 2),
(26, 90, 1, 'Chuẩn bị cà phê: Pha 200ml cà phê espresso, thêm 1 muỗng canh đường và rượu Kahlua (nếu dùng). Để nguội hoàn toàn.', 'images/buoc1_caphe.jpg', 5),
(27, 90, 2, 'Đánh kem: Đánh 4 lòng đỏ trứng với 50g đường đến khi bông mịn, màu vàng nhạt. Thêm phô mai mascarpone, đánh đều đến khi hỗn hợp mịn.', 'images/buoc2_kem.jpg', 10),
(28, 90, 3, 'Lớp bánh đầu tiên: Nhúng nhanh từng chiếc bánh ladyfinger vào cà phê, xếp một lớp vào đáy khuôn. Phủ một lớp kem mascarpone lên trên.', 'images/buoc3_lop1.jpg', 5),
(29, 90, 4, 'Lặp lại lớp bánh: Xếp thêm một lớp bánh ladyfinger đã nhúng cà phê, phủ lớp kem còn lại. Làm phẳng bề mặt.', 'images/buoc4_lop2.jpg', 5),
(30, 90, 5, 'Hoàn thành: Rắc bột cacao lên bề mặt qua rây. Đậy kín, để trong tủ lạnh ít nhất 4 giờ (tốt nhất qua đêm). Thưởng thức lạnh!', 'images/buoc5_trinhbay.jpg', 5),
(31, 89, 1, 'Sơ chế chuối: Lột vỏ chuối, cắt đôi hoặc để nguyên tùy sở thích. Đặt chuối vào túi zip hoặc khuôn kem.', 'images/buoc1_soche.jpg', 5),
(32, 89, 2, 'Trộn hỗn hợp: Trong tô, trộn đều sữa chua, sữa đặc và nước cốt dừa đến khi mịn. Nếm thử và điều chỉnh độ ngọt nếu cần.', 'images/buoc2_tron.jpg', 5),
(33, 89, 3, 'Đổ khuôn: Đổ hỗn hợp sữa chua vào túi zip hoặc khuôn chứa chuối, đảm bảo chuối được bao phủ đều.', 'images/buoc3_dokhuon.jpg', 3),
(34, 89, 4, 'Đông lạnh: Đặt túi zip hoặc khuôn vào ngăn đá tủ lạnh, để ít nhất 6 giờ cho kem đông cứng.', 'images/buoc4_donglanh.jpg', 0),
(35, 89, 5, 'Hoàn thành: Lấy kem ra, rắc đậu phộng rang và dừa nạo lên trên. Cắt lát hoặc dùng trực tiếp từ khuôn, thưởng thức ngay!', 'images/buoc5_trinhbay.jpg', 2),
(36, 88, 1, 'Hâm sữa: Đun sữa tươi với đường cát và muối trên lửa nhỏ đến khi đường tan hoàn toàn. Không để sữa sôi. Để nguội.', 'images/buoc1_hamsua.jpg', 5),
(37, 88, 2, 'Đánh kem: Đánh kem whipping cream trong tô lạnh đến khi bông mềm (soft peaks). Không đánh quá cứng.', 'images/buoc2_danhkem.jpg', 5),
(38, 88, 3, 'Trộn hỗn hợp: Trộn sữa đặc và vani vào sữa tươi đã nguội. Từ từ trộn hỗn hợp sữa vào kem whipping, khuấy nhẹ để giữ độ xốp.', 'images/buoc3_tron.jpg', 5),
(39, 88, 4, 'Đông lạnh: Đổ hỗn hợp vào hộp hoặc khuôn. Đậy kín, đặt vào ngăn đá. Cứ 30 phút lấy ra khuấy đều 2-3 lần để kem mịn.', 'images/buoc4_donglanh.jpg', 5),
(40, 88, 5, 'Hoàn thành: Để kem đông hoàn toàn sau 6-8 giờ. Múc kem ra ly, trang trí tùy ý và thưởng thức!', 'images/buoc5_trinhbay.jpg', 0),
(41, 86, 1, 'Sơ chế chả cá: Thái chả cá thành lát mỏng. Ướp với nước mắm, hành lá thái nhỏ, chút tiêu trong 10 phút.', 'images/buoc1_soche.jpg', 5),
(42, 86, 2, 'Chiên chả cá: Làm nóng chảo với 2 muỗng canh dầu ăn. Chiên chả cá đến khi vàng đều hai mặt. Để ráo dầu.', 'images/buoc2_chien.jpg', 5),
(43, 86, 3, 'Chuẩn bị bánh mì: Cắt đôi bánh mì theo chiều dọc, phết mayonnaise bên trong. Xếp dưa leo và rau mùi lên một mặt.', 'images/buoc3_chuanbi.jpg', 3),
(44, 86, 4, 'Lắp ráp bánh: Đặt chả cá chiên lên trên rau, thêm tương ớt tùy khẩu vị. Kẹp bánh mì lại.', 'images/buoc4_laprap.jpg', 2),
(45, 86, 5, 'Hoàn thành: Cắt đôi bánh mì nếu muốn, bày ra đĩa và thưởng thức ngay khi còn nóng!', 'images/buoc5_trinhbay.jpg', 0),
(46, 85, 1, 'Pha bột: Trộn bột gạo, bột năng với 300ml nước, chút muối và hành lá thái nhỏ. Khuấy đều, để bột nghỉ 30 phút.', 'images/buoc1_phabot.jpg', 5),
(47, 85, 2, 'Sơ chế nhân: Rửa sạch tôm, để ráo. Chuẩn bị trứng cút, đập sẵn vào bát nhỏ nếu cần.', 'images/buoc2_soche.jpg', 5),
(48, 85, 3, 'Nướng bánh: Làm nóng khuôn bánh căn, phết dầu ăn vào từng ô. Đổ bột vào 2/3 khuôn, thêm tôm hoặc trứng cút lên trên.', 'images/buoc3_nuong.jpg', 5),
(49, 85, 4, 'Chiên bánh: Nướng ở lửa vừa khoảng 3-4 phút đến khi bánh giòn, vàng đều. Lấy bánh ra, giữ nóng.', 'images/buoc4_chien.jpg', 3),
(50, 85, 5, 'Pha nước chấm và hoàn thành: Pha nước mắm với đường, nước lọc, ớt băm. Ăn bánh kèm nước chấm và rau sống!', 'images/buoc5_nuoccham.jpg', 2),
(51, 84, 1, 'Sơ chế nguyên liệu: Gọt vỏ khoai tây, cắt thanh dài, ngâm nước muối 10 phút, để ráo. Rửa sạch cánh gà, ướp với gia vị 15 phút.', 'images/buoc1_soche.jpg', 10),
(52, 84, 2, 'Chuẩn bị bột: Trộn bột mì và bột chiên giòn trong tô. Đánh tan trứng gà trong tô khác.', 'images/buoc2_bot.jpg', 3),
(53, 84, 3, 'Áo bột cánh gà: Nhúng cánh gà qua trứng, sau đó lăn qua bột, đảm bảo bột phủ đều.', 'images/buoc3_aobot.jpg', 3),
(54, 84, 4, 'Chiên đồ ăn: Làm nóng dầu ăn trong chảo sâu. Chiên khoai tây đến vàng giòn, vớt ra để ráo dầu. Tiếp tục chiên cánh gà đến khi chín vàng.', 'images/buoc4_chien.jpg', 10),
(55, 84, 5, 'Hoàn thành: Xếp khoai tây và cánh gà ra đĩa, rắc chút muối tiêu nếu thích. Ăn kèm tương ớt!', 'images/buoc5_trinhbay.jpg', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `congthuc`
--

CREATE TABLE `congthuc` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguyenlieu_id` int(11) NOT NULL,
  `so_luong` varchar(50) DEFAULT NULL,
  `buoc_lam` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `congthuc_nguyenlieu`
--

CREATE TABLE `congthuc_nguyenlieu` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguyenlieu_id` int(11) NOT NULL,
  `so_luong` varchar(50) DEFAULT NULL,
  `ghi_chu` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `congthuc_nguyenlieu`
--

INSERT INTO `congthuc_nguyenlieu` (`id`, `baiviet_id`, `nguyenlieu_id`, `so_luong`, `ghi_chu`) VALUES
(52, 87, 56, '1 kg', 'Rửa sạch, chần qua nước sôi'),
(53, 87, 57, '500 g', 'Thái mỏng, trụng sơ'),
(54, 87, 58, '1 kg', NULL),
(55, 87, 59, '2 muỗng canh', 'Pha loãng với nước'),
(56, 87, 60, '4 cây', 'Đập dập, cắt khúc'),
(57, 87, 61, '3 củ', 'Băm nhỏ'),
(58, 87, 62, '4 tép', 'Băm nhỏ'),
(59, 87, 63, '2 quả', 'Thái lát hoặc dùng ớt bột'),
(60, 93, 64, '200 g', 'Khuấy đều với nước để tránh vón cục'),
(61, 93, 65, '0.5 muỗng cà phê', NULL),
(62, 93, 66, '100 ml', 'Có thể thay bằng sữa tươi nếu không có'),
(63, 93, 67, '100 ml', 'Giúp bánh giòn, có thể thay bằng soda'),
(64, 93, 68, '200 g', 'Bóc vỏ, bỏ chỉ đen, rửa sạch'),
(65, 93, 69, '150 g', 'Thái mỏng, ướp với ít muối và tiêu'),
(66, 93, 70, '100 g', 'Ngâm nước để giữ độ tươi'),
(67, 93, 71, '3 nhánh', 'Rửa sạch, thái nhỏ'),
(68, 93, 72, '2 muỗng canh', 'Pha nước chấm'),
(69, 93, 73, '1 muỗng cà phê', 'Băm nhuyễn cho nước chấm'),
(70, 92, 74, '200 g', 'Ngâm nước 4-6 giờ nếu dùng đậu nguyên vỏ'),
(71, 92, 75, '150 g', 'Điều chỉnh tùy khẩu vị ngọt'),
(72, 92, 76, '200 ml', 'Dùng để rưới lên chè khi ăn'),
(73, 92, 77, '3 lá', 'Rửa sạch, buộc gọn'),
(74, 92, 78, '0.5 muỗng cà phê', NULL),
(75, 92, 79, '2 muỗng canh', 'Pha với nước lạnh trước khi dùng'),
(76, 91, 80, '4 quả', 'Dùng cả lòng đỏ và lòng trắng'),
(77, 91, 81, '400 ml', 'Hâm ấm trước khi trộn'),
(78, 91, 82, '150 ml', 'Điều chỉnh tùy khẩu vị'),
(79, 91, 83, '100 g', 'Dùng để làm caramel'),
(80, 91, 84, '50 ml', 'Dùng để nấu caramel'),
(81, 91, 85, '1 muỗng cà phê', 'Có thể thay bằng ống vani'),
(82, 90, 86, '500 g', 'Để ở nhiệt độ phòng cho mềm'),
(83, 90, 87, '24 cái', 'Tùy kích thước khuôn, khoảng 200-300g'),
(84, 90, 88, '200 ml', 'Pha cà phê đậm, để nguội'),
(85, 90, 89, '4 quả', 'Chỉ dùng lòng đỏ, chọn trứng tươi'),
(86, 90, 90, '100 g', 'Chia làm 2 phần để đánh kem và ngâm bánh'),
(87, 90, 91, '2 muỗng canh', 'Có thể thay bằng rượu Baileys hoặc bỏ qua'),
(88, 90, 92, '2 muỗng canh', 'Dùng bột cacao không đường'),
(89, 89, 93, '4 quả', 'Chọn chuối chín mềm, không dập'),
(90, 89, 94, '2 hộp', 'Tương đương 200g, để lạnh trước khi dùng'),
(91, 89, 95, '100 ml', 'Điều chỉnh tùy khẩu vị'),
(92, 89, 96, '100 ml', 'Có thể thay bằng sữa tươi nếu muốn nhẹ hơn'),
(93, 89, 97, '50 g', 'Giã nhỏ để rắc lên kem'),
(94, 89, 98, '30 g', 'Dùng để trang trí bề mặt'),
(95, 88, 99, '400 ml', 'Hâm ấm nhẹ trước khi trộn'),
(96, 88, 100, '300 ml', 'Để lạnh để dễ đánh bông'),
(97, 88, 101, '150 ml', 'Điều chỉnh tùy khẩu vị'),
(98, 88, 102, '50 g', 'Hòa tan hoàn toàn với sữa'),
(99, 88, 103, '2 muỗng cà phê', 'Có thể thay bằng ống vani'),
(100, 88, 104, '0.25 muỗng cà phê', 'Giúp cân bằng vị ngọt'),
(101, 86, 105, '4 ổ', 'Chọn bánh mì mới nướng, giòn'),
(102, 86, 106, '400g', 'Thái lát mỏng, ướp trước khi chiên'),
(103, 86, 107, '1 quả', 'Thái lát mỏng, bỏ hạt nếu cần'),
(104, 86, 108, '50 g', 'Rửa sạch, để ráo'),
(105, 86, 109, '3 nhánh', 'Thái nhỏ để ướp và trang trí'),
(106, 86, 110, '2 muỗng canh', 'Điều chỉnh tùy khẩu vị'),
(107, 86, 111, '3 muỗng canh', 'Phết đều bên trong bánh'),
(108, 86, 112, '1 muỗng canh', 'Dùng để ướp chả cá'),
(109, 85, 113, '200 g', 'Khuấy đều với nước để tránh vón cục'),
(110, 85, 114, '50 g', 'Tăng độ giòn cho bánh'),
(111, 85, 115, '12 quả', 'Đập trực tiếp vào khuôn'),
(112, 85, 116, '100 g', 'Bóc vỏ, rửa sạch, để nguyên con'),
(113, 85, 117, '3 nhánh', 'Thái nhỏ, trộn vào bột'),
(114, 85, 118, '3 muỗng canh', 'Pha nước chấm với đường và nước'),
(115, 85, 119, '2 quả', 'Băm nhỏ, tùy chỉnh độ cay'),
(116, 85, 120, '4 muỗng canh', 'Dùng để bôi khuôn và chiên bánh'),
(117, 84, 121, '500 g', 'Gọt vỏ, cắt thanh dài hoặc lát mỏng'),
(118, 84, 122, '8 cái', 'Rửa sạch, để ráo trước khi ướp'),
(119, 84, 123, '100 g', 'Trộn với bột chiên giòn'),
(120, 84, 124, '100 g', 'Tạo lớp vỏ giòn cho cánh gà'),
(121, 84, 125, '2 quả', 'Đánh tan để nhúng cánh gà'),
(122, 84, 126, '2 muỗng cà phê', 'Gồm muối, tiêu, bột tỏi'),
(123, 84, 127, '500 ml', 'Dùng để chiên ngập dầu'),
(124, 84, 128, '3 muỗng canh', 'Dùng để chấm khoai tây và cánh gà');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `diem` int(11) DEFAULT NULL CHECK (`diem` between 1 and 5),
  `thoi_gian` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danhgia`
--

INSERT INTO `danhgia` (`id`, `baiviet_id`, `nguoidung_id`, `diem`, `thoi_gian`) VALUES
(1, 87, 102, 4, '2025-04-13'),
(2, 92, 102, 5, '2025-04-13'),
(3, 91, 102, 4, '2025-04-13'),
(4, 90, 102, 5, '2025-04-13'),
(5, 93, 102, 5, '2025-04-13'),
(6, 89, 102, 4, '2025-04-13'),
(7, 88, 102, 4, '2025-04-13'),
(8, 85, 102, 4, '2025-04-13'),
(9, 85, 103, 5, '2025-04-13'),
(10, 91, 103, 3, '2025-04-13'),
(11, 86, 102, 5, '2025-04-16'),
(12, 84, 102, 5, '2025-04-16'),
(13, 84, 103, 5, '2025-04-17'),
(14, 86, 103, 4, '2025-04-17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diadiem_anuong`
--

CREATE TABLE `diadiem_anuong` (
  `id` int(11) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `dia_chi` text NOT NULL,
  `loai_hinh` varchar(100) DEFAULT NULL,
  `khoang_gia` varchar(100) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `hinh_anh` varchar(255) DEFAULT NULL,
  `ngay_them` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `diadiem_anuong`
--

INSERT INTO `diadiem_anuong` (`id`, `ten`, `dia_chi`, `loai_hinh`, `khoang_gia`, `mo_ta`, `hinh_anh`, `ngay_them`) VALUES
(1, 'Phở 24', '123 Đinh Tiên Hoàng, Quận 1, TP.HCM', 'Quán phở', '50.000 - 100.000 VNĐ', 'Phở 24 là địa điểm nổi tiếng với món phở bò truyền thống, nước dùng đậm đà.', 'images/pho.jpg', '2025-04-23 01:39:31'),
(2, 'Bún Chả Hàng Mành', '19 Hàng Mành, Hoàn Kiếm, Hà Nội', 'Quán bún chả', '40.000 - 80.000 VNĐ', 'Bún chả Hàng Mành nổi tiếng với hương vị đậm đà, thịt nướng thơm ngon.', 'images/buncha.jpg', '2025-04-23 01:39:31'),
(3, 'Cơm Tấm Ba Ghiền', '84 Đặng Văn Ngữ, Quận Phú Nhuận, TP.HCM', 'Quán cơm tấm', '50.000 - 120.000 VNĐ', 'Cơm tấm Ba Ghiền là địa chỉ yêu thích với cơm tấm sườn bì chả.', 'images/comtam.jpg', '2025-04-23 01:39:31'),
(4, 'Lẩu Thái 123', '56 Nguyễn Huệ, TP. Đà Nẵng', 'Quán lẩu', '150.000 - 300.000 VNĐ', 'Lẩu Thái 123 mang đến trải nghiệm ẩm thực chua cay đặc trưng.', 'images/lauthai.jpg', '2025-04-23 01:39:31'),
(5, 'Bánh Xèo Mười Xiềm', '190 Nam Kỳ Khởi Nghĩa, Quận 3, TP.HCM', 'Quán bánh xèo', '60.000 - 150.000 VNĐ', 'Bánh xèo giòn rụm với nhân tôm thịt đậm đà, cùng với rau sống tươi ngon.', 'images/banhxeo.jpg', '2025-04-23 01:39:31');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lichsuhoatdong`
--

CREATE TABLE `lichsuhoatdong` (
  `id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `hoatdong` varchar(255) NOT NULL,
  `thoi_gian` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `meo_nau_an`
--

CREATE TABLE `meo_nau_an` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `noi_dung` text NOT NULL,
  `loai` enum('Mẹo','Lưu ý','Bí quyết') DEFAULT 'Mẹo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `meo_nau_an`
--

INSERT INTO `meo_nau_an` (`id`, `baiviet_id`, `noi_dung`, `loai`) VALUES
(1, 87, 'Nên ninh xương bò ở lửa nhỏ và hớt bọt thường xuyên để nước dùng trong.', 'Mẹo'),
(2, 87, 'Thêm một ít dầu điều vào nước dùng để tạo màu sắc đẹp mắt.', 'Bí quyết'),
(3, 87, 'Mắm ruốc cần pha loãng và khuấy đều để tránh mùi quá nồng.', 'Lưu ý'),
(4, 93, 'Để bánh giòn lâu, dùng chảo nóng và đổ bột thật mỏng.', 'Mẹo'),
(5, 93, 'Thêm một ít bia hoặc soda vào bột để tạo bọt khí, giúp bánh xốp giòn.', 'Bí quyết'),
(6, 93, 'Chiên bánh ở lửa vừa, không để lửa quá to sẽ làm bánh cháy.', 'Lưu ý'),
(7, 92, 'Ngâm đậu xanh trước khi nấu để đậu nhanh mềm và tiết kiệm thời gian.', 'Mẹo'),
(8, 92, 'Dùng lá dứa tươi để tạo mùi thơm tự nhiên, không nên dùng hương liệu nhân tạo.', 'Bí quyết'),
(9, 92, 'Không nấu chè quá đặc, giữ độ lỏng vừa phải để dễ thưởng thức.', 'Lưu ý'),
(10, 91, 'Lọc hỗn hợp trứng sữa qua rây để bánh flan mịn, không bị rỗ.', 'Mẹo'),
(11, 91, 'Hấp bánh ở lửa vừa và đậy kín nắp để tránh hơi nước rơi vào bánh.', 'Bí quyết'),
(12, 91, 'Không nấu caramel quá lâu, dễ bị đắng.', 'Lưu ý'),
(16, 90, 'Nhúng bánh ladyfinger nhanh để tránh bánh quá nhũn.', 'Mẹo'),
(17, 90, 'Dùng cà phê espresso chất lượng cao để có hương vị đậm đà nhất.', 'Bí quyết'),
(18, 90, 'Để tiramisu trong tủ lạnh qua đêm để các lớp thấm đều và bánh ngon hơn.', 'Lưu ý'),
(19, 89, 'Dùng túi zip để dễ lấy kem ra khỏi khuôn và bảo quản lâu hơn.', 'Mẹo'),
(20, 89, 'Chọn chuối chín vừa để kem có vị ngọt tự nhiên, không quá nồng.', 'Bí quyết'),
(21, 89, 'Không để kem quá lâu trong ngăn đá, dễ bị cứng quá, khó cắt.', 'Lưu ý'),
(22, 88, 'Khuấy kem định kỳ khi đông lạnh để tránh tạo tinh thể đá, giúp kem mịn hơn.', 'Mẹo'),
(23, 88, 'Dùng tô và que đánh kem lạnh để whipping cream bông nhanh và đều.', 'Bí quyết'),
(24, 88, 'Không để sữa tươi sôi khi hâm, dễ làm kem bị tách lớp.', 'Lưu ý'),
(25, 86, 'Chiên chả cá ở lửa vừa để giữ độ dai và không bị khô.', 'Mẹo'),
(26, 86, 'Nướng sơ bánh mì trước khi phết sốt để bánh giòn hơn.', 'Bí quyết'),
(27, 86, 'Thêm ớt tươi hoặc dưa chua tùy khẩu vị để tăng hương vị.', 'Lưu ý'),
(28, 85, 'Làm nóng khuôn thật kỹ trước khi đổ bột để bánh giòn và dễ lấy ra.', 'Mẹo'),
(29, 85, 'Dùng khuôn gang để bánh căn có độ giòn và thơm đặc trưng.', 'Bí quyết'),
(30, 85, 'Không đổ bột quá đầy khuôn, bánh dễ bị đặc, mất độ giòn.', 'Lưu ý'),
(31, 84, 'Ngâm khoai tây trong nước muối để loại bỏ tinh bột, giúp khoai giòn hơn.', 'Mẹo'),
(32, 84, 'Chiên ở nhiệt độ 170-180°C để đồ ăn vàng đều và không hút dầu.', 'Bí quyết'),
(33, 84, 'Chiên từng mẻ nhỏ để dầu giữ nhiệt độ ổn định.', 'Lưu ý');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `monan`
--

CREATE TABLE `monan` (
  `id` int(11) NOT NULL,
  `ten` varchar(255) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `loai_hinh` varchar(255) DEFAULT NULL,
  `gia` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `hinh_anh` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `monan`
--

INSERT INTO `monan` (`id`, `ten`, `dia_chi`, `loai_hinh`, `gia`, `mo_ta`, `hinh_anh`) VALUES
(1, 'Rakuen Hotpot - Lê Văn Sỹ', 'Số 483 Lê Văn Sỹ, P.12, Q.3', 'Buffet Lẩu', '250.000 - 350.000đ/người', 'Rakuen Hotpot là địa điểm lý tưởng để thưởng thức buffet lẩu đa dạng với không gian hiện đại và thoải mái.', 'images/tomhum.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

CREATE TABLE `nguoidung` (
  `id` int(11) NOT NULL,
  `ten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `matkhau` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `vai_tro` enum('admin','author','user') NOT NULL,
  `ngay_dang_ky` date DEFAULT curdate(),
  `trang_thai` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoidung`
--

INSERT INTO `nguoidung` (`id`, `ten`, `email`, `matkhau`, `avatar`, `vai_tro`, `ngay_dang_ky`, `trang_thai`) VALUES
(1, 'Thanh', 'thanh@example.com', 'matkhau123', 'avatar1.jpg', 'author', '2025-03-25', 0),
(2, 'Mai', 'mai@example.com', 'matkhau456', 'avatar2.jpg', 'user', '2025-03-26', 0),
(3, 'Linh', 'linh@example.com', 'matkhau789', 'avatar3.jpg', 'admin', '2025-03-24', 0),
(13, 'Vu Hoang', 'hoang@example.com', 'matkhau_mahoa3', 'avatar_hoang.jpg', 'admin', '2025-03-27', 0),
(14, 'Tran Khoa', 'khoa@example.com', 'matkhau_mahoa4', 'avatar_khoa.jpg', 'user', '2025-03-28', 0),
(15, 'Le An', 'an@example.com', 'matkhau_mahoa5', 'avatar_an.jpg', 'author', '2025-03-29', 0),
(17, 'Tran Thi B', 'tranthib@example.com', 'matkhau_b', 'avatar_b.jpg', 'author', '2025-03-31', 0),
(18, 'Le Minh C', 'leminhc@example.com', 'matkhau_c', 'avatar_c.jpg', 'admin', '2025-04-01', 0),
(19, 'Hoang Gia D', 'hoanggiad@example.com', 'matkhau_d', 'avatar_d.jpg', 'user', '2025-04-02', 0),
(20, 'Pham Huu E', 'phamhue@example.com', 'matkhau_e', 'avatar_e.jpg', 'author', '2025-04-03', 0),
(59, 'Nguyễn Văn A', 'nguyenvana@example.com', 'password123', 'avatar1.jpg', 'author', '2025-01-01', 0),
(60, 'Trần Thị B', 'tranthib1@example.com', 'password123', 'avatar2.jpg', 'author', '2025-01-02', 0),
(61, 'Lê Văn C', 'levanc@example.com', 'password123', 'avatar3.jpg', 'author', '2025-01-03', 0),
(62, 'Phạm Thị D', 'phamthid@example.com', 'password123', 'avatar4.jpg', 'author', '2025-01-04', 0),
(63, 'Hoàng Văn E', 'hoangvane@example.com', 'password123', 'avatar5.jpg', 'author', '2025-01-05', 0),
(64, 'Vũ Thị F', 'vuthif@example.com', 'password123', 'avatar6.jpg', 'author', '2025-01-06', 0),
(65, 'Đặng Văn G', 'dangvang@example.com', 'password123', 'avatar7.jpg', 'author', '2025-01-07', 0),
(66, 'Ngô Thị H', 'ngothih@example.com', 'password123', 'avatar8.jpg', 'author', '2025-01-08', 0),
(67, 'Bùi Văn I', 'buivani@example.com', 'password123', 'avatar9.jpg', 'author', '2025-01-09', 0),
(68, 'Đỗ Thị K', 'dothik@example.com', 'password123', 'avatar10.jpg', 'author', '2025-01-10', 0),
(94, 'Nguyễn Văn A', 'nguyenvana1@example.com', 'password123', 'avatar1.jpg', 'author', '2025-01-01', 0),
(95, 'Trần Thị B', 'tranthib2@example.com', 'password123', 'avatar2.jpg', 'author', '2025-01-02', 0),
(96, 'Lê Văn C', 'levanc2@example.com', 'password123', 'avatar3.jpg', 'author', '2025-01-03', 0),
(97, 'Phạm Thị D', 'phamthid4@example.com', 'password123', 'avatar4.jpg', 'author', '2025-01-04', 0),
(98, 'Hoàng Văn E', 'hoangvane5@example.com', 'password123', 'avatar5.jpg', 'author', '2025-01-05', 0),
(102, 'khoa', '99.dangkhoa.10@gmail.com', '$2y$10$FE2nGAMsKvnHOuojQvD7D.2Y/LCLMMF6F4zXI5cJfFmIZ/5tN4Jtm', 'images/avatar1.jpg', 'user', '2025-04-09', 1),
(103, 'user1', 'khoa2005dk@gmail.com', '$2y$10$FE2nGAMsKvnHOuojQvD7D.2Y/LCLMMF6F4zXI5cJfFmIZ/5tN4Jtm', 'images/avatar2.jpg', 'user', '2025-04-09', 1),
(104, 'Admin', 'admin@gmail.com', '$2y$10$FE2nGAMsKvnHOuojQvD7D.2Y/LCLMMF6F4zXI5cJfFmIZ/5tN4Jtm', NULL, 'admin', '2025-04-09', 1),
(106, 'AnhKhoa', 'ackhoa9@gmail.com', '$2y$10$8YSDeNa1C0Ae6HZe.2eEAeijkko1qE.vxzsknEvG8WiGShq8SYVZS', NULL, 'user', '2025-04-17', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguyenlieu`
--

CREATE TABLE `nguyenlieu` (
  `id` int(11) NOT NULL,
  `ten` varchar(100) NOT NULL,
  `mota` text DEFAULT NULL,
  `anh_minh_hoa` varchar(255) DEFAULT NULL,
  `don_vi` varchar(50) DEFAULT NULL COMMENT 'Đơn vị đo lường (kg, gram, muỗng canh,...)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguyenlieu`
--

INSERT INTO `nguyenlieu` (`id`, `ten`, `mota`, `anh_minh_hoa`, `don_vi`) VALUES
(56, 'Xương bò', 'Xương bò ống để ninh nước dùng', 'images/xuongbo.jpg', 'kg'),
(57, 'Thịt bò bắp', 'Thịt bò bắp mềm, thái mỏng', 'images/thitbo.jpg', 'kg'),
(58, 'Bún tươi', 'Bún sợi to, đặc trưng cho bún bò Huế', 'images/buntuoi.jpg', 'kg'),
(59, 'Mắm ruốc', 'Gia vị tạo mùi đặc trưng', 'images/mamruoc.jpg', 'muỗng canh'),
(60, 'Sả', 'Sả tươi, đập dập', 'images/sa.jpg', 'cây'),
(61, 'Hành tím', 'Hành tím băm nhỏ', 'images/hanhtim.jpg', 'củ'),
(62, 'Tỏi', 'Tỏi băm nhỏ', 'images/toi.jpg', 'tép'),
(63, 'Ớt', 'Ớt tươi hoặc ớt bột để tạo vị cay', 'images/ot.jpg', 'quả'),
(64, 'Bột gạo', 'Bột gạo tẻ để làm vỏ bánh', 'images/botgao.jpg', 'g'),
(65, 'Bột nghệ', 'Tạo màu vàng đẹp cho bánh', 'images/botnghe.jpg', 'muỗng cà phê'),
(66, 'Nước cốt dừa', 'Giúp bánh thơm và béo', 'images/nuoccotdua.jpg', 'ml'),
(67, 'Bia', 'Làm bánh giòn lâu hơn', 'images/bia.jpg', 'ml'),
(68, 'Tôm tươi', 'Tôm sú hoặc tôm thẻ, tươi ngon', 'images/tom.jpg', 'g'),
(69, 'Thịt ba chỉ', 'Thịt lợn ba chỉ, thái mỏng', 'images/thitbachi.jpg', 'g'),
(70, 'Giá đỗ', 'Giá đỗ tươi, rửa sạch', 'images/giado.jpg', 'g'),
(71, 'Hành lá', 'Hành lá thái nhỏ để trộn bột', 'images/hanhla.jpg', 'nhánh'),
(72, 'Nước mắm', 'Nước mắm ngon để làm nước chấm', 'images/nuocmam.jpg', 'muỗng canh'),
(73, 'Tỏi băm', 'Tỏi băm nhuyễn cho nước chấm', 'images/toibam.jpg', 'muỗng cà phê'),
(74, 'Đậu xanh', 'Đậu xanh nguyên vỏ hoặc cà vỏ, loại ngon', 'images/dauxanh.jpg', 'g'),
(75, 'Đường cát', 'Đường cát trắng để tạo vị ngọt', 'images/duongcat.jpg', 'g'),
(76, 'Nước cốt dừa', 'Nước cốt dừa đóng hộp hoặc tự ép', 'images/nuoccotdua.jpg', 'ml'),
(77, 'Lá dứa', 'Lá dứa tươi tạo mùi thơm', 'images/ladua.jpg', 'lá'),
(78, 'Muối', 'Muối ăn để tăng vị đậm đà', 'images/muoi.jpg', 'muỗng cà phê'),
(79, 'Bột sắn dây', 'Tạo độ sánh cho chè (tùy chọn)', 'images/botsanday.jpg', 'muỗng canh'),
(80, 'Trứng gà', 'Trứng gà tươi, chọn loại ngon', 'images/trung.jpg', 'quả'),
(81, 'Sữa tươi', 'Sữa tươi không đường để bánh mịn', 'images/suutuoi.jpg', 'ml'),
(82, 'Sữa đặc', 'Sữa đặc để tạo vị ngọt béo', 'images/suadac.jpg', 'ml'),
(83, 'Đường cát', 'Đường cát trắng để làm caramel', 'images/duongcat.jpg', 'g'),
(84, 'Nước lọc', 'Nước sạch để pha caramel', 'images/nuocloc.jpg', 'ml'),
(85, 'Vani', 'Tinh chất vani tạo mùi thơm', 'images/vani.jpg', 'muỗng cà phê'),
(86, 'Phô mai mascarpone', 'Phô mai Ý béo ngậy, thành phần chính của tiramisu', 'images/mascarpone.jpg', 'g'),
(87, 'Bánh ladyfinger', 'Bánh quy xốp dùng để ngâm cà phê', 'images/ladyfinger.jpg', 'cái'),
(88, 'Cà phê đen', 'Cà phê espresso đậm để ngâm bánh', 'images/caphe.jpg', 'ml'),
(89, 'Trứng gà', 'Trứng tươi, dùng lòng đỏ', 'images/trung.jpg', 'quả'),
(90, 'Đường cát', 'Đường cát trắng để tạo vị ngọt', 'images/duongcat.jpg', 'g'),
(91, 'Rượu Kahlua', 'Rượu cà phê để tăng hương vị (tùy chọn)', 'images/ruou.jpg', 'muỗng canh'),
(92, 'Bột cacao', 'Bột cacao nguyên chất để rắc lên bánh', 'images/cacao.jpg', 'muỗng canh'),
(93, 'Chuối chín', 'Chuối tiêu chín mềm, ngọt tự nhiên', 'images/chuoi.jpg', 'quả'),
(94, 'Sữa chua', 'Sữa chua có đường, loại đặc', 'images/suachua.jpg', 'hộp'),
(95, 'Sữa đặc', 'Sữa đặc để tăng độ ngọt và béo', 'images/suadac.jpg', 'ml'),
(96, 'Nước cốt dừa', 'Nước cốt dừa để kem thêm thơm', 'images/nuoccotdua.jpg', 'ml'),
(97, 'Đậu phộng rang', 'Đậu phộng rang giã nhỏ để trang trí', 'images/dauphong.jpg', 'g'),
(98, 'Dừa nạo', 'Dừa nạo sấy khô hoặc tươi', 'images/duanao.jpg', 'g'),
(99, 'Sữa tươi', 'Sữa tươi không đường để kem mịn', 'images/suutuoi.jpg', 'ml'),
(100, 'Kem whipping', 'Kem tươi whipping cream để tạo độ béo', 'images/whipping.jpg', 'ml'),
(101, 'Sữa đặc', 'Sữa đặc để tăng vị ngọt', 'images/suadac.jpg', 'ml'),
(102, 'Đường cát', 'Đường cát trắng để điều chỉnh độ ngọt', 'images/duongcat.jpg', 'g'),
(103, 'Vani', 'Tinh chất vani để tạo hương thơm', 'images/vani.jpg', 'muỗng cà phê'),
(104, 'Muối', 'Muối ăn để cân bằng vị', 'images/muoi.jpg', 'muỗng cà phê'),
(105, 'Bánh mì', 'Bánh mì baguette giòn, loại nhỏ', 'images/banhmi4.jpg', 'ổ'),
(106, 'Chả cá', 'Chả cá thu hoặc cá basa, tươi ngon', 'images/chaca.jpg', 'g'),
(107, 'Dưa leo', 'Dưa leo tươi, thái lát mỏng', 'images/dualeo.jpg', 'quả'),
(108, 'Rau mùi', 'Rau mùi tươi để thêm hương vị', 'images/raumui.jpg', 'g'),
(109, 'Hành lá', 'Hành lá thái nhỏ để ướp chả', 'images/hanhla.jpg', 'nhánh'),
(110, 'Tương ớt', 'Tương ớt để thêm vị cay', 'images/tuongot.jpg', 'muỗng canh'),
(111, 'Mayonnaise', 'Sốt mayonnaise để bánh thêm béo', 'images/mayonnaise.jpg', 'muỗng canh'),
(112, 'Nước mắm', 'Nước mắm ngon để ướp chả', 'images/nuocmam.jpg', 'muỗng canh'),
(113, 'Bột gạo', 'Bột gạo tẻ để làm vỏ bánh', 'images/botgao.jpg', 'g'),
(114, 'Bột năng', 'Bột năng để tăng độ giòn', 'images/botnang.jpg', 'g'),
(115, 'Trứng cút', 'Trứng cút tươi làm nhân', 'images/trungcut.jpg', 'quả'),
(116, 'Tôm tươi', 'Tôm nhỏ, tươi ngon làm nhân', 'images/tom.jpg', 'g'),
(117, 'Hành lá', 'Hành lá thái nhỏ để thêm vào bột', 'images/hanhla.jpg', 'nhánh'),
(118, 'Nước mắm', 'Nước mắm ngon để làm nước chấm', 'images/nuocmam.jpg', 'muỗng canh'),
(119, 'Ớt tươi', 'Ớt tươi băm nhỏ cho nước chấm', 'images/ot.jpg', 'quả'),
(120, 'Dầu ăn', 'Dầu thực vật để chiên bánh', 'images/dauan.jpg', 'muỗng canh'),
(121, 'Khoai tây', 'Khoai tây vàng, tươi, không mọc mầm', 'images/khoaitay.jpg', 'g'),
(122, 'Cánh gà', 'Cánh gà tươi, kích thước vừa', 'images/canhga.jpg', 'cái'),
(123, 'Bột mì', 'Bột mì đa dụng để làm lớp vỏ', 'images/botmi.jpg', 'g'),
(124, 'Bột chiên giòn', 'Bột chiên giòn để tăng độ giòn', 'images/botchien.jpg', 'g'),
(125, 'Trứng gà', 'Trứng gà tươi để làm lớp áo bột', 'images/trung.jpg', 'quả'),
(126, 'Gia vị', 'Muối, tiêu, bột tỏi để ướp', 'images/giavi.jpg', 'muỗng cà phê'),
(127, 'Dầu ăn', 'Dầu thực vật để chiên ngập', 'images/dauan.jpg', 'ml'),
(128, 'Tương ớt', 'Tương ớt để chấm kèm', 'images/tuongot.jpg', 'muỗng canh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `noidung_monan`
--

CREATE TABLE `noidung_monan` (
  `id` int(11) NOT NULL,
  `monan_id` int(11) DEFAULT NULL,
  `muc` varchar(50) DEFAULT NULL,
  `tieu_de` varchar(255) DEFAULT NULL,
  `noi_dung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `noidung_monan`
--

INSERT INTO `noidung_monan` (`id`, `monan_id`, `muc`, `tieu_de`, `noi_dung`) VALUES
(1, 1, 'de-xuat', 'Đề xuất', 'Nên đặt chỗ trước vào cuối tuần để tránh tình trạng hết bàn. Món lẩu Tomyum rất được yêu thích.'),
(2, 1, 'tom-tat', 'Tóm tắt', 'Nhà hàng phục vụ theo hình thức buffet với nhiều loại topping và nước lẩu đa dạng.'),
(3, 1, 'bang-gia', 'Bảng giá', 'Buffet người lớn: 289.000đ\nTrẻ em: 149.000đ (chưa bao gồm VAT)'),
(4, 1, 'quy-dinh', 'Quy định', 'Không mang thức ăn từ bên ngoài vào. Vui lòng đến đúng giờ đặt chỗ.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `offers`
--

INSERT INTO `offers` (`id`, `restaurant_id`, `title`, `description`, `created_at`) VALUES
(1, 1, 'Giảm 20% cho nhóm từ 4 người', 'Áp dụng từ Thứ 2 đến Thứ 5, khi đặt bàn online.', '2025-04-09 17:01:57'),
(2, 1, 'Tặng món tráng miệng miễn phí', 'Dành cho khách đặt bàn qua website.', '2025-04-09 17:01:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reset_password`
--

CREATE TABLE `reset_password` (
  `id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `thoi_gian_het_han` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `reset_password`
--

INSERT INTO `reset_password` (`id`, `nguoidung_id`, `token`, `thoi_gian_het_han`) VALUES
(9, 102, 'f3d9370b3f6417ebe9a2b6e1a6c4118e', '2025-04-09 16:45:53');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `restaurants`
--

CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `restaurants`
--

INSERT INTO `restaurants` (`id`, `name`, `description`, `address`, `image_url`, `created_at`) VALUES
(1, 'Thế Giới Hải Sản Pasteur', 'Nhà hàng chuyên hải sản tươi sống, đa dạng món ngon.', '123 Pasteur, Quận 3, TP.HCM', 'images/tomhum.jpg', '2025-04-09 17:01:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `special_menus`
--

CREATE TABLE `special_menus` (
  `id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `special_menus`
--

INSERT INTO `special_menus` (`id`, `restaurant_id`, `name`, `image_url`, `description`, `created_at`) VALUES
(1, 1, 'Tôm hùm hấp', 'images/tomhum.jpg', 'Tôm hùm hấp tươi ngon, đậm vị biển.', '2025-04-09 17:01:57'),
(2, 1, 'Sò điệp nướng mỡ hành', 'images/sonuong.jpg', 'Sò điệp béo ngậy nướng cùng mỡ hành thơm lừng.', '2025-04-09 17:01:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `ten` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tag`
--

INSERT INTO `tag` (`id`, `ten`) VALUES
(11, 'Kinh nghiệm mở quán'),
(12, 'Văn khấn thần tài đúng chuẩn nghi thức'),
(13, 'Quản lý nhà hàng'),
(14, 'Mẹo vặt gia đình'),
(15, 'Công thức các món ăn giải ngấy'),
(16, 'Công thức hot'),
(17, 'Thực đơn hàng ngày'),
(18, 'Món ngon mỗi ngày'),
(19, 'Kiến thức nhà hàng'),
(20, 'Món ngon mỗi ngày từ thịt gà');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `theloai`
--

CREATE TABLE `theloai` (
  `id` int(11) NOT NULL,
  `ten` varchar(50) NOT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thich`
--

CREATE TABLE `thich` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `thich`
--

INSERT INTO `thich` (`id`, `baiviet_id`, `nguoidung_id`) VALUES
(1, 87, 102),
(2, 92, 102),
(3, 91, 102),
(4, 90, 102),
(5, 93, 102),
(6, 89, 102),
(7, 88, 102),
(8, 86, 102),
(9, 85, 102),
(10, 85, 103),
(11, 93, 103),
(12, 90, 103),
(13, 84, 103),
(14, 84, 102),
(15, 86, 103);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thongke`
--

CREATE TABLE `thongke` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `luot_xem` int(11) DEFAULT 0,
  `luot_thich` int(11) DEFAULT 0,
  `luot_chia_se` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `video_url` varchar(500) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `videos`
--

INSERT INTO `videos` (`id`, `restaurant_id`, `video_url`, `description`, `created_at`) VALUES
(1, 1, 'videos/the-gioi-hai-san.mp4', 'Khám phá không gian và món ăn nổi bật tại nhà hàng.', '2025-04-09 17:01:57');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account_activation`
--
ALTER TABLE `account_activation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `baiviet`
--
ALTER TABLE `baiviet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tacgia_id` (`tacgia_id`);

--
-- Chỉ mục cho bảng `baiviet_images`
--
ALTER TABLE `baiviet_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`);

--
-- Chỉ mục cho bảng `baiviet_tag`
--
ALTER TABLE `baiviet_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Chỉ mục cho bảng `baiviet_theloai`
--
ALTER TABLE `baiviet_theloai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `theloai_id` (`theloai_id`);

--
-- Chỉ mục cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `cac_buoc_lam`
--
ALTER TABLE `cac_buoc_lam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`);

--
-- Chỉ mục cho bảng `congthuc`
--
ALTER TABLE `congthuc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `nguyenlieu_id` (`nguyenlieu_id`);

--
-- Chỉ mục cho bảng `congthuc_nguyenlieu`
--
ALTER TABLE `congthuc_nguyenlieu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `nguyenlieu_id` (`nguyenlieu_id`);

--
-- Chỉ mục cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `diadiem_anuong`
--
ALTER TABLE `diadiem_anuong`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `lichsuhoatdong`
--
ALTER TABLE `lichsuhoatdong`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `meo_nau_an`
--
ALTER TABLE `meo_nau_an`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`);

--
-- Chỉ mục cho bảng `monan`
--
ALTER TABLE `monan`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `nguyenlieu`
--
ALTER TABLE `nguyenlieu`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `noidung_monan`
--
ALTER TABLE `noidung_monan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `monan_id` (`monan_id`);

--
-- Chỉ mục cho bảng `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `restaurant_id` (`restaurant_id`);

--
-- Chỉ mục cho bảng `reset_password`
--
ALTER TABLE `reset_password`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `special_menus`
--
ALTER TABLE `special_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `restaurant_id` (`restaurant_id`);

--
-- Chỉ mục cho bảng `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `theloai`
--
ALTER TABLE `theloai`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `thich`
--
ALTER TABLE `thich`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

--
-- Chỉ mục cho bảng `thongke`
--
ALTER TABLE `thongke`
  ADD PRIMARY KEY (`id`),
  ADD KEY `baiviet_id` (`baiviet_id`);

--
-- Chỉ mục cho bảng `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `restaurant_id` (`restaurant_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `account_activation`
--
ALTER TABLE `account_activation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `baiviet`
--
ALTER TABLE `baiviet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT cho bảng `baiviet_images`
--
ALTER TABLE `baiviet_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT cho bảng `baiviet_tag`
--
ALTER TABLE `baiviet_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `baiviet_theloai`
--
ALTER TABLE `baiviet_theloai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `cac_buoc_lam`
--
ALTER TABLE `cac_buoc_lam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT cho bảng `congthuc`
--
ALTER TABLE `congthuc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `congthuc_nguyenlieu`
--
ALTER TABLE `congthuc_nguyenlieu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `diadiem_anuong`
--
ALTER TABLE `diadiem_anuong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `lichsuhoatdong`
--
ALTER TABLE `lichsuhoatdong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `meo_nau_an`
--
ALTER TABLE `meo_nau_an`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT cho bảng `monan`
--
ALTER TABLE `monan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT cho bảng `nguyenlieu`
--
ALTER TABLE `nguyenlieu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT cho bảng `noidung_monan`
--
ALTER TABLE `noidung_monan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `reset_password`
--
ALTER TABLE `reset_password`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `special_menus`
--
ALTER TABLE `special_menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `theloai`
--
ALTER TABLE `theloai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `thich`
--
ALTER TABLE `thich`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `thongke`
--
ALTER TABLE `thongke`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `account_activation`
--
ALTER TABLE `account_activation`
  ADD CONSTRAINT `account_activation_ibfk_1` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `baiviet`
--
ALTER TABLE `baiviet`
  ADD CONSTRAINT `baiviet_ibfk_1` FOREIGN KEY (`tacgia_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `baiviet_images`
--
ALTER TABLE `baiviet_images`
  ADD CONSTRAINT `baiviet_images_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `baiviet_tag`
--
ALTER TABLE `baiviet_tag`
  ADD CONSTRAINT `baiviet_tag_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `baiviet_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`);

--
-- Các ràng buộc cho bảng `baiviet_theloai`
--
ALTER TABLE `baiviet_theloai`
  ADD CONSTRAINT `baiviet_theloai_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `baiviet_theloai_ibfk_2` FOREIGN KEY (`theloai_id`) REFERENCES `theloai` (`id`);

--
-- Các ràng buộc cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD CONSTRAINT `binhluan_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `binhluan_ibfk_2` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `cac_buoc_lam`
--
ALTER TABLE `cac_buoc_lam`
  ADD CONSTRAINT `cac_buoc_lam_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `congthuc`
--
ALTER TABLE `congthuc`
  ADD CONSTRAINT `congthuc_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `congthuc_ibfk_2` FOREIGN KEY (`nguyenlieu_id`) REFERENCES `nguyenlieu` (`id`);

--
-- Các ràng buộc cho bảng `congthuc_nguyenlieu`
--
ALTER TABLE `congthuc_nguyenlieu`
  ADD CONSTRAINT `congthuc_nguyenlieu_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `congthuc_nguyenlieu_ibfk_2` FOREIGN KEY (`nguyenlieu_id`) REFERENCES `nguyenlieu` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `lichsuhoatdong`
--
ALTER TABLE `lichsuhoatdong`
  ADD CONSTRAINT `lichsuhoatdong_ibfk_1` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `meo_nau_an`
--
ALTER TABLE `meo_nau_an`
  ADD CONSTRAINT `meo_nau_an_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `noidung_monan`
--
ALTER TABLE `noidung_monan`
  ADD CONSTRAINT `noidung_monan_ibfk_1` FOREIGN KEY (`monan_id`) REFERENCES `monan` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `reset_password`
--
ALTER TABLE `reset_password`
  ADD CONSTRAINT `reset_password_ibfk_1` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `special_menus`
--
ALTER TABLE `special_menus`
  ADD CONSTRAINT `special_menus_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `thich`
--
ALTER TABLE `thich`
  ADD CONSTRAINT `thich_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `thich_ibfk_2` FOREIGN KEY (`nguoidung_id`) REFERENCES `nguoidung` (`id`);

--
-- Các ràng buộc cho bảng `thongke`
--
ALTER TABLE `thongke`
  ADD CONSTRAINT `thongke_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`);

--
-- Các ràng buộc cho bảng `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
