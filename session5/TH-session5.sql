use session5;
#TH1
SELECT * FROM classicmodels.customers;
-- explain để truy vấn
alter table customers add index inx_customerName (customerName);
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.'; 


#TH2
delimiter //
create procedure findAllCustomer()
begin
select * from customers;
end //
delimiter ;

call findAllCustomer();
delimiter //
Drop procedure if exists findAllCustomer //
create procedure findAllCustomers()
begin
select * from customers where customerNumber = 175;
end //


#TH3
-- Tham số loại IN
delimiter //
create procedure getCusById (IN cusNum int(11))
begin
select * from customers where customerNumber = cusNum;
end //
delimiter ;
call getCusById(175); 

-- Tham số loại OUT
delimiter //
create procedure GetCustomersCountByCity(
IN in_city varchar(50),
OUT total int
)
begin
select count(customerNumber) into total from customers where city = in_city;
end //
delimiter ;
call GetCustomersCountByCity('Lyon', @total);
select @total;

-- Tham số loại INOUT
delimiter //
create procedure SetCounter(
INOUT counter int,
IN inc int
)
begin
set counter = counter + inc;
end //
delimiter ;
SET @counter = 1;
CALL SetCounter(@counter,1); 
CALL SetCounter(@counter,1);
CALL SetCounter(@counter,1);
CALL SetCounter(@counter,5);
SELECT @counter;


#TH4
create view customer_views as
SELECT customerNumber, customerName, phone
FROM classicmodels.customers;
select * from customer_views;






                                                                    
          