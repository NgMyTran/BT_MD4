
use session7_ontap;
CREATE TABLE NhaCungCap (
    MaNCC VARCHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    DienThoai VARCHAR(15) NOT NULL,
    Email VARCHAR(100)NOT NULL,
    Website VARCHAR(100)
);
CREATE TABLE PhieuNhap (
    SoPN VARCHAR(5) PRIMARY KEY,
    MaNV VARCHAR(5) REFERENCES NhanVien(MaNV),
    MaNCC VARCHAR(5) REFERENCES NhaCungCap(MaNCC),
    NgayNhap DATE default(current_date()),
    GhiChu NVARCHAR(100)
);
CREATE TABLE CTPhieuNhap (
    MaSP VARCHAR(4) REFERENCES SanPham(MaSP),
    SoPN VARCHAR(5) REFERENCES PhieuNhap(SoPN),
    SoLuong SmallINT default 0,
    GiaNhap real check(GiaNhap >= 0),
    PRIMARY KEY (MaSP, SoPN)
);
CREATE TABLE NhanVien (
    MaNV NVARCHAR(5) PRIMARY KEY NOT NULL,
    HoTen NVARCHAR(30) NOT NULL,
    GioiTinh BIT NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    NgaySinh DATE NOT NULL,
    DienThoai NVARCHAR(15),
    Email text,
    NoiSinh NVARCHAR(20) NOT NULL,
    CMND NVARCHAR(4)
);
CREATE TABLE KhachHang (
    MaKH NVARCHAR(4) PRIMARY KEY,
    TenKH NVARCHAR(30) NOT NULL,
    DiaChi NVARCHAR(50),
    NgaySinh DATE,
    SoDT NVARCHAR(15) UNIQUE
);
CREATE TABLE PhieuXuat (
    SoPX NVARCHAR(5) PRIMARY KEY,
    MaNV NVARCHAR(4) REFERENCES NhanVien(MaNV),
    MaKH NVARCHAR(4) REFERENCES KhachHang(MaKH),
    NgayBan DATE,
    GhiChu text
);
DELIMITER //
CREATE TRIGGER check_ngayban
BEFORE INSERT ON PhieuXuat
FOR EACH ROW
BEGIN
    IF NEW.NgayBan < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngày bán không được nhỏ hơn ngày hiện tại';
    END IF;
END;
//
DELIMITER ;

CREATE TABLE CTPhieuXuat (
    SoPX VARCHAR(10) REFERENCES PhieuXuat(SoPX),
    MaSP VARCHAR(10) REFERENCES SanPham(MaSP),
    SoLuong INT NOT NULL check(SoLuong >0),
    GiaBan real check(Giaban >0),
    PRIMARY KEY (SoPX, MaSP)
);
CREATE TABLE SanPham (
    MaSP VARCHAR(4) PRIMARY KEY,
    MaLoaiSP VARCHAR(4) REFERENCES LoaiSP(MaLoaiSP),
    TenSP NVARCHAR(50) NOT NULL,
    DonViTinh NVARCHAR(10),
    HinhAnh NVARCHAR(100),
    GhiChu NVARCHAR(100)
);
CREATE TABLE LoaiSP (
    MaLoaiSP VARCHAR(4) PRIMARY KEY ,
    TenLoaiSP NVARCHAR(30) NOT NULL,
    GhiChu NVARCHAR(100)
);
ALTER table  PhieuNhap add foreign key (MaNV) references NhanVien(MaNV);
ALTER table PhieuNhap add foreign key (MaNCC) references NhaCungCap(MaNCC);
ALTER table CTPhieuNhap add foreign key (SoPN) references PhieuNhap(SoPN);
ALTER table CTPhieuNhap add foreign key (MaSP) references SanPham(MaSP);
ALTER table SanPham add foreign key (MaLoaiSP) references LoaiSP(MaLoaiSP);
ALTER table CTPhieuXuat add foreign key (SoPX) references PhieuXuat(SoPX);
ALTER table CTPhieuXuat add foreign key (MaSP) references SanPham(MaSP);
ALTER TABLE PhieuNhap MODIFY COLUMN MaNV NVARCHAR(5);
ALTER TABLE NhanVien MODIFY COLUMN MaNV NVARCHAR(5);

INSERT INTO SanPham (MaSP, MaLoaiSP, TenSP, DonViTinh, HinhAnh, GhiChu) VALUES 
    ('SP01', 'L01', 'Sản phẩm A', 'Cái', 'sp01.jpg', 'Ghi chú sản phẩm A'),
    ('SP02', 'L01', 'Sản phẩm B', 'Cái', 'sp02.jpg', 'Ghi chú sản phẩm B'),
    ('SP03', 'L02', 'Sản phẩm C', 'Hộp', 'sp03.jpg', 'Ghi chú sản phẩm C'),
    ('SP04', 'L02', 'Sản phẩm D', 'Hộp', 'sp04.jpg', 'Ghi chú sản phẩm D'),
    ('SP15', 'L03', 'Sản phẩm E', 'Cái', 'sp15.jpg', 'Ghi chú sản phẩm E');
