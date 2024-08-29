use session2_quanlynhanvien;
CREATE TABLE Department (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE CHECK (CHAR_LENGTH(Name) >= 6)
);
CREATE TABLE Levels (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    BasicSalary FLOAT NOT NULL CHECK (BasicSalary >= 3500000),
    AllowanceSalary FLOAT DEFAULT 500000
);
CREATE TABLE Employee (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE CHECK (Email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    Phone VARCHAR(50) NOT NULL UNIQUE,
    Address VARCHAR(255),
    Gender TINYINT NOT NULL CHECK (Gender IN (0, 1, 2)),
    BirthDay DATE NOT NULL,
    LevelId INT NOT NULL,
    DepartmentId INT NOT NULL,
    FOREIGN KEY (LevelId) REFERENCES Levels(Id),
    FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
);
CREATE TABLE Timesheets (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    AttendanceDate DATE NOT NULL DEFAULT(CURRENT_DATE()),
    EmployeeId INT NOT NULL,
    Value FLOAT NOT NULL DEFAULT 1 CHECK (Value IN (0, 0.5, 1)),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id)
);
CREATE TABLE Salary (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeId INT NOT NULL,
    BonusSalary FLOAT DEFAULT 0,
    Insurance FLOAT NOT NULL,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(Id)
);
DELIMITER //
CREATE TRIGGER before_insert_salary
BEFORE INSERT ON Salary
FOR EACH ROW
BEGIN
    DECLARE basic_salary FLOAT;
    -- Lấy lương cơ bản từ bảng Levels
    SELECT BasicSalary INTO basic_salary
    FROM Levels
    JOIN Employee ON Levels.Id = Employee.LevelId
    WHERE Employee.Id = NEW.EmployeeId;
    -- Cập nhật giá trị Insurance
    SET NEW.Insurance = 0.1 * basic_salary;
END;
//
DELIMITER ;

INSERT INTO Department (Name) VALUES
('Accounting'), -- 5 employees
('Marketing'),  -- 5 employees
('Human Resources');  -- 5 employees
INSERT INTO Department (Name) VALUES
('Shipping');  -- 0 employees

INSERT INTO Levels (Name, BasicSalary, AllowanceSalary) VALUES
('Junior', 3500000, 500000),
('Mid-Level', 5000000, 600000),
('Senior', 7000000, 700000);
INSERT INTO Employee (Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentId) VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Elm Street', 1, '1985-01-15', 1, 1),
('Jane Smith', 'jane.smith@example.com', '1234567891', '124 Elm Street', 0, '1990-02-20', 2, 2),
('Emily Johnson', 'emily.johnson@example.com', '1234567892', '125 Elm Street', 1, '1988-03-25', 3, 3),
('Michael Brown', 'michael.brown@example.com', '1234567893', '126 Elm Street', 0, '1986-04-30', 1, 1),
('Sarah Davis', 'sarah.davis@example.com', '1234567894', '127 Elm Street', 1, '1992-05-05', 2, 2),
('David Wilson', 'david.wilson@example.com', '1234567895', '128 Elm Street', 0, '1984-06-10', 3, 3),
('Laura Miller', 'laura.miller@example.com', '1234567896', '129 Elm Street', 1, '1995-07-15', 1, 1),
('Chris Taylor', 'chris.taylor@example.com', '1234567897', '130 Elm Street', 0, '1989-08-20', 2, 2),
('Amanda Anderson', 'amanda.anderson@example.com', '1234567898', '131 Elm Street', 1, '1991-09-25', 3, 3),
('Daniel Moore', 'daniel.moore@example.com', '1234567899', '132 Elm Street', 0, '1983-10-30', 1, 1),
('Olivia Thomas', 'olivia.thomas@example.com', '1234567800', '133 Elm Street', 1, '1994-11-05', 2, 2),
('Matthew Jackson', 'matthew.jackson@example.com', '1234567801', '134 Elm Street', 0, '1987-12-10', 3, 3),
('Sophia White', 'sophia.white@example.com', '1234567802', '135 Elm Street', 1, '1996-01-15', 1, 1),
('James Harris', 'james.harris@example.com', '1234567803', '136 Elm Street', 0, '1982-02-20', 2, 2),
('Isabella Martin', 'isabella.martin@example.com', '1234567804', '137 Elm Street', 1, '1993-03-25', 3, 3);
INSERT INTO Timesheets (AttendanceDate, EmployeeId, Value) VALUES
('2024-08-01', 1, 1),
('2024-08-01', 2, 0.5),
('2024-08-01', 3, 1),
('2024-08-01', 4, 0),
('2024-08-01', 5, 1),
('2024-08-02', 6, 0.5),
('2024-08-02', 7, 1),
('2024-08-02', 8, 1),
('2024-08-02', 9, 0),
('2024-08-02', 10, 0.5),
('2024-08-03', 11, 1),
('2024-08-03', 12, 1),
('2024-08-03', 13, 0.5),
('2024-08-03', 14, 1),
('2024-08-03', 15, 0.5),
('2024-08-04', 1, 1),
('2024-08-04', 2, 0.5),
('2024-08-04', 3, 1),
('2024-08-04', 4, 1),
('2024-08-04', 5, 0.5),
('2024-08-05', 6, 1),
('2024-08-05', 7, 0),
('2024-08-05', 8, 1),
('2024-08-05', 9, 1),
('2024-08-05', 10, 1),
('2024-08-06', 11, 0.5),
('2024-08-06', 12, 1),
('2024-08-06', 13, 1),
('2024-08-06', 14, 0.5),
('2024-08-06', 15, 1),
('2024-08-07', 1, 1),
('2024-08-07', 2, 0.5),
('2024-08-07', 3, 1);
INSERT INTO Salary (EmployeeId, BonusSalary) VALUES
(1, 500000), -- Insurance sẽ được tính tự động
(2, 600000), -- Insurance sẽ được tính tự động
(3, 700000); -- Insurance sẽ được tính tự động

