use session7_ontap;
CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25),
    cAge TINYINT
);
CREATE TABLE Orders (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);
CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);
CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES Orders(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 1),
(2, 1, 2),
(2, 5, 4),
(2, 3, 3);
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);
INSERT INTO Orders (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);
INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- 2. Hiển thị các thông tin gồm oID,cID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Orders, danh sách phải sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn nằm trên như hình sau:
SELECT oID, cID, oDate, oTotalPrice
FROM Orders
ORDER BY oDate DESC;
-- 3. Hiển thị tên và giá của các sản phẩm có giá cao nhất như sau:
SELECT pName, pPrice
FROM Product
WHERE pPrice = (SELECT MAX(pPrice) FROM Product);
-- 4. Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó như sau:
SELECT Customer.Name, Product.pName
FROM Customer
JOIN Orders ON Customer.cID = Orders.cID
JOIN OrderDetail ON Orders.oID = OrderDetail.oID
JOIN Product ON OrderDetail.pID = Product.pID;
-- 5. Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào 
SELECT Name
FROM Customer
WHERE cID NOT IN (SELECT cID FROM Orders);
-- 6. Hiển thị chi tiết của từng hóa đơn như sau :
SELECT Orders.oID, Orders.oDate, Product.pName, OrderDetail.odQTY, Product.pPrice
FROM Orders
JOIN OrderDetail ON Orders.oID = OrderDetail.oID
JOIN Product ON OrderDetail.pID = Product.pID;
-- 7. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice) như sau:
SELECT Orders.oID, Orders.oDate, 
       SUM(OrderDetail.odQTY * Product.pPrice) AS oTotalPrice
FROM Orders
JOIN OrderDetail ON Orders.oID = OrderDetail.oID
JOIN Product ON OrderDetail.pID = Product.pID
GROUP BY Orders.oID, Orders.oDate;
-- 8. Tạo một view tên là Sales để hiển thị tổng doanh thu của siêu thị như sau: [2.5]
CREATE VIEW Sales AS
SELECT SUM(OrderDetail.odQTY * Product.pPrice) AS TotalRevenue
FROM OrderDetail
JOIN Product ON OrderDetail.pID = Product.pID;
-- 9. Xóa tất cả các ràng buộc khóa ngoại, khóa chính của tất cả các bảng. [1.5]
-- Orders 
ALTER TABLE Orders DROP CONSTRAINT FK_cID;   -- Assuming foreign key constraint name is FK_cID
ALTER TABLE Orders DROP PRIMARY KEY;
-- OrderDetail 
ALTER TABLE OrderDetail DROP CONSTRAINT FK_oID;  -- Assuming foreign key constraint name is FK_oID
ALTER TABLE OrderDetail DROP CONSTRAINT FK_pID;  -- Assuming foreign key constraint name is FK_pID
ALTER TABLE OrderDetail DROP PRIMARY KEY;
-- Product 
ALTER TABLE Product DROP PRIMARY KEY;
-- Customer 
ALTER TABLE Customer DROP PRIMARY KEY;

-- 10. Tạo một trigger tên là cusUpdate trên bảng Customer, sao cho khi sửa mã khách (cID) thì mã khách trong bảng Order cũng được sửa theo: . [2.5]
DELIMITER //
CREATE TRIGGER cusUpdate
AFTER UPDATE ON Customer
FOR EACH ROW
BEGIN
    IF OLD.cID != NEW.cID THEN
        UPDATE Orders
        SET cID = NEW.cID
        WHERE cID = OLD.cID;
    END IF;
END;
DELIMITER;
-- 11. Tạo một stored procedure tên là delProduct nhận vào 1 tham số là tên của một sản phẩm, strored procedure này sẽ xóa sản phẩm có tên được truyên vào thông qua tham số, và các thông tin liên quan đến sản phẩm đó ở trong bảng OrderDetail
CREATE PROCEDURE delProduct(IN productName VARCHAR(25))
BEGIN
    -- Delete from OrderDetail first due to foreign key dependency
    DELETE FROM OrderDetail
    WHERE pID = (SELECT pID FROM Product WHERE pName = productName);
    
    -- Delete from Product table
    DELETE FROM Product
    WHERE pName = productName;
END;