-- Thêm phiếu nhập 
INSERT INTO PhieuNhap (SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
VALUES ('PN001', 'NV05', 'NCC01', CURDATE(), 'Phiếu nhập đầu tiên');
INSERT INTO PhieuNhap (SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
VALUES ('PN002', 'NV05', 'NCC02', '2024-06-23', 'Phiếu nhập thứ hai');

INSERT INTO CTPhieuNhap (MaSP, SoPN, SoLuong, GiaNhap)
VALUES 
    ('SP01', 'PN001', 10, 1000.0),
    ('SP02', 'PN001', 20, 500.0);
INSERT INTO CTPhieuNhap (MaSP, SoPN, SoLuong, GiaNhap)
VALUES 
    ('SP03', 'PN002', 15, 750.0),
    ('SP04', 'PN002', 30, 300.0);
    
-- Thêm phiếu xuất 1
INSERT INTO PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('PX001', 'NV05', 'KH01', CURDATE(), 'Phiếu xuất đầu tiên');
INSERT INTO CTPhieuXuat (SoPX, MaSP, SoLuong, GiaBan)
VALUES 
    ('PX001', 'SP01', 5, 1200.0),
    ('PX001', 'SP02', 10, 600.0),
    ('PX001', 'SP03', 7, 800.0);
-- 2
INSERT INTO PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('PX002', 'NV05', 'KH10', CURDATE(), 'Phiếu xuất thứ hai');
INSERT INTO CTPhieuXuat (SoPX, MaSP, SoLuong, GiaBan)
VALUES 
    ('PX002', 'SP01', 8, 1200.0),
    ('PX002', 'SP02', 12, 600.0),
    ('PX002', 'SP04', 6, 300.0);

-- Thêm nhân viên mới
INSERT INTO NhanVien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, CMND) VALUES
 ('NV01', 'Nguyễn Văn H', 1, '123 Đường ABC, Hà Nội', '1983-01-01', '0901234567', 'nv.h@example.com', 'Hà Nội', '1111'),
    ('NV02', 'Trần Thị I', 0, '456 Đường DEF, TP.HCM', '1985-02-15', '0912345678', 'nv.i@example.com', 'TP.HCM', '2233'),
    ('NV03', 'Lê Văn J', 1, '789 Đường GHI, Đà Nẵng', '1987-03-20', '0923456789', 'nv.j@example.com', 'Đà Nẵng', '3344'),
    ('NV04', 'Phạm Thị K', 0, '101 Đường JKL, Cần Thơ', '1990-04-25', '0934567890', 'nv.k@example.com', 'Cần Thơ', '4455'),
 ('NV05', 'Nguyen Van A', 1, '123 Đường ABC', '1969-04-15', '0123456789', 'nv.a@example.com', 'Hà Nội', '1234');
 
 INSERT INTO KhachHang (MaKH, TenKH, DiaChi, NgaySinh, SoDT) VALUES 
    ('KH02', 'Nguyễn Văn M', '123 Đường ABC, Hà Nội', '1975-06-10', '0911122334'),
    ('KH03', 'Trần Thị N', '456 Đường DEF, TP.HCM', '1980-07-20', '0912233445'),
    ('KH04', 'Lê Văn O', '789 Đường GHI, Đà Nẵng', '1985-08-15', '0923344556'),
    ('KH05', 'Phạm Thị P', '101 Đường JKL, Cần Thơ', '1990-09-10', '0934455667'),
    ('KH06', 'Nguyễn Thị Q', '202 Đường MNO, Hải Phòng', '1995-10-05', '0945566778'),
    ('KH07', 'Trần Văn R', '303 Đường PQR, Huế', '2000-11-20', '0956677889'),
    ('KH08', 'Lê Thị S', '404 Đường STU, TP.HCM', '1980-12-25', '0967788990'),
    ('KH09', 'Phạm Văn T', '505 Đường VWX, Hà Nội', '1995-01-15', '0978899001'),
    ('KH10', 'Nguyễn Văn U', '606 Đường YZA, Đà Nẵng', '2000-02-10', '0989000112'),
    ('KH11', 'Trần Thị V', '707 Đường BCD, Cần Thơ', '1982-03-05', '0990112233');

update khachhang set SoDt= '0934567890' where maKH='KH10';
update nhanvien set DiaChi = '456 Đường XYZ, Hà Nội' where MaNV='NV05';
INSERT INTO NhanVien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, CMND) VALUES 
('NV06', 'Lê Thị D', 0, '789 Đường UVW, TP.HCM', '1988-09-25', '0956789012', 'nv.d@example.com', 'TP.HCM', '3216');
DELETE FROM NhanVien WHERE MaNV = 'NV06';
DELETE FROM SanPham WHERE MaSP = 'SP15';

#1
select * from nhanvien;
select n.MaNV, n.HoTen, n.GioiTinh, n.DiaChi, n.NgaySinh, n.DienThoai, n.Email, n.NoiSinh, n.CMND
from nhanvien n order by n.NgaySinh DESC;
#2
select 

