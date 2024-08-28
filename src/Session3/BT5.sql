
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
use session3;

SELECT * FROM account
order by account.username DESC;

SELECT * FROM bill WHERE created BETWEEN '2023-02-11' AND '2023-05-15';


select bill_detail.* , bill.id
from bill_detail
         JOIN bill ON bill_detail.id= bill.id
group by bill.id;

select * from productbt5
order by name DESC;

select * from productbt5
where stock<10;