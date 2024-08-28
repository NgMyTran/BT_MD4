
CREATE TABLE VatTu (
                       maVT INT PRIMARY KEY auto_increment,
                       tenVT VARCHAR(255)
);

CREATE TABLE NhaCungCap (
                            maNCC INT PRIMARY KEY auto_increment,
                            tenNCC VARCHAR(255),
                            diaChi VARCHAR(255),
                            soDienThoai VARCHAR(11)
);

CREATE TABLE DonDatHang (
                            soDH INT PRIMARY KEY auto_increment,
                            maNCC INT,
                            ngayDH DATETIME,
                            FOREIGN KEY (maNCC) REFERENCES NhaCungCap(maNCC)
);

CREATE TABLE PhieuXuat (
                           soPX INT PRIMARY KEY auto_increment,
                           ngayXuat DATETIME
);

CREATE TABLE PhieuNhap (
                           soPN INT PRIMARY KEY auto_increment,
                           ngayNhap DATETIME
);

CREATE TABLE PhieuXuatChiTiet (
                                  soPX INT auto_increment,
                                  maVT INT,
                                  donGiaXuat DOUBLE,
                                  soLuongXuat INT,
                                  PRIMARY KEY (soPX, maVT),
                                  FOREIGN KEY (soPX) REFERENCES PhieuXuat(soPX),
                                  FOREIGN KEY (maVT) REFERENCES VatTu(maVT)
);

CREATE TABLE PhieuNhapChiTiet (
                                  soPN INT auto_increment,
                                  maVT INT,
                                  donGiaNhap DOUBLE,
                                  soLuongNhap INT,
                                  PRIMARY KEY (soPN, maVT),
                                  FOREIGN KEY (soPN) REFERENCES PhieuNhap(soPN),
                                  FOREIGN KEY (maVT) REFERENCES VatTu(maVT)
);

CREATE TABLE ChiTietDonDatHang (
                                   soDH INT,
                                   maVT INT,
                                   PRIMARY KEY (soDH, maVT),
                                   FOREIGN KEY (soDH) REFERENCES DonDatHang(soDH),
                                   FOREIGN KEY (maVT) REFERENCES VatTu(maVT)
);
INSERT INTO VatTu (maVT, tenVT) VALUES
                                    (1, 'Gạch'),
                                    (2, 'Cát'),
                                    (3, 'Xi măng'),
                                    (4, 'Thép'),
                                    (5, 'Sơn'),
                                    (6, 'Cửa gỗ'),
                                    (7, 'Gạch men'),
                                    (8, 'Ống nước'),
                                    (9, 'Kính'),
                                    (10, 'Gỗ');
INSERT INTO NhaCungCap (maNCC, tenNCC, diaChi, soDienThoai) VALUES
                                                                (1, 'Công ty Gạch ABC', '123 Đường A, Hà Nội', '0912345678'),
                                                                (2, 'Công ty VLXD XYZ', '456 Đường B, TP.HCM', '0987654321'),
                                                                (3, 'Công ty Thép Việt', '789 Đường C, Đà Nẵng', '0923456789'),
                                                                (4, 'Công ty Sơn Đẹp', '111 Đường D, Hải Phòng', '0945678912'),
                                                                (5, 'Công ty Gỗ Nam', '222 Đường E, Cần Thơ', '0934567890');
INSERT INTO DonDatHang (soDH, maNCC, ngayDH) VALUES
                                                 (1, 1, '2024-08-01 10:00:00'),
                                                 (2, 2, '2024-08-02 11:30:00'),
                                                 (3, 3, '2024-08-03 14:00:00'),
                                                 (4, 4, '2024-08-04 09:00:00'),
                                                 (5, 5, '2024-08-05 16:00:00');
INSERT INTO PhieuXuat (soPX, ngayXuat) VALUES
                                           (1, '2024-08-06 08:00:00'),
                                           (2, '2024-08-07 10:30:00'),
                                           (3, '2024-08-08 13:15:00'),
                                           (4, '2024-08-09 15:45:00'),
                                           (5, '2024-08-10 09:20:00');
