

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

use session4;

SELECT * FROM orders;
-- Hiển thị tất cả customer có đơn hàng trên 150000
select * from orders
where oTotalPrice > 150000;

SELECT * FROM products;
-- Hiển thị sản phẩm có giá tiền lớn nhất
select products.*, MAX(pPrice)
from products
group by pId
having MAX(pPrice) = (
    select MAX(pPrice)
    from products
    group by pId
    order by MAX(pPrice) DESC limit 1
    );

SELECT * FROM session4.orders;
-- Hiển thị tất cả đơn hàng có tổng giá tiền lớn nhất
select orders.oId, customers.cName, MAX(oTotalPrice) as biggest_total
from orders
         JOIN customers ON orders.cId = customers.cId
group by orders.oId, customers.cName
having MAX(oTotalPrice)= (
-- đơn hàng có tổng giá tiền lớn nhất (
    select MAX(oTotalPrice) from orders
    group by orders.oId
    order by MAX(oTotalPrice) DESC limit 1
-- )
    );

SELECT * FROM orderdetail;
-- Hiển thị sản phẩm chưa được bán cho bất cứ ai
SELECT * FROM orderdetail;
select products.pId, pName as sản_phẩm_chưa_bán
from products
         LEFT JOIN orderdetail ON orderdetail.pId= products.pId
where orderdetail.odQuantity is NULL;

-- Hiển thị tất cả đơn hàng mua trên 2 sản phẩm
SELECT * FROM orderdetail where odQuantity >2;

-- Hiển thị người dùng nào mua nhiều sản phẩm “Bep Dien” --> "dieu hoa" nhất
-- odQuantity lớn nhất của 3.Dieu hoa
select orderdetail.*, customers.cName, MAX(odQuantity)
from orderdetail
-- người mua
         JOIN orders ON orderdetail.oId = orders.oId
         JOIN customers ON customers.cid = orders.cId
-- sp la dieu hoa
where pId = 3
group by oId, pId, customers.cName
order by MAX(odQuantity) DESC limit 1
;