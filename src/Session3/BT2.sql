
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

SELECT * FROM session3.orderdetail;

select oId, products.* , odQuantity
from orderdetail join products ON orderdetail.oId = products.pId;

select orders.oId, customers.cName
from orderdetail
         JOIN orders ON orderdetail.oId = orders.oId
         JOIN customers ON orders.cId = customers.cid
where orderdetail.odQuantity = 0;

select orders.oDate, orders.oId, SUM(orderdetail.odQuantity * products.pPrice) total_price
from orderdetail
         join orders ON orderdetail.oId = orders.oId
         JOIN products ON orderdetail.pId = products.pId
group by orders.oId, orders.oDate
;