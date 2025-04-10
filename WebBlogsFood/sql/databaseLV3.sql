
-- Tạo bảng món ăn
CREATE TABLE monan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(255),
    dia_chi TEXT,
    loai_hinh VARCHAR(255),
    gia VARCHAR(255),
    mo_ta TEXT,
    hinh_anh TEXT
);

-- Tạo bảng nội dung chi tiết món ăn
CREATE TABLE noidung_monan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    monan_id INT,
    muc VARCHAR(50),  -- Ví dụ: de-xuat, tom-tat, bang-gia, quy-dinh
    tieu_de VARCHAR(255),
    noi_dung TEXT,
    FOREIGN KEY (monan_id) REFERENCES monan(id) ON DELETE CASCADE
);

-- Chèn dữ liệu mẫu vào bảng monan
INSERT INTO monan (ten, dia_chi, loai_hinh, gia, mo_ta, hinh_anh)
VALUES (
    'Rakuen Hotpot - Lê Văn Sỹ',
    'Số 483 Lê Văn Sỹ, P.12, Q.3',
    'Buffet Lẩu',
    '250.000 - 350.000đ/người',
    'Rakuen Hotpot là địa điểm lý tưởng để thưởng thức buffet lẩu đa dạng với không gian hiện đại và thoải mái.',
    'https://example.com/images/lau-rakuen.jpg'
);

-- Chèn dữ liệu mẫu vào bảng noidung_monan
INSERT INTO noidung_monan (monan_id, muc, tieu_de, noi_dung)
VALUES
(1, 'de-xuat', 'Đề xuất', 'Nên đặt chỗ trước vào cuối tuần để tránh tình trạng hết bàn. Món lẩu Tomyum rất được yêu thích.'),
(1, 'tom-tat', 'Tóm tắt', 'Nhà hàng phục vụ theo hình thức buffet với nhiều loại topping và nước lẩu đa dạng.'),
(1, 'bang-gia', 'Bảng giá', 'Buffet người lớn: 289.000đ\nTrẻ em: 149.000đ (chưa bao gồm VAT)'),
(1, 'quy-dinh', 'Quy định', 'Không mang thức ăn từ bên ngoài vào. Vui lòng đến đúng giờ đặt chỗ.');

CREATE TABLE IF NOT EXISTS restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255),
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    video_url VARCHAR(500) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS special_menus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(500),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS offers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);
-- Nhà hàng mẫu
INSERT INTO restaurants (name, description, address, image_url)
VALUES ('Thế Giới Hải Sản Pasteur', 'Nhà hàng chuyên hải sản tươi sống, đa dạng món ngon.', '123 Pasteur, Quận 3, TP.HCM', 'images/hai-san.jpg');

-- Video demo
INSERT INTO videos (restaurant_id, video_url, description)
VALUES (1, 'videos/the-gioi-hai-san.mp4', 'Khám phá không gian và món ăn nổi bật tại nhà hàng.');

-- Thực đơn mẫu
INSERT INTO special_menus (restaurant_id, name, image_url, description)
VALUES
(1, 'Tôm hùm hấp', 'images/tom-hum.webp', 'Tôm hùm hấp tươi ngon, đậm vị biển.'),
(1, 'Sò điệp nướng mỡ hành', 'images/so-nương.jnp', 'Sò điệp béo ngậy nướng cùng mỡ hành thơm lừng.');

-- Ưu đãi mẫu
INSERT INTO offers (restaurant_id, title, description)
VALUES
(1, 'Giảm 20% cho nhóm từ 4 người', 'Áp dụng từ Thứ 2 đến Thứ 5, khi đặt bàn online.'),
(1, 'Tặng món tráng miệng miễn phí', 'Dành cho khách đặt bàn qua website.');
