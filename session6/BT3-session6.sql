use session6;
CREATE TABLE bank_customer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    myMoney DOUBLE,
    address VARCHAR(255),
    phone VARCHAR(11),
    dateOfBirth DATE,
    status BIT
);

CREATE TABLE transfer (
    sender_id INT,
    receiver_id INT,
    money DOUBLE,
    transfer_date DATETIME,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);
INSERT INTO bank_customer (name, myMoney, address, phone, dateOfBirth, status) VALUES
('Nguyễn Văn A', 10000000.00, '123 Đường Lê Lợi, Quận 1, TP.HCM', '0909123456', '1985-06-15', 1),
('Trần Thị B', 15000000.50, '456 Đường Hai Bà Trưng, Quận 3, TP.HCM', '0912123456', '1990-09-25', 1),
('Lê Văn C', 7500000.75, '789 Đường Nguyễn Huệ, Quận 1, TP.HCM', '0922123456', '1978-12-05', 1),
('Phạm Thị D', 20000000.25, '321 Đường Phan Xích Long, Quận Phú Nhuận, TP.HCM', '0932123456', '1995-03-17', 1);

INSERT INTO transfer (sender_id, receiver_id, money, transfer_date) VALUES
(1, 2, 2000000.00, '2024-08-01 10:00:00'),  -- Nguyễn Văn A chuyển 2,000,000 VND cho Trần Thị B
(3, 4, 3000000.00, '2024-08-02 12:30:00'),  -- Lê Văn C chuyển 3,000,000 VND cho Phạm Thị D
(2, 1, 1500000.50, '2024-08-03 15:45:00'),  -- Trần Thị B chuyển 1,500,000.50 VND cho Nguyễn Văn A
(4, 3, 5000000.00, '2024-08-04 09:15:00');  -- Phạm Thị D chuyển 5,000,000 VND cho Lê Văn C

-- Tạo transaction (phiên giao dịnh) khi gửi tiền đến tài khoản người nếu vượt quá số tiền trong tài khoản thì sẽ (rollback) trở lại vị trí ban đầu khi bắt đầu giao dịnh
drop procedure IF EXISTS transfer_money;
delimiter //
create procedure transfer_money
(transfer_id int, receiver_id int, sotien double )
begin
declare check_money int;
start transaction;
update bank_customer set myMoney = myMoney + sotien where id = receiver_id;

select myMoney into check_money from bank_customer where id=transfer_id;
IF check_money < sotien THEN ROLLBACK;
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số dư trong tk không đủ.';
ELSE update bank_customer set myMoney = myMoney - sotien where id = transfer_id;
commit;
END IF;
end //
delimiter ;
call transfer_money(3,1, 5000000);