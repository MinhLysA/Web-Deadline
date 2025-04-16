-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 10, 2025 lúc 04:37 AM
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
  `danh_muc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `baiviet`
--

INSERT INTO `baiviet` (`id`, `tieude`, `noidung`, `tacgia_id`, `ngay_dang`, `anh_minh_hoa`, `danh_muc`) VALUES
(1, 'Cách làm bánh mì', 'Hướng dẫn chi tiết cách làm bánh mì ngon tại nhà...', 65, '2025-03-25', 'images/banhmi.jpg', 'Món Việt'),
(2, 'Món chay ngon', 'Công thức chế biến món chay hấp dẫn...', 2, '2025-03-26', 'images/monchay.jpg', 'Món Âu'),
(3, 'Bí quyết làm phở bò', 'Bí quyết để có tô phở bò thơm ngon...', 13, '2025-03-24', 'images/pho.jpg', 'Món chay'),
(4, 'Công thức làm bánh mì tại nhà', 'Hướng dẫn từng bước để làm bánh mì thơm ngon...', 66, '2025-03-25', 'images/banhmi.jpg', 'Món nướng'),
(5, 'Món chay giàu dinh dưỡng', 'Hướng dẫn chế biến các món chay tốt cho sức khỏe...', 15, '2025-03-26', 'images/monchay.jpg', 'Món tráng miệng'),
(6, 'Bí quyết làm phở bò thơm ngon', 'Bí quyết nấu phở bò chuẩn vị truyền thống...', 3, '2025-03-27', 'images/pho.jpg', 'Món hải sản'),
(7, 'Cách làm pizza tại nhà', 'Công thức làm pizza đơn giản và ngon như ngoài tiệm...', 1, '2025-03-28', 'images/pizza.jpg', 'Món ăn sáng'),
(8, 'Salad trộn thanh mát', 'Hướng dẫn làm salad trộn nhanh chóng và ngon miệng...', 62, '2025-03-29', 'images/salad.jpg', 'Món ăn vặt'),
(22, 'Xôi Xéo', 'Xôi xéo là món ăn sáng phổ biến ở miền Bắc Việt Nam, được làm từ gạo nếp dẻo, đậu xanh nghiền, hành phi và mỡ gà.', 1, '2025-04-08', 'images/xoi_xeo.jpg', 'Ăn uống'),
(23, 'Phở Hà Nội', 'Phở Hà Nội là món ăn truyền thống nổi tiếng với nước dùng đậm đà.', 1, '2025-04-08', 'images/pho.jpg', 'Ăn uống'),
(24, 'Bún Chả', 'Bún chả là món ăn đặc trưng của Hà Nội với thịt nướng thơm ngon.', 68, '2025-04-08', 'images/buncha.jpg', 'Ăn uống'),
(25, 'Cơm Tấm', 'Cơm tấm là món ăn đặc sản của miền Nam, gồm cơm tấm, sườn nướng.', 1, '2025-04-08', 'images/comtam.jpg', 'Ăn uống'),
(26, 'Bánh Canh', 'Bánh canh là món ăn truyền thống với sợi bánh canh mềm dai, nước dùng đậm đà, thường được ăn kèm với tôm, cua, hoặc thịt.', 64, '2025-04-08', 'images/banhcanh.jpg', 'Ăn uống'),
(27, 'Hủ Tiếu', 'Hủ tiếu là món ăn phổ biến ở miền Nam Việt Nam, với nước dùng thanh ngọt, sợi hủ tiếu mềm, ăn kèm thịt heo, tôm, và rau sống.', 1, '2025-04-08', 'images/hutieu.jpg', 'Ăn uống'),
(28, 'Bánh Bèo', 'Bánh bèo là món ăn đặc sản miền Trung, được làm từ bột gạo, ăn kèm tôm cháy, hành phi, và nước mắm chua ngọt.', 63, '2025-04-08', 'images/banhbeo.jpg', 'Ăn uống'),
(29, 'Nem Rán', 'Nem rán là món ăn truyền thống của Việt Nam, được làm từ thịt băm, miến, mộc nhĩ, cuốn trong bánh tráng và chiên giòn.', 1, '2025-04-08', 'images/nemran.jpg', 'Ăn uống'),
(30, 'Chả Giò', 'Chả giò là món ăn tương tự nem rán, nhưng thường được làm với nhân tôm, thịt, và rau củ, cuốn trong bánh tráng mỏng.', 1, '2025-04-08', 'images/chagio.jpg', 'Ăn uống'),
(31, 'Bún Riêu', 'Bún riêu là món ăn đặc trưng với nước dùng chua thanh, riêu cua, cà chua, và bún tươi.', 1, '2025-04-08', 'images/bunrieu.jpg', 'Ăn uống'),
(32, 'Bánh Tét', 'Bánh tét là món ăn truyền thống ngày Tết, được làm từ gạo nếp, nhân đậu xanh, thịt mỡ, và gói trong lá chuối.', 67, '2025-04-08', 'images/banhtet.jpg', 'Ăn uống'),
(33, 'Gà Nướng Mật Ong', 'Gà nướng mật ong là món ăn hấp dẫn với lớp da gà giòn, thơm mùi mật ong, thịt gà mềm ngọt.', 1, '2025-04-08', 'images/ganuong.jpg', 'Ăn uống'),
(84, 'Đồ Chiên Ăn Vặt – Món Ngon Giòn Rụm Dễ Làm Tại Nhà', 'Đồ chiên ăn vặt luôn là một trong những món khoái khẩu của nhiều người, đặc biệt là giới trẻ. Hãy cùng khám phá cách làm món ăn này tại nhà.', 61, '2025-04-01', 'images/dochien.jpg', 'Công thức nấu ăn'),
(85, 'Hoa Bánh Căn – Món Bánh Giòn Ngon Đặc Sản Miền Trung', 'Hoa bánh căn không chỉ là một món ăn đặc trưng của miền Trung mà còn mang trong mình hương vị truyền thống khó quên.', 62, '2025-04-02', 'images/hoabanhcan.jpg', 'Công thức nấu ăn'),
(86, 'Bánh Mì Chả Cá – Món Ăn Sáng Tiện Lợi Và Đầy Dinh Dưỡng', 'Bánh mì chả cá là một món ăn sáng phổ biến ở Việt Nam, đặc biệt là ở các thành phố lớn. Hãy cùng tìm hiểu cách làm món ăn này.', 63, '2025-04-03', 'images/banhmichaca.jpg', 'Công thức nấu ăn'),
(87, 'Bún Bò Huế – Hương Vị Đậm Đà Khó Quên', 'Bún bò Huế là một món ăn đặc trưng của miền Trung Việt Nam, nổi tiếng với hương vị đậm đà và cách chế biến độc đáo.', 64, '2025-04-04', 'images/bunbohue.jpg', 'Công thức nấu ăn'),
(88, 'Cách Làm Kem Truyền Thống Thơm Ngon Tại Nhà', 'Kem truyền thống là món tráng miệng yêu thích của nhiều người. Hãy cùng khám phá cách làm kem đơn giản tại nhà.', 65, '2025-04-05', 'images/kem.jpg', 'Công thức nấu ăn'),
(89, 'Cách Làm Kem Chuối Sữa Chua Béo Ngậy', 'Kem chuối sữa chua là món ăn giải nhiệt tuyệt vời cho mùa hè. Công thức này rất đơn giản và dễ làm tại nhà.', 66, '2025-04-06', 'images/kemchuoi.jpg', 'Công thức nấu ăn'),
(90, 'Tiramisu – Hương Vị Tinh Tế Chinhgeten Mọi Tín Đồ Ẩm Thực', 'Tiramisu là món bánh tráng miệng nổi tiếng của Ý, với hương vị cà phê và kem phô mai đặc trưng.', 67, '2025-04-07', 'images/tiramisu.jpg', 'Công thức nấu ăn'),
(91, 'Bánh Flan – Món Tráng Miệng Ngọt Ngào Dễ Làm', 'Bánh flan là món tráng miệng phổ biến với hương vị ngọt ngào và mềm mịn. Hãy cùng học cách làm món bánh này.', 97, '2025-04-08', 'images/flan.jpg', 'Công thức nấu ăn'),
(92, 'Chè Đậu Xanh – Món Chè Thanh Mát Giải Nhiệt', 'Chè đậu xanh là món ăn giải nhiệt tuyệt vời, đặc biệt phù hợp cho những ngày hè nóng bức.', 98, '2025-04-09', 'images/chedauxanh.jpg', 'Công thức nấu ăn'),
(93, 'Cách Làm Bánh Xèo Giòn Rụm Tại Nhà', 'Bánh xèo là món ăn truyền thống của Việt Nam, với lớp vỏ giòn rụm và nhân tôm thịt hấp dẫn.', 96, '2025-04-10', 'images/banhxeo.jpg', 'Công thức nấu ăn'),
(94, 'Cách làm Phở Bò Hà Nội', 'Video hướng dẫn nấu phở bò truyền thống Hà Nội.', 59, '2025-04-01', 'images/phobo.jpg', 'video'),
(95, 'Bún Chả Obama', 'Video cách làm bún chả ngon như ở Hà Nội.', 60, '2025-04-02', 'images/buncha.jpg', 'video'),
(96, 'Cơm Tấm Sài Gòn', 'Hướng dẫn làm cơm tấm chuẩn vị miền Nam.', 61, '2025-04-03', 'images/comtam.jpg', 'video'),
(97, 'Lẩu Thái Hải Sản', 'Cách nấu lẩu Thái chua cay tại nhà.', 15, '2025-04-04', 'images/lauthai.jpg', 'video'),
(98, 'Bánh Xèo Miền Tây', 'Video làm bánh xèo giòn rụm.', 17, '2025-04-05', 'images/banhxeo.jpg', 'video'),
(99, 'Chè Ba Màu', 'Cách làm chè ba màu mát lạnh.', 20, '2025-04-06', 'images/chebamau.jpg', 'video'),
(100, 'Gỏi Cuốn Tôm Thịt', 'Video cuốn gỏi tươi ngon.', 1, '2025-04-07', 'images/goicuon.jpg', 'video'),
(101, 'Nhà hàng Phở 24 - Hà Nội', 'Phở 24 là một địa điểm nổi tiếng với món phở bò truyền thống.', 59, '2025-04-01', 'images/pho.jpg', 'diadiem'),
(102, 'Quán Bún Chả Hàng Mành - Hà Nội', 'Bún chả Hàng Mành nổi tiếng với hương vị đậm đà.', 60, '2025-04-02', 'images/buncha.jpg', 'diadiem'),
(103, 'Nhà hàng Cơm Tấm Ba Ghiền - TP.HCM', 'Cơm tấm Ba Ghiền là địa chỉ yêu thích tại Sài Gòn.', 61, '2025-04-03', 'images/comtam.jpg', 'diadiem'),
(104, 'Quán Lẩu Thái 123 - Đà Nẵng', 'Lẩu Thái 123 mang đến trải nghiệm ẩm thực chua cay đặc trưng.', 15, '2025-04-04', 'images/lauthai.jpg', 'diadiem');

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
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `id` int(11) NOT NULL,
  `baiviet_id` int(11) NOT NULL,
  `nguoidung_id` int(11) NOT NULL,
  `diem` int(11) DEFAULT NULL CHECK (`diem` between 1 and 5),
  `thoi_gian` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(102, 'khoa', '99.dangkhoa.10@gmail.com', '$2y$10$FE2nGAMsKvnHOuojQvD7D.2Y/LCLMMF6F4zXI5cJfFmIZ/5tN4Jtm', NULL, 'user', '2025-04-09', 1),
(103, 'user1', 'khoa2005dk@gmail.com', '$2y$10$yZZEL.V1unUQEPDB9bIl8uFsenadfsU0IGtBUTuwHih0qrsg169w6', NULL, 'user', '2025-04-09', 1),
(104, 'Admin', 'admin@gmail.com', '$2y$10$FE2nGAMsKvnHOuojQvD7D.2Y/LCLMMF6F4zXI5cJfFmIZ/5tN4Jtm', NULL, 'admin', '2025-04-09', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguyenlieu`
--

