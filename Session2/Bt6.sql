#BT6
CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       fullName VARCHAR(100) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       phone VARCHAR(11),
                       permission BIT NOT NULL,
                       status BIT NOT NULL
);
CREATE TABLE address (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         user_id INT,
                         receiveAddress VARCHAR(100),
                         receiveName VARCHAR(100),
                         receivePhone VARCHAR(11),
                         isDefault BIT,
                         FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE catalog (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(100) NOT NULL,
                         status BIT NOT NULL
);
CREATE TABLE product (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(100) NOT NULL,
                         price DOUBLE NOT NULL,
                         stock INT NOT NULL,
                         catalog_id INT,
                         status BIT NOT NULL,
                         FOREIGN KEY (catalog_id) REFERENCES catalog(id)
);
CREATE TABLE wishlist (
                          user_id INT,
                          product_id INT,
                          PRIMARY KEY (user_id, product_id),
                          FOREIGN KEY (user_id) REFERENCES users(id),
                          FOREIGN KEY (product_id) REFERENCES product(id)
);
CREATE TABLE shopping_cart (
                               id INT PRIMARY KEY AUTO_INCREMENT,
                               user_id INT,
                               product_id INT,
                               quantity INT NOT NULL,
                               FOREIGN KEY (user_id) REFERENCES users(id),
                               FOREIGN KEY (product_id) REFERENCES product(id)
);
CREATE TABLE `order` (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         orderAt DATETIME NOT NULL,
                         totals DOUBLE NOT NULL,
                         user_id INT,
                         status BIT NOT NULL,
                         FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE order_detail (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              order_id INT,
                              product_id INT,
                              quantity INT NOT NULL,
                              unit_price DOUBLE NOT NULL,
                              FOREIGN KEY (order_id) REFERENCES `order`(id),
                              FOREIGN KEY (product_id) REFERENCES product(id)
);