SELECT * FROM employee;
-- 1.Lấy ra danh sách Employee có sắp xếp tăng dần theo Name gồm các cột sau: Id, Name, Email, Phone, Address, Gender, BirthDay, Age, DepartmentName, LevelName
select * from employee order by employee.name ASC;
-- 2.Lấy ra danh sách Salary gồm: Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary, AllowanceSalary, BonusSalary, Insurrance, TotalSalary
select 
	s.Id AS Id,
    e.Name AS EmployeeName,
    e.Phone AS Phone,
    e.Email AS Email,
    l.BasicSalary AS BaseSalary,
    l.BasicSalary AS BasicSalary,
    l.AllowanceSalary AS AllowanceSalary,
    s.BonusSalary AS BonusSalary,
    s.Insurance AS Insurance,
    (l.AllowanceSalary + l.BasicSalary + s.BonusSalary + s.Insurance) as TotalSalary
from salary s
JOIN employee e ON s.EmployeeId = e.Id
JOIN levels l ON e.LevelId = l.Id; 


# 3.Truy vấn danh sách Department gồm: Id, Name, TotalEmployee
SELECT * FROM department;
select d.Id, d.name, COUNT(e.id) as totalEmployee
from department d
LEFT JOIN employee e ON e.DepartmentId = d.Id
GROUP BY d.Id;
# 5.Truy vấn xóa Phòng ban chưa có nhân viên nào
-- Xác định các phòng ban không có nhân viên
-- delete
delete from department where department.id IN (
select p.Id from (
select d.*
FROM Department d
LEFT JOIN Employee e ON e.DepartmentId = d.Id
WHERE e.Id IS NULL) as p);


-- 4.Cập nhật cột BonusSalary lên 10% cho tất cả các Nhân viên có số ngày công >= 20 ngày trong tháng 10 năm 2020 
SELECT * FROM salary;
UPDATE salary s
JOIN (
-- tất cả các Nhân viên có số ngày công >= 20 ngày trong tháng 10 năm 2020 
select t.EmployeeId
from timesheets t 
where t.AttendanceDate between '2024-08-01' and '2024-08-30'
group by t.EmployeeId
having SUM(t.value) >=2
) as eligible_employees ON eligible_employees.employeeId = s.employeeId
SET s.BonusSalary = s.BonusSalary / 0.1
;
SELECT * FROM salary;