INSERT INTO PhieuNhap (soPN, ngayNhap) VALUES
                                           (1, '2024-08-06 09:30:00'),
                                           (2, '2024-08-07 11:45:00'),
                                           (3, '2024-08-08 14:10:00'),
                                           (4, '2024-08-09 16:30:00'),
                                           (5, '2024-08-10 10:25:00');
INSERT INTO PhieuXuatChiTiet (soPX, maVT, donGiaXuat, soLuongXuat) VALUES
                                                                       (1, 1, 10000, 500),
                                                                       (1, 2, 20000, 300),
                                                                       (2, 3, 15000, 400),
                                                                       (2, 4, 25000, 200),
                                                                       (3, 5, 30000, 150),
                                                                       (3, 6, 45000, 100),
                                                                       (4, 7, 35000, 250),
                                                                       (4, 8, 50000, 350),
                                                                       (5, 9, 55000, 50),
                                                                       (5, 10, 60000, 75);
INSERT INTO PhieuNhapChiTiet (soPN, maVT, donGiaNhap, soLuongNhap) VALUES
                                                                       (1, 1, 9000, 550),
                                                                       (1, 2, 19000, 320),
                                                                       (2, 3, 14000, 410),
                                                                       (2, 4, 24000, 210),
                                                                       (3, 5, 29000, 160),
                                                                       (3, 6, 44000, 110),
                                                                       (4, 7, 34000, 260),
                                                                       (4, 8, 49000, 360),
                                                                       (5, 9, 54000, 60),
                                                                       (5, 10, 59000, 80);
INSERT INTO ChiTietDonDatHang (soDH, maVT) VALUES
                                               (1, 1),
                                               (1, 2),
                                               (2, 3),
                                               (2, 4),
                                               (3, 5),
                                               (3, 6),
                                               (4, 7),
                                               (4, 8),
                                               (5, 9),
                                               (5, 10);
use session4;

select * from phieuxuatchitiet;
-- Hiển thị tất cả vật tư dựa vào phiếu xuất có số lượng lớn hơn 100
select * from phieuxuatchitiet where soLuongXuat >100;
-- Hiển thị tất cả vật tư được dựa vào phiếu xuất có số lượng lớn hơn 250
select phieuxuat.ngayXuat, vattu.tenVT, phieuxuatchitiet.*
from phieuxuatchitiet
         JOIN phieuxuat ON phieuxuatchitiet.soPX = phieuxuat.soPX
         JOIN vattu ON phieuxuatchitiet.maVT = vattu.maVT
where soLuongXuat > 250
order by soLuongXuat DESC
;


SELECT * FROM phieunhap;
update PhieuNhap set ngayNhap='2024-02-12' where soPN=3 or soPN=5;


SELECT * FROM phieunhapchitiet;
-- Hiển thị tất cả vật tư mua vào ngày 12/2/2024
select phieunhap.ngayNhap, vattu.tenVT, phieunhapchitiet.*
from phieunhapchitiet
         JOIN phieunhap ON phieunhapchitiet.soPN = phieunhap.soPN
         JOIN vattu ON phieunhapchitiet.maVT = vattu.maVT
where phieunhap.ngayNhap = '2024-02-12'
;
-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 14.000
select phieunhap.ngayNhap, vattu.tenVT, phieunhapchitiet.*
from phieunhapchitiet
         JOIN phieunhap ON phieunhapchitiet.soPN = phieunhap.soPN
         JOIN vattu ON phieunhapchitiet.maVT = vattu.maVT
where donGiaNhap > 14000;


SELECT * FROM nhacungcap;
-- Hiển thị tất cả nhà cung cấp ở long biên có SoDienThoai bắt đầu với 09
INSERT INTO NhaCungCap (tenNCC, diaChi, soDienThoai) VALUES
                                                         ('Công ty VLXD Long Biên A', '100 Đường L, Long Biên, Hà Nội', '0912345678'),
                                                         ('Công ty Vật liệu Xây dựng Bắc Bộ', '300 Đường N, Hà Nội', '0312345678'),
                                                         ('Công ty Vật liệu Long Biên B', '200 Đường M, Long Biên, Hà Nội', '0923456789');

select * from nhacungcap
where diaChi LIKE '%Long Biên%' and soDienThoai LIKE '09%';