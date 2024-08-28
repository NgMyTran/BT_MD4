use session4;
ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_2;
ALTER TABLE mark DROP FOREIGN KEY mark_ibfk_1;
drop table if exists Class;
drop table if exists Student;
drop table if exists Subjects;
drop table if exists Mark;
use session4;
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



SELECT * FROM session4.mark;

SELECT * FROM student;
select  count(id), address
from student
group by address;

select subjects.id, subjects.name, mark.*
from mark
         JOIN subjects ON mark. mark_id= subjects.id
order by subjects.id, subjects.name;

-- tính điểm tb các môn của từng hs +
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select student.id, student.name, mark.student_id, AVG(mark.point) as average_score
from student
         join mark ON mark.mark_id = student.id
group by student.id, student.name
order by average_score DESC
;

-- Hiển thị những bạn học viên có điểm trung bình các môn học nhỏ hơn bằng 7
select student.id, student.name, mark.student_id, AVG(mark.point) as average_score
from student
         join mark ON mark.mark_id = student.id
group by student.id, student.name
having AVG(mark.point) <=7
order by average_score ASC
;

-- Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.
select student.id, student.name, mark.student_id, AVG(mark.point) as average_score
from student
         join mark ON mark.mark_id = student.id
group by student.id, student.name
having AVG(mark.point) = (
    select MAX(avg_point) from
        (select AVG(point) as avg_point
         from mark
         order by student.id
        )
            as subquery
);
