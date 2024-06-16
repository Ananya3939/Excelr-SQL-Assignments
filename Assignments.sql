

SELECT employeeNumber, firstName , lastName FROM employees
WHERE reportsTo=1102;

SELECT DISTINCT(productLine) FROM products
WHERE productLine LIKE "%Cars%";

select * from customers;

select customerNumber,customerName,
case
when country="USA" or "Canada" then "North America"
when country="UK"  then "Europe"
when country= "France" then "Europe"
when country= "Germany" then "Europe"
else "Other"
end as CustomerSegment
from customers;


select max(quantityOrdered) from orderdetails
limit 10;


/* Company wants to analyze payment frequency by month. Extract the month name from the payment date to count the total number of payments for each month and
include only those months with a payment count exceeding 20 (Refer Payments table). 
*/

select * from payments;

select count(monthname(paymentdate)) as month_name from payments
group by paymentDate;

select monthname(paymentDate) as payment_month,count(*) as num_payments  from payments
group by payment_month
having count(*)>20;


create database Customer_Orders;
use customer_orders;
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    CONSTRAINT check_name_not_null CHECK (first_name IS NOT NULL AND last_name IS NOT NULL)
);

INSERT INTO Customers (first_name, last_name, email, phone_number)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
    ('Alice', 'Smith', 'alice.smith@example.com', '987-654-3210'),
    ('Bob', 'Johnson', 'bob.johnson@example.com', '555-123-4567');

INSERT INTO Customers (first_name, last_name, email, phone_number)
VALUES
    ('Emily', 'Davis', 'emily.davis@example.com', '111-222-3333'),
    ('Michael', 'Wilson', 'michael.wilson@example.com', '444-555-6666'),
    ('Sophia', 'Brown', 'sophia.brown@example.com', '777-888-9999');
INSERT INTO Customers (first_name, last_name, email, phone_number)
VALUES
    ('David', 'Martinez', 'david.martinez@example.com', '111-222-3333'),
    ('Sarah', 'Johnson', 'sarah.johnson@example.com', '444-555-6666'),
    ('Christopher', 'Lee', 'christopher.lee@example.com', '777-888-9999');


select * from customers;

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CHECK (total_amount >= 0)
);

select * from customers;

select * from orders;

select c.country,count(*) as order_count from customers c inner join orders o on c.customernumber=o.customernumber
group by country
order by count(*) desc
limit 5;

create table project (EmployeeID int primary key auto_increment,
						Full_name varchar(50) not null,
                        Gender enum("Male","Female") not null,
                        Manager_ID int);
                        
insert into project(full_name,gender,manager_id) values("Pranaya","Male",3);
insert into project(full_name,gender,manager_id) values("Priyanka","Female",1);
insert into project(full_name,gender) values("Preety","Female");
insert into project(full_name,gender,manager_id) values("Anurag","Male",1);
insert into project(full_name,gender,manager_id) values("Sambit","Male",1);
insert into project(full_name,gender,manager_id) values("Rajesh","Male",3);
insert into project(full_name,gender,manager_id) values("Hina","Female",3);

select * from project;

select p2.Full_name as Manager_Name,p1.full_name as Emp_Name from project p1 join project p2 on p1.Manager_ID=p2.employeeid	
order by 1 ;

create table facility (Facility_ID int,Facility_Name varchar(100),State varchar(100),Country varchar(100));

alter table facility modify column Facility_ID  int  auto_increment primary key;


alter table facility  add column City varchar(20) not null after facility_name;

alter table facility  modify column City varchar(100) not null after facility_name;

select * from facility;

desc facility;

select * from products;
select * from orders;
select * from orderdetails;
select * from productlines;

create view product_category_sales13 as
select pl.productline, sum(od.quantityOrdered * od.priceEach) as Total_sales ,count(distinct(o.orderNumber)) as num_of_orders
from products p 
 join orderdetails od on p.productCode=od.productCode
 join orders o on o.orderNumber=od.orderNumber 
 join productlines pl on p.productLine=pl.productLine 
group by 1;


select * from customers;

select * from orders;

select year(paymentdate) from payments;

select customerName,count(distinct(orders.ordernumber)),dense_rank() over(order by count(distinct(orders.ordernumber)) desc) as "rank"
from customers left join orders on customers.customerNumber=orders.customerNumber
group by 1
order by 2 desc;


select year(orderdate),monthname(orderdate),lag(count(monthname(orderdate))) over(order by year(orderdate)) as "Total_Count"  from orders
group by 1,2;


select year(orderdate),monthname(orderdate),lead(count(monthname(orderdate))) over(order by year(orderdate)) as "Total_Count"  from orders
group by 1,2
order by 1,2;

select * from products;

-- select avg(msrp) from products;  100.438727

select productline,count(*) from products
where buyprice>(select avg(msrp) from products)
group by 1;

select distinct(productline),count(*) from products
where buyprice>avg(msrp) 
group by 1;






-- Error Handling

CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    EmailAddress VARCHAR(100)
);


-- Triggers


CREATE TABLE Emp_BIT (
    Name VARCHAR(100),
    Occupation VARCHAR(100),
    Working_date DATE,
    Working_hours INT
);

CREATE TRIGGER Before_Insert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END;


CREATE TRIGGER Before_Insert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END;




