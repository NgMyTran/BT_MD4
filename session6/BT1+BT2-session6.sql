use session6;
ALTER TABLE shopping_cart DROP FOREIGN KEY shopping_cart_ibfk_1;
ALTER TABLE shopping_cart DROP FOREIGN KEY shopping_cart_ibfk_2;
drop table if exists users;
drop table if exists products;
drop table if exists shopping_cart;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(11),
    dateOfBirth DATE,
    status BIT
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DOUBLE,
    stock INT,
    status BIT
);

CREATE TABLE shopping_cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    amount DOUBLE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO users (name, address, phone, dateOfBirth, status) VALUES
('John Doe', '123 Maple Street', '5551234567', '1985-06-15', 1),
('Jane Smith', '456 Oak Avenue', '5559876543', '1990-09-25', 1),
('Mike Johnson', '789 Pine Road', '5553456789', '1978-12-05', 1),
('Emily Davis', '321 Elm Street', '5552345678', '1995-03-17', 1);
INSERT INTO products (name, price, stock, status) VALUES
('Laptop', 899.99, 10, 1),
('Smartphone', 699.99, 25, 1),
('Headphones', 199.99, 50, 1),
('Keyboard', 49.99, 100, 1),
('Monitor', 249.99, 15, 1);
INSERT INTO shopping_cart (user_id, product_id, quantity, amount) VALUES
(1, 1, 1, 899.99),    -- John Doe buys 1 Laptop
(2, 2, 2, 1399.98),   -- Jane Smith buys 2 Smartphones
(3, 3, 1, 199.99),    -- Mike Johnson buys 1 Headphones
(4, 4, 3, 149.97),    -- Emily Davis buys 3 Keyboards
(1, 5, 1, 249.99);    -- John Doe buys 1 Monitor

-- Tạo Trigger khi thay đổi giá của sản phẩm thì amount (tổng giá) cũng sẽ phải cập nhật lại
drop trigger IF EXISTS change_amount;
delimiter //
create TRIGGER change_amount
AFTER update ON products
for each row
begin
update shopping_cart set amount= quantity * new.price 
where product_id= new.id;
end //
delimiter ;
-- test thử
UPDATE products set price = 59.99 where products.id=4;

-- Tạo trigger khi xóa product thì những dữ liệu ở bảng shopping_cart có chứa product bị xóa thì cũng phải xóa theo
drop trigger IF EXISTS delete_product;
delimiter //
create TRIGGER  delete_product
BEFORE delete ON products
for each row
begin
delete from shopping_cart
where product_id= old.id;
end //
delimiter ;   -- John Doe buys 1 Monitor
delete from products where id=5;

-- Khi thêm một sản phẩm vào shopping_cart với số lượng n thì bên product cũng sẽ phải trừ đi số lượng n
drop procedure IF EXISTS change_amount;
delimiter //
create procedure change_amount
( idsanpham int, soluong int, id_receiver int)
begin
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback nếu có lỗi
        ROLLBACK;
    END;
start transaction;
-- set autocommit = 0;
update shopping_cart set quantity = quantity + soluong where id = id_receiver;
update products set stock = stock - soluong where id = idsanpham;
commit;
end //
delimiter ;
-- test
call change_amount (3,1,1);




#BT2
-- Tạo Transaction khi thêm sản phẩm vào giỏ hàng thì kiểm tra xem stock của products có đủ số lượng không nếu không thì rollback
delimiter //
create procedure change_amount_2
( idsanpham int, soluong int, id_receiver int)
begin
declare check_stock int ;
start transaction;
-- set autocommit = 0;
update shopping_cart set quantity = quantity + soluong where id = id_receiver;

select stock into check_stock from products where id=idsanpham;

IF check_stock < soluong THEN ROLLBACK;
ELSE update products set stock = stock - soluong where id = idsanpham;
commit;
END IF;

end //
delimiter ;
call change_amount_2 (1,7,1);


-- Tạo Transaction khi xóa sản phẩm trong giỏ hàng thì trả lại số lượng cho products
delimiter //
create procedure return_goods
(id_user int, id_sp_trave int, soluongtra int)
begin
declare current_quantity int ;
start transaction;
-- set autocommit = 0;
update shopping_cart set quantity = quantity - soluongtra where id = id_user;

select quantity into current_quantity from shopping_cart where id=id_sp_trave;

IF current_quantity < soluongtra THEN ROLLBACK;
-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đã trả hết hàng.';
ELSE update products set stock = stock + soluongtra where id = id_sp_trave;
commit;
END IF;

end //
delimiter ;
call return_goods (1,1,7);