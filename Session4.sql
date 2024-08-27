#create schema session4;

#ALTER TABLE Student DROP FOREIGN KEY student_ibfk_1;
#ALTER TABLE Mark DROP FOREIGN KEY mark_ibfk_2;
#ALTER TABLE Mark DROP FOREIGN KEY mark_ibfk_1;
drop table if exists Class;
drop table if exists Student;
drop table if exists Subjects;
drop table if exists Mark;

CREATE TABLE Class(
id int primary key auto_increment,
class_name varchar (100),
start_date datetime,
# select month(curdate());
#select day(curdate());
# select now(): ng tha năm h now
status bit
);
CREATE TABLE Student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(11),
    status BIT default(true),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Class(id)
);
CREATE TABLE Subjects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    credit INT,
    status BIT
);
CREATE TABLE Mark (
   mark_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT,
    student_id INT,
    point DOUBLE,
    exam_time DATETIME,
  #  PRIMARY KEY (subject_id, student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(id),
    FOREIGN KEY (student_id) REFERENCES Student(id)
);
insert into Class (class_name, start_date) values 
('10A1', '2001-08-24'),
('10A2', '2001-08-23'),
('10B1', '2001-08-23'),
('10B2', '2001-08-25');
insert into Student (name, address, phone, class_id) values 
('Anh', 'HCM', '0987654321', 1),
('Hào', 'HN', '0987654322', 2),
('An', 'Đồng Nai', '0987654323', 3),
('Huynh', 'Đồng Nai', '0987654324', 4),
('Ngọc', 'hcm', '0987654325', 1),
('Ngân', 'Yên Bái', '0987654326', 2),
('Hoàng', 'Quảng Bình', '0987654327', 3),
('Lai', 'Đồng Nai', '0987654328', 4),
('Tuấn', 'Hanoi', '0987654329', 1),
('Lan', 'HCM', '0987654330', 1);
insert into Subjects (name, credit) values 
('Math', 7.0),
('Literature', 7.5),
('English', 7.5),
('Chemistry', 6.0);
INSERT INTO Mark (subject_id, student_id, point, exam_time) VALUES 
(1, 1, 6.5, '2024-08-27 10:00:00'),
(1, 2, 7.0, '2024-08-27 10:00:00'),
(2, 3, 8.0, '2024-08-27 11:00:00'),
(2, 4, 7.5, '2024-08-27 11:00:00'),
(3, 5, 6.0, '2024-08-27 12:00:00'),
(3, 6, 8.0, '2024-08-27 12:00:00'),
(4, 7, 7.5, '2024-08-27 13:00:00'),
(4, 8, 6.5, '2024-08-27 13:00:00'),
(1, 9, 7.0, '2024-08-27 14:00:00'),
(2, 10, 7.5, '2024-08-27 14:00:00');
