
use session3;
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
                                                 (1, 1, '2023-08-01 10:00:00'),
                                                 (2, 2, '2023-08-02 11:30:00'),
                                                 (3, 3, '2023-08-03 14:00:00'),
                                                 (4, 4, '2023-08-04 09:00:00'),
                                                 (5, 5, '2023-08-05 16:00:00');
INSERT INTO PhieuXuat (soPX, ngayXuat) VALUES
                                           (1, '2023-08-06 08:00:00'),
                                           (2, '2023-08-07 10:30:00'),
                                           (3, '2023-08-08 13:15:00'),
                                           (4, '2023-08-09 15:45:00'),
                                           (5, '2023-08-10 09:20:00');
INSERT INTO PhieuNhap (soPN, ngayNhap) VALUES
                                           (1, '2023-08-06 09:30:00'),
                                           (2, '2023-08-07 11:45:00'),
                                           (3, '2023-08-08 14:10:00'),
                                           (4, '2023-08-09 16:30:00'),
                                           (5, '2023-08-10 10:25:00');
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


SELECT * FROM session3.chitietdondathang;
select vattu.maVT, sum(phieuxuatchitiet.soLuongXuat) soLuongBan
from chitietdondathang
         JOIN vattu ON chitietdondathang.maVT = vattu.maVT
         JOIN phieuxuatchitiet ON chitietdondathang.maVT = phieuxuatchitiet.maVT
GROUP by vattu.maVT
order by soLuongBan DESC
    limit 1
;


SELECT * FROM session3.phieunhapchitiet;
#select vattu.maVT, vattu.tenVT,
#SUM(phieuxuatchitiet.soLuongXuat) as soLuongBan,
#SUM(phieunhapchitiet.soLuongNhap) as soLuongMuaVao,
#soLuongBan - soLuongMuaVao soLuongTonKho
#from phieunhapchitiet
#JOIN vattu ON phieunhapchitiet.maVT = vattu.maVT
#JOIN phieuxuatchitiet ON phieuxuatchitiet.maVT=vattu.maVT
#GROUP BY vattu.maVT, vattu.tenVT
#order by soLuongTonKho ASC
#limit 1
#;
select vattu.maVT, vattu.tenVT,
       SUM(phieuxuatchitiet.soLuongXuat) soLuongBan,
       SUM(phieunhapchitiet.soLuongNhap) soLuongMuaVao,
       SUM(phieuxuatchitiet.soLuongXuat) - SUM(phieunhapchitiet.soLuongNhap) as soLuongTonKho
from vattu
         LEFT JOIN phieuxuatchitiet ON vattu.maVT = phieuxuatchitiet.maVT
         LEFT JOIN phieunhapchitiet ON phieunhapchitiet.maVT=vattu.maVT
GROUP BY vattu.maVT, vattu.tenVT
order by soLuongTonKho ASC
    limit 1
;


SELECT * FROM session3.dondathang;
select nhacungcap.maNCC, nhacungcap.tenNCC, dondathang.ngayDH
from dondathang
         JOIN nhacungcap ON nhacungcap.maNCC = dondathang.maNCC
where dondathang.ngayDH between '2023-08-03' and '2023-08-05'
;
select vattu.maVT, vattu.tenVT,
       nhacungcap.maNCC, nhacungcap.tenNCC,
       dondathang.ngayDH
from dondathang
         JOIN nhacungcap ON nhacungcap.maNCC = dondathang.maNCC
         JOIN chitietdondathang ON chitietdondathang.maVT = dondathang.soDH
         JOIN vattu ON chitietdondathang.maVT = vattu.maVT
WHERE dondathang.ngayDH BETWEEN '2023-08-02' AND '2023-08-04'
order by nhacungcap.tenNCC, vattu.tenVT
;