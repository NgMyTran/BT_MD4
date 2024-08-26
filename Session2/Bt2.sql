
#BT2
create table customers(
                          cid int,
                          cName varchar (255),
                          cAge int
);
create table orders(
                       oId int,
                       oDate date,
                       oTotalPrice double,
                       foreign key (cId) references customers(cid)
);
create table products(
                         pId int,
                         pName varchar (255),
                         pPrice double
);
create table orderDetail(
                            odQuantity int,
                            primary key (oId, pId),
                            foreign key (oId) references orders(oId),
                            foreign key (pId) references products(pId)
);

