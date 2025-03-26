CREATE TABLE nguoidung (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    matkhau VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    vai_tro ENUM('admin', 'author', 'user') NOT NULL,
    ngay_dang_ky DATE DEFAULT CURRENT_DATE
);

CREATE TABLE baiviet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tieude VARCHAR(255) NOT NULL,
    noidung TEXT NOT NULL,
    tacgia_id INT,
    ngay_dang DATE DEFAULT CURRENT_DATE,
    anh_minh_hoa VARCHAR(255),
    danh_muc VARCHAR(50),
    FOREIGN KEY (tacgia_id) REFERENCES nguoidung(id)
);

CREATE TABLE nguyenlieu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(100) NOT NULL,
    mota TEXT,
    anh_minh_hoa VARCHAR(255)
);

CREATE TABLE congthuc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    nguyenlieu_id INT NOT NULL,
    so_luong VARCHAR(50),
    buoc_lam TEXT,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (nguyenlieu_id) REFERENCES nguyenlieu(id)
);

CREATE TABLE theloai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(50) NOT NULL,
    mo_ta TEXT
);

CREATE TABLE baiviet_theloai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    theloai_id INT NOT NULL,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (theloai_id) REFERENCES theloai(id)
);

CREATE TABLE tag (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(50) NOT NULL
);

CREATE TABLE baiviet_tag (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (tag_id) REFERENCES tag(id)
);

CREATE TABLE binhluan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    noidung TEXT NOT NULL,
    baiviet_id INT NOT NULL,
    nguoidung_id INT NOT NULL,
    thoi_gian DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id)
);

CREATE TABLE danhgia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    nguoidung_id INT NOT NULL,
    diem INT CHECK(diem BETWEEN 1 AND 5),
    thoi_gian DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id)
);

CREATE TABLE thich (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    nguoidung_id INT NOT NULL,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id),
    FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id)
);

CREATE TABLE lichsuhoatdong (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nguoidung_id INT NOT NULL,
    hoatdong VARCHAR(255) NOT NULL,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id)
);

CREATE TABLE thongke (
    id INT AUTO_INCREMENT PRIMARY KEY,
    baiviet_id INT NOT NULL,
    luot_xem INT DEFAULT 0,
    luot_thich INT DEFAULT 0,
    luot_chia_se INT DEFAULT 0,
    FOREIGN KEY (baiviet_id) REFERENCES baiviet(id)
);