CREATE TABLE `nguyenlieu` (
  `id` int(11) NOT NULL,
  `ten` varchar(100) NOT NULL,
  `mota` text DEFAULT NULL,
  `anh_minh_hoa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguyenlieu`
--

INSERT INTO `nguyenlieu` (`id`, `ten`, `mota`, `anh_minh_hoa`) VALUES
(1, 'Bột mì', 'Nguyên liệu chính để làm bánh mì.', 'botmi.jpg'),
(2, 'Rau củ', 'Rau củ tươi để làm món chay.', 'raucu.jpg'),
(3, 'Thịt bò', 'Thịt bò loại ngon để làm phở bò.', 'thitbo.jpg');

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
-- Chỉ mục cho bảng `congthuc`
--
ALTER TABLE `congthuc`
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
-- Chỉ mục cho bảng `lichsuhoatdong`
--
ALTER TABLE `lichsuhoatdong`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoidung_id` (`nguoidung_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `baiviet`
--
ALTER TABLE `baiviet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `congthuc`
--
ALTER TABLE `congthuc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `lichsuhoatdong`
--
ALTER TABLE `lichsuhoatdong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `monan`
--
ALTER TABLE `monan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT cho bảng `nguyenlieu`
--
ALTER TABLE `nguyenlieu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Các ràng buộc cho bảng `congthuc`
--
ALTER TABLE `congthuc`
  ADD CONSTRAINT `congthuc_ibfk_1` FOREIGN KEY (`baiviet_id`) REFERENCES `baiviet` (`id`),
  ADD CONSTRAINT `congthuc_ibfk_2` FOREIGN KEY (`nguyenlieu_id`) REFERENCES `nguyenlieu` (`id`);

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
