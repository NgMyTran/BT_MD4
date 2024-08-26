# Bt1
create table product(
                        id int,
                        name varchar (100),
                        created date
);
create table color(
                      id int,
                      name varchar (100),
                      status bit
);
create table size(
                     id int,
                     name varchar (100),
                     status bit
);
create table product(
                        id int,
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
