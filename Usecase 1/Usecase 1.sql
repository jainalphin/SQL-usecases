create table product(
code int(5),
name varchar(20),
price int(5),
manufacturer int(5)
);

insert into product(code,name,price,manufacturer) values
(1,'Hard Drive',240,5),
(2,'Memory',120,6),
(3,'ZIP Drive',150,4),
(4,'Floppy Disk',5,6),
(5,'Monitor',240,1),
(6,'DVD Drive',180,2),
(7,'CD Drive',90,2),
(8,'Printer',270,3),
(9,'Toner cartridge',66,3),
(10,'DVD burner',180,2);

select * from product ;

create table Manufactures (
code int(5),
Name varchar(15)
);

insert into manufactures(code,name) values
(1,'Sony'),
(2,'Creative Labs'),
(3,'Hewlett-Packard'),
(4,'Iomega'),
(5,'Fujitsu'),
(6,'Winchester');


#Select the names of all the products in the store
select name from product;

#Select the names and the prices of all the products in the store
select name ,price from product;

#Select the name of the products with a price less than or equal to $200
select name , price from product where price <=200;

#Select all the products with a price between $60 and $120.
select name ,price from product where price between 60 and 120;

#Select the name and price in cents (i.e. the price must be multiplied by 100).
select name ,price*100 as cents from product ;

#Compute the average price of all the products.
#-------select name,avg(price) from product group by name;
select avg(price) as average from product;

# 7. Compute the average price of all products with manufacturer code equal to 2.
select avg(price ) as average_of_product_code_2  from product where code =2;

# 8. Compute the number of products with a price larger than or equal to $180.
select count(*) as 'price larger than or equal to $180' from product where price  >= 180;

# 9. Select the name and price of all products with a price larger than or equal to $180, 
#    and sort first by price (in descending order), and then by name (in ascending order).
select name ,price  from product where price >=180 order by price desc ,name asc;

#10. Select all the data from the products, including all the data for each product's manufacturer.
select * from product left join manufactures on product.manufacturer =manufactures.code;
select p.code ,m.name,p.name,p.price,p.manufacturer from product p left join manufactures m on 
p.manufacturer =m.code;

# 11. Select the product name, price, and manufacturer name of all the products.
select p.name, p.price, m.name from product p left join manufactures m on p.manufacturer =m.code;

# 12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select manufacturer , avg(price) from product group by manufacturer;

# 13 Select the average price of each manufacturer's products, showing the manufacturer's name
select m.name,avg(p.price) from manufactures m left join product p on m.code =p.manufacturer group by m.name;

#14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select m.name,avg(p.price) from manufactures m left join product p 
on m.code =p.manufacturer 
group by m.name having avg(p.price) >=150;

#15 Select the name and price of the cheapest product.
select name,price as 'cheapest with limit' from product order by price asc limit 1;
select name,price  as 'expensive with min' from product where price =(select min(price ) from product);

#16 Select the name of each manufacturer along with the name and price of its most expensive product
select name,price as 'expensive with limit' from product order by price desc limit 1;
select name,price  as 'expensive with max' from product where price =(select max(price ) from product);

#17 Add a new product: Loudspeakers, $70, manufacturer 2.
create table dup_product select * from product ;
select * from dup_product ;
alter table dup_product drop auto_increment;
alter table dup_product MODIFY column code int auto_increment ;
insert into  dup_product(name,price,manufacturer) values ('Loudspeakers',70 , 2);
update dup_product set code =11 where name='Loudspeakers';

#18 Update the name of product 8 to "Laser Printer
update dup_product set name ='Laser Printer' where code =8;
select * from dup_product;

#19 Apply a 10% discount to all products
alter table dup_product add column discount_price int(10);
select * from dup_product ;
select code,name,price,price-(price*10)/100 ' discount_price of 10%', manufacturer from product;

#20 Apply a 10% discount to all products with a price larger than or equal to $120.
# WHERE clause allows a condition to use any table column, but it cannot use aliases or aggregate functions.
# HAVING clause allows a condition to use a selected (!) column, alias or an aggregate function.
select code,name,price,price-(price*10)/100 'discount_price', manufacturer from product 
having discount_price  >= 120;


