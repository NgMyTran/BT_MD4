
# BT2
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
                             FOREIGN KEY (product_id) REFERENCES productBt5(id)
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
-- 1. Tạo stored procedure hiển thị tất cả thông tin account mà đã tạo ra 5 đơn hàng trở lên:
DELIMITER //
CREATE PROCEDURE get_accounts_with_min_5_bills()
BEGIN
    SELECT a.*
    FROM account a
    JOIN bill b ON a.id = b.acc_id
    GROUP BY a.id
    HAVING COUNT(b.id) >= 5;
END //
DELIMITER ;


-- 2.Tạo stored procedure hiển thị tất cả sản phẩm chưa được bán:
DELIMITER //
CREATE PROCEDURE get_products_not_sold()
BEGIN
    SELECT p.*
    FROM productBt5 p
    LEFT JOIN bill_detail bd ON p.id = bd.product_id
    WHERE bd.product_id IS NULL;
END //
DELIMITER ;

-- 3. Tạo stored procedure hiển thị top 2 sản phẩm được bán nhiều nhất:
DELIMITER //
CREATE PROCEDURE get_top_2_best_selling_products()
BEGIN
    SELECT p.id, p.name, SUM(bd.quantity) AS total_quantity
    FROM productBt5 p
    JOIN bill_detail bd ON p.id = bd.product_id
    GROUP BY p.id, p.name
    ORDER BY total_quantity DESC
    LIMIT 2;
END //
DELIMITER ;

-- 4.Tạo stored procedure thêm tài khoản:
DELIMITER //
CREATE PROCEDURE add_account(
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(255),
    IN p_address VARCHAR(255),
    OUT p_new_id INT
)
BEGIN
    INSERT INTO account (username, password, address)
    VALUES (p_username, p_password, p_address);
    
    SET p_new_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- 5. Tạo stored procedure truyền vào bill_id và hiển thị tất cả bill_detail của bill_id đó:
DELIMITER //
CREATE PROCEDURE add_account(
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(255),
    IN p_address VARCHAR(255),
    OUT p_new_id INT
)
BEGIN
    INSERT INTO account (username, password, address)
    VALUES (p_username, p_password, p_address);
    SET p_new_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- 6. Tạo stored procedure thêm mới `bill` và trả về `bill_id` vừa mới tạo:
DELIMITER //
CREATE PROCEDURE add_bill(
    IN p_bill_type BIT,
    IN p_acc_id INT,
    IN p_created DATETIME,
    IN p_auth_date DATETIME,
    OUT p_new_bill_id INT
)
BEGIN
    INSERT INTO bill (bill_type, acc_id, created, auth_date)
    VALUES (p_bill_type, p_acc_id, p_created, p_auth_date);
    
    SET p_new_bill_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- 7. Tạo stored procedure hiển thị tất cả sản phẩm đã được bán trên 5 sản phẩm:
DELIMITER //
CREATE PROCEDURE get_products_sold_more_than_5()
BEGIN
    SELECT p.id, p.name, SUM(bd.quantity) AS total_quantity
    FROM productBt5 p
    JOIN bill_detail bd ON p.id = bd.product_id
    GROUP BY p.id, p.name
    HAVING total_quantity > 5;
END //
DELIMITER ;
