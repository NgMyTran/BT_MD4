#BT5
CREATE TABLE users (
                       id INT PRIMARY KEY,
                       fullName VARCHAR(100),
                       email VARCHAR(255),
                       password VARCHAR(255),
                       phone VARCHAR(11),
                       permission BIT,
                       status BIT
);

CREATE TABLE address (
                         id INT PRIMARY KEY,
                         user_id INT,
                         receiveAddress VARCHAR(100),
                         receiveName VARCHAR(100),
                         receivePhone VARCHAR(11),
                         isDefault BIT,
                         FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE catalog (
                         id INT PRIMARY KEY,
                         name VARCHAR(100),
                         status BIT
);

CREATE TABLE book (
                      id INT PRIMARY KEY,
                      name VARCHAR(100),
                      price DOUBLE,
                      stock INT,
                      status BIT
);

CREATE TABLE book_catalog (
                              catalog_id INT,
                              book_id INT,
                              PRIMARY KEY (catalog_id, book_id),
                              FOREIGN KEY (catalog_id) REFERENCES catalog(id),
                              FOREIGN KEY (book_id) REFERENCES book(id)
);

CREATE TABLE `order` (
                         id INT PRIMARY KEY,
                         orderAt DATETIME,
                         totals DOUBLE,
                         user_id INT,
                         status BIT,
                         FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_detail (
                              id INT PRIMARY KEY,
                              order_id INT,
                              book_id INT,
                              quantity INT,
                              unit_price DOUBLE,
                              FOREIGN KEY (order_id) REFERENCES `order`(id),
                              FOREIGN KEY (book_id) REFERENCES book(id)
);