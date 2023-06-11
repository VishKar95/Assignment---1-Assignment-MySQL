create database assignment;

use assignment;

create table SalesPeople(Snum int primary key, Sname varchar(15) unique, City varchar(15), Comm float(4,2));

insert into SalesPeople values(1001, 'Peel', 'London', 0.12);
insert into SalesPeople values(1002, 'Serres', 'Sanjose', 0.13);
insert into SalesPeople values(1004, 'Motika', 'London', 0.11);
insert into SalesPeople values(1007, 'Rifkin', 'Barcelona', 0.15);
insert into SalesPeople values(1003, 'Axelrod', 'Newyork', 0.10);

create table Customer(Cnum int primary key, Cname varchar(10), City varchar(15) not null, Snum int, 
foreign key (Snum) references SalesPeople(Snum));

insert into Customer values(2001, 'Hoffman', 'London', 1001);
insert into Customer values(2002, 'Giovanni', 'Rome', 1003);
insert into Customer values(2003, 'Liu', 'Sanjose', 1002);
insert into Customer values(2004, 'Grass', 'Berlin', 1002);
insert into Customer values(2006, 'Clemens', 'London', 1001);
insert into Customer values(2008, 'Cisneros', 'Sanjose', 1007);
insert into Customer values(2007, 'Pereira', 'Rome', 1004);

create table Orders(Onum int primary key, Amt numeric, Odate date, Cnum int, foreign key(Cnum) references Customer(Cnum), Snum int, 
foreign key(Snum) references SalesPeople(Snum));

insert into Orders values(3001, 18.69, '1990-10-03', 2008, 1007);
insert into Orders values(3003, 767.19, '1990-10-03', 2001, 1001);
insert into Orders values(3002, 1900.10, '1990-10-03', 2007, 1004);
insert into Orders values(3005, 5160.45, '1990-10-03', 2003, 1002);
insert into Orders values(3006, 1098.16, '1990-10-03', 2008, 1007);
insert into Orders values(3009, 1713.23, '1990-10-04', 2002, 1003);
insert into Orders values(3007, 75.75, '1990-10-04', 2004, 1002);
insert into Orders values(3008, 4273.00, '1990-10-05', 2006, 1001);
insert into Orders values(3010, 1309.95, '1990-10-06', 2004, 1002);
insert into Orders values(3011, 9891.88, '1990-10-06', 2006, 1001);

# 1.Count the number of Salesperson whose name begin with ‘a’/’A’.
SELECT COUNT(*)
FROM SalesPeople
WHERE Sname LIKE 'A%' OR Sname LIKE 'a%';

# 2.Display all the Salesperson whose all orders worth is more than Rs. 2000.
SELECT SalesPeople.Sname, SUM(O.Amt) AS TotalWorth
FROM SalesPeople
JOIN Customer C ON SalesPeople.Snum = C.Snum
JOIN Orders O ON C.Cnum = O.Cnum
GROUP BY SalesPeople.Sname
HAVING SUM(O.Amt) > 2000;

# 3.Count the number of Salesperson belonging to Newyork.
SELECT COUNT(*)
FROM SalesPeople
WHERE City = 'Newyork';

# 4.Display the number of Salespeople belonging to London and belonging to Paris.
SELECT City, COUNT(*) AS TotalSalespeople
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;

# 5.Display the number of orders taken by each Salesperson and their date of orders.
SELECT SalesPeople.Sname, Orders.Odate, COUNT(*)
FROM SalesPeople
JOIN Customer ON SalesPeople.Snum = Customer.Snum
JOIN Orders ON Customer.Cnum = Orders.Cnum
GROUP BY SalesPeople.Sname, Orders.Odate;
