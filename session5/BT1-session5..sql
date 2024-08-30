#Bt1
use session5;
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orderDetail DROP FOREIGN KEY orderDetail_ibfk_1;
ALTER TABLE orderDetail DROP FOREIGN KEY orderDetail_ibfk_2;
drop table if exists customers;
drop table if exists orders;
drop table if exists products;
drop table if exists orderDetail;

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
                                                  (2,5,4),
                                                  (2,3,3);
-- 1.Tạo view hiển thị tất cả customer:
create view view_customer as
select * from customers;

-- 2.Tạo view hiển thị tất cả order có oTotalPrice trên 150000:
drop view if exists view_orders_above_150000;
create view view_orders_above_150000 AS
select * from session4.orders 
where orders.oTotalPrice > 150000;

-- 3.Đánh index cho bảng customers ở cột cName:
create index idx_customer_name ON customers(cName);
-- 4.Đánh index cho bảng products ở cột pName:
create index idx_product_name ON products(pName);

-- 5.Tạo stored procedure hiển thị ra đơn hàng có tổng tiền bé nhất:
delimiter //
create procedure order_with_min_total_price()
begin
select * from session4.orders order by oTotalPrice ASc limit 1;
end //
delimiter ;

-- 6. Tạo stored procedure hiển thị người dùng nào mua sản phẩm "May Giat" ít nhất:
DELIMITER //
CREATE PROCEDURE get_customer_least_purchased_washing_machine()
BEGIN
 SELECT c.cId, c.cName, SUM(od.odQuantity) AS total_quantity
    FROM session4.customers c
    JOIN session4.orders o ON c.cid = o.cId
    JOIN session4.orderDetail od ON o.oId = od.oId
    JOIN session4.products p ON od.pId = p.pId
    WHERE p.pName = 'May giat'
    GROUP BY c.cId, c.cName
    ORDER BY total_quantity ASC
    LIMIT 1;
END //
DELIMITER ;