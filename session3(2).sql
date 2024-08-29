use session3;
# Bt1
create table product(
                        id int primary key auto_increment,
                        name varchar (100),
                        created date
);
create table color(
                      id int primary key auto_increment,
                      name varchar (100),
                      status bit default (1)
);
create table size(
                     id int primary key auto_increment,
                     name varchar (100),
                     status bit default (1)
);
create table product_detail(
                        id int primary key auto_increment,
                        price double,
                        stock int,
                        status bit,
                        product_id int,
                        color_id int,
                        size_id int,
                        foreign key (product_id) references Product(id),
                        foreign key (color_id) references Color(id),
                        foreign key (size_id) references Size(id)
);
insert into color(name, status) values ('Red', null), ('Blue', null), ('Green', null);
insert into size(name) values ('X'), ('M'), ('M'), ('L'), ('XL'), ('XXL');
insert into product(name, created) values
('Quần dài', '1990-05-12'),
('Áo dài', '2005-10-05'),
('Mũ phớt', '1995-07-07');
insert into product_detail(product_id, color_id, size_id, price, stock) values
(1,1,1,1200,5),
(2,1,1,1500,2),
(1,2,3,500,3),
(1,2,3,1600,3),
(3,1,4,1200,5),
(3,3,5,1200,6),
(2,3,5,2000,10);




use session3;
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orderdetail DROP FOREIGN KEY orderdetail_ibfk_1;
ALTER TABLE orderdetail DROP FOREIGN KEY orderdetail_ibfk_2;
drop table if exists customers;
drop table if exists orders;
drop table if exists products;
drop table if exists orderDetail;
#BT2
create table customers(
                          cid int primary key auto_increment,
                          cName varchar (255),
                          cAge int
);
create table orders(
                       oId int primary key auto_increment,
                       oDate date,
                       oTotalPrice double,
                       cId int,
                       foreign key (cId) references customers(cid)
);
create table products(
                         pId int primary key auto_increment,
                         pName varchar (255),
                         pPrice double
);
CREATE TABLE orderDetail (
    oId INT,
    pId INT,
    odQuantity INT,
    PRIMARY KEY (oId, pId),
    FOREIGN KEY (oId) REFERENCES orders(oId),
    FOREIGN KEY (pId) REFERENCES products(pId)
);
insert into customers(cName, cAge) values
('Minh Quan', 10),
('Ngoc Oanh', 20),
('Hong Ha ', 50);
insert into orders(cId, oDate, oTotalPrice) values
(1,'2006-03-21', 150000),
(2,'2006-03-23', 200000),
(1,'2006-03-16', 170000);
insert into products(pName, pPrice) values
('May giat', 300),
('Tu lanh', 500),
('Dieu hoa', 700),
('Quat', 100),
('Bep dien', 200),
('May hut mui', 500);
insert into orderDetail(oId, pId, odQuantity) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(3,0,0),
(2,5,4),
(2,3,3);



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



#BT4
use session3;
ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_2;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_1;
drop table if exists Class;
drop table if exists Student;
drop table if exists Subjects;
drop table if exists Mark;
CREATE TABLE Class(
id int primary key auto_increment,
class_name varchar (100),
start_date datetime,
# select month(curdate());
#select day(curdate());
# select now(): ng tha năm h now
status bit default (1)
);
CREATE TABLE Student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(11),
    status BIT default(true),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Class(id)
);
CREATE TABLE Subjects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    credit INT,
    status BIT
);
CREATE TABLE Mark (
   mark_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT,
    student_id INT,
    point DOUBLE,
    exam_time DATETIME,
  #  PRIMARY KEY (subject_id, student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(id),
    FOREIGN KEY (student_id) REFERENCES Student(id)
);
insert into Class (class_name, start_date) values 
('HN-JV231103', '2023-11-03'),
('HN-JV231229', '2023-12-29'),
('HN-JV230615', '2023-06-15');
insert into Student (name, address, phone, class_id) values 
('Hồ Da Hùng', 'Hà Nội', '0987654321', 1),
('Phan Văn Giang', 'Đà Nẵng', '096781125', 1),
('Dương Mỹ Huyền', 'Hà Nội', '0385546611', 2),
('Hoàng Minh Hiếu', 'Nghệ An', '0964425633', 2),
('Nguyễn Vịnh', 'Hà Nội', '0975123552', 3),
('Nam Cao', 'Hà Tĩnh', '0919191919', 1),
('Nguyễn Du', 'Nghệ An', '0353535353', 3);
insert into Subjects (name, credit) values 
('Toán', 3),
('Văn', 3),
('Anh', 2);
INSERT INTO Mark (subject_id, student_id, point, exam_time) VALUES 
(1, 1, 7, '2024-05-12'),
(1, 1, 7, '2024-03-15'),
(2, 2, 8, '2024-05-15'),
(2, 3, 9, '2024-08-03'),
(3, 3, 10, '2024-02-11');




#BT5
use session3;
ALTER TABLE bill DROP FOREIGN KEY bill_ibfk_1;
ALTER TABLE bill_detail DROP FOREIGN KEY bill_detail_ibfk_1;
drop table if exists account;
drop table if exists bill;
drop table if exists productBt5;
drop table if exists bill_detail;

CREATE TABLE account (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    password VARCHAR(255),
    address VARCHAR(255),
    status BIT default (1)
);
CREATE TABLE bill (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bill_type BIT,
    acc_id INT,
    created DATETIME,
    auth_date DATETIME,
    FOREIGN KEY (acc_id) REFERENCES account(id)
);

CREATE TABLE productBt5 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    created DATE,
    price DOUBLE,
    stock INT,
    status BIT default (1)
);
CREATE TABLE bill_detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (bill_id) REFERENCES bill(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);
insert into account (username, password, address) values 
('Hùng', '123456', 'Nghệ An'),
('Cường', '654321', 'Hà nội'),
('Bách', '135790', 'Hà Nội');
insert into bill (bill_type, acc_id, created, auth_date) values
(0, 1, '2022-02-11', '2022-03-12'),
(0, 1, '2023-10-05', '2023-10-10'),
(1, 2, '2024-05-15', '2024-05-20'),
(1, 3, '2022-02-01', '2022-10-23');
insert into productBt5(name, created, price, stock) values
('Quần dài', '2022-03-12',1200,5),
('Áo dài', '2023-03-15',1500,8),
('Mũ cối', '1999-03-08',1600,10);
insert into bill_detail (bill_id, product_id, quantity, price) values
(1,1,3,1200),
(1,2,4,1500),
(2,1,1,1200),
(3,2,4,1500),
(4,3,7,1600);