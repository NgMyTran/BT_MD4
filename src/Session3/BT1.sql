use session3;
# Bt1
create table product(
                        id int primary key auto_increment,
                        name varchar (100),
                        created date
);
create table color(
                      id int primary key auto_increment,
                      name varchar (100),
                      status bit default (1)
);
create table size(
                     id int primary key auto_increment,
                     name varchar (100),
                     status bit default (1)
);
create table product_detail(
                               id int primary key auto_increment,
                               price double,
                               stock int,
                               status bit,
                               product_id int,
                               color_id int,
                               size_id int,
                               foreign key (product_id) references Product(id),
                               foreign key (color_id) references Color(id),
                               foreign key (size_id) references Size(id)
);

insert into color(name, status) values ('Red', null), ('Blue', null), ('Green', null);
insert into size(name) values ('X'), ('M'), ('M'), ('L'), ('XL'), ('XXL');
insert into product(name, created) values
                                       ('Quần dài', '1990-05-12'),
                                       ('Áo dài', '2005-10-05'),
                                       ('Mũ phớt', '1995-07-07');
insert into product_detail(product_id, color_id, size_id, price, stock) values
                                                                            (1,1,1,1200,5),
                                                                            (2,1,1,1500,2),
                                                                            (1,2,3,500,3),
                                                                            (1,2,3,1600,3),
                                                                            (3,1,4,1200,5),
                                                                            (3,3,5,1200,6),
                                                                            (2,3,5,2000,10);

SELECT * FROM session3.product_detail;

select id,price from product_detail
where price >1200;

select product_detail.id,color_id, color.name "color_name"
from product_detail left join color ON color_id = color.id;

select product_detail.id,size_id, size.name"size_name"
from product_detail left join size ON product_id = size.id;

select product_detail.* from product_detail where product_id = 1;