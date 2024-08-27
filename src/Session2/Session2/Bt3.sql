#BT3
CREATE TABLE VatTu (
                       maVT INT PRIMARY KEY,
                       tenVT VARCHAR(255)
);
CREATE TABLE NhaCungCap (
                            maNCC INT PRIMARY KEY,
                            tenNCC VARCHAR(255),
                            diaChi VARCHAR(255),
                            soDienThoai VARCHAR(11)
);

CREATE TABLE PhieuNhap (
                           soPn INT PRIMARY KEY,
                           ngayNhap DATETIME
);
CREATE TABLE PhieuNhapChiTiet (
                                  soPn INT,
                                  maVT INT,
                                  donGiaNhap DOUBLE,
                                  soLuongNhap INT,
                                  PRIMARY KEY (soPn, maVT),
                                  FOREIGN KEY (soPn) REFERENCES PhieuNhap(soPn),
                                  FOREIGN KEY (maVT) REFERENCES VatTu(maVT)
);
CREATE TABLE PhieuXuat (
                           soPx INT PRIMARY KEY,
                           ngayXuat DATETIME
);
CREATE TABLE PhieuXuatChiTiet (
                                  soPx INT,
                                  maVT INT,
                                  donGiaXuat DOUBLE,
                                  soLuongXuat INT,
                                  PRIMARY KEY (soPx, maVT),
                                  FOREIGN KEY (soPx) REFERENCES PhieuXuat(soPx),
                                  FOREIGN KEY (maVT) REFERENCES VatTu(maVT)
);
CREATE TABLE DonDatHang (
                            soDH INT PRIMARY KEY,
                            maNCC INT,
                            ngayDH DATETIME,
                            FOREIGN KEY (maNCC) REFERENCES NhaCungCap(maNCC)
);
CREATE TABLE ChiTietDonDatHang (
                                   maVT INT,
                                   soDH INT,
                                   PRIMARY KEY (maVT, soDH),
                                   FOREIGN KEY (maVT) REFERENCES VatTu(maVT),
                                   FOREIGN KEY (soDH) REFERENCES DonDatHang(soDH)
);