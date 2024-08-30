#BT3
use session5;
ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_2;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_1;
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
status bit default (1)
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
                                               ('HN-JV231103', '2023-11-03'),
                                               ('HN-JV231229', '2023-12-29'),
                                               ('HN-JV230615', '2023-06-15');
insert into Student (name, address, phone, class_id) values
                                                         ('Hồ Da Hùng', 'Hà Nội', '0987654321', 1),
                                                         ('Phan Văn Giang', 'Đà Nẵng', '096781125', 1),
                                                         ('Dương Mỹ Huyền', 'Hà Nội', '0385546611', 2),
                                                         ('Hoàng Minh Hiếu', 'Nghệ An', '0964425633', 2),
                                                         ('Nguyễn Vịnh', 'Hà Nội', '0975123552', 3),
                                                         ('Nam Cao', 'Hà Tĩnh', '0919191919', 1),
                                                         ('Nguyễn Du', 'Nghệ An', '0353535353', 3);
insert into Subjects (name, credit) values
                                        ('Toán', 3),
                                        ('Văn', 3),
                                        ('Anh', 2);
INSERT INTO Mark (subject_id, student_id, point, exam_time) VALUES
                                                                (1, 1, 7, '2024-05-12'),
                                                                (2, 2, 8, '2024-05-15'),
                                                                (2, 3, 9, '2024-08-03'),
                                                                (3, 3, 10, '2024-02-11');
                                                                
# Tạo store procedure lấy ra tất cả lớp học có số lượng học sinh lớn hơn 5
DELIMITER //
CREATE PROCEDURE get_class_more_than_5_student()
BEGIN
    SELECT c.id, c.class_name, COUNT(st.id) AS total_student
    FROM class c
    JOIN Student st ON c.id = st.class_id
    GROUP BY c.id, c.class_name
    HAVING total_student > 2;
END //
DELIMITER ;

#Tạo store procedure hiển thị ra danh sách môn học có điểm thi là 10

#Tạo store procedure hiển thị thông tin các lớp học có học sinh đạt điểm 10

#Tạo store procedure thêm mới student và trả ra id vừa mới thêm

#Tạo store procedure hiển thị subject chưa được ai thi