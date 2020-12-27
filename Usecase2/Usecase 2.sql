use alphin;

create table employee(
id int(10),
name varchar(10),
Last_name varchar(10),
department int(5)
);

insert into employee values
(123234877,'Michael','Rogers',14),
(152934485,'Anand','Manikutty',14),
(222364883,'Carol','Smith',37),
(326587417,'Joe','Stevens',37),
(332154719,'Mary-Anne','Foster',14),
(332569843,'George','ODonnell',77),
(546523478,'John','Doe',59),
(631231482,'David','Smith',77),
(654873219,'Zacary','Efron',59),
(745685214,'Eric','Goldsmith',59),
(845657245,'Elizabeth','Doe',14),
(845657246,'Kumar','Swamy',14);

select * from employee ;

create table department(
code int(5),
name varchar(15),
budget int(10)
);

insert into department (code,name,budget) values
(14,'IT',6500),
(37,'Accounting',15000),
(59,'Human Resources',240000),
(77,'Research',55000);

select * from department;

# 1. Select the last name of all employees, without duplicates.
select distinct last_name from employee ;
select * from employee ;

# 2. Select all the data of employees whose last name is "Smith
select * from employee where Last_name ='Smith';

# 3. Select all the data of employees whose last name is "Smith" or "Doe".
select * from employee where Last_name in ('Smith' ,'Doe');

# 4 Select all the data of employees that work in department 14.
select * from employee where department =14;

# 5 Select all the data of employees that work in department 37 or department 77.
select * from employee where department in (34,77);

# 6 Select all the data of employees whose last name begins with an "S"
select * from employee where last_name like 's%';

# 7 Select the sum of all the departments' budgets.
select sum(budget) from department ;

# 8 Select the number of employees in each department 
# (you only need to show the department code and the number of employees).
select count(*) 'number_of employees', department from employee group by department ;

# 9 Select all the data of employees, including each employee's department's data
select * from employee left join department on employee.department =department.code ;

#10 Select the name and last name of each employee, along with the name and budget of the employee's department
select e.name,e.last_name,d.name,d.budget from employee e left join department d 
on e.department = d.code ;

# 11 Select the name and last name of employees working for departments with a budget greater than $60,000
select e.name,e.last_name ,d.budget from employee e left join department d 
on e.department = d.code 
where d.budget > 60000;
select * from department ;

#12 Select the departments with a budget larger than the average budget of all the departments.
select * from department d having budget > avg(department);
select * from department where budget >= (select avg(budget ) from department );

#13 Select the names of departments with more than two employees.
select name, count(*) from employee 
group by department having count(*) > 1;

#14 Very Important - Select the name and last name of employees working for departments with second lowest budget
select employee.name,employee.last_name from employee left join department
on employee.department =department.code 
where department.budget = (select min(budget) from department where budget not in (select min(budget ) from department));

-- first min group
-- select employee.name,employee.last_name from employee left join department
-- on employee.department =department.code 
-- group  by department.code ; having min(department.budget) ;

#15 Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11.
insert into department values
(11,'Quality Assurance',40000);

alter table department modify column name varchar(25);

#16 And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811
insert into employee values
('847219811','Mary','Moore',11);

#17 Reduce the budget of all departments by 10%.
select * from department d ;
create table dup_department as select * from department d2 ;
select * from dup_department ;
update dup_department set budget = budget - (budget *10)/100;

select dup.budget 'duplicate budget',d.budget 'Main Deparment budget' from dup_department dup 
inner join  department d on dup.code=d.code ;

#18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
drop table dup_employee;
create table dup_employee as select * from employee;
update dup_employee set department=14 where department=77;
select * from dup_employee ;

#19 19. Delete from the table all employees in the IT department (code 14).
delete from dup_employee where department =14;

#20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
select * from dup_employee where department = (select code from department where budget > 60000);
select * from dup_employee where department in (select code from department where budget > 60000);
delete from dup_employee where department = (select code from department where budget > 60000);

#21 Delete from the table all employees.
delete from dup_employee;
select * from dup_employee ;


