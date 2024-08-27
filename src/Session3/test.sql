#thg dùng để lấy list tầm 20 obj
SELECT * FROM `quanlibanhang(filemd4)`.answer;

#lấy cụ thể theo trường (cột)
-- select content, status from answer;

#JOIN kết hợp dữ liệu từ nhiều banngr có quan hệ vs nhau
#select 1 or nhiều bảng (join): trả về data table 1 khớp vs table 2
-- INNER JOIN: lấy phần chung giauwx 2 tập hợp
-- INNER JOIN department ON employee.department_id = department.id
-- LEFT/RIGHT JOIN
-- LEFT JOIN department ON employee.department_id = department.id
-- full outer JOIN
-- LEFT JOIN department ON employee.department_id = department.id UNION RIGHT JOIN department ON employee.department_id = department.id

#where (=): đi vs đk (biểu thức logic)
-- SELECT * FROM `quanlibanhang(filemd4)`.answer WHERE name like '%char muốn tìm%'

#GROUP BY (min, mã, sum, avg): cần xử lý, tính toán theo từng nhóm dữ liệu có điểm chung
-- dùng để nhóm các tập kết quả dựa theo giá trị của 1 or nhiều cột
-- SELECT department.name, COUNT(employy.id) FROM employee INNER JOIN department ON employee.department_id = department.id
-- GROUP BY department.name

#HAVING: đk của group by, sau khi nhóm thì làm j
-- SELECT department.name, COUNT(employy.id) FROM employee INNER JOIN department ON employee.department_id = department.id
-- GROUP BY department.name HAVING COUNT(employee.id) > 1;

#ORDER BY: sắp xếp bản ghi theo trật tự dựa vào g.trị (mySQL k phải lưu all mà lưu theo từng bảng đã sắp xếp rồi)
-- SELECT department.name, employy.* FROM employee INNER JOIN department ON employee.department_id = department.id
-- ORDER BY employee.name DESC (or ASC)

#LIMIT:
-- SELECT department.name, employy.* FROM employee INNER JOIN department ON employee.department_id = department.id
-- LIMIT 2 OFFSET 4 (tự tính và tự điền số offset khi làm)