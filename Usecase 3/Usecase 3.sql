use alphin;
select * from hire_date ;

 
#1 List the last name, first name and employee number of 
#all programmers who were hired on or before 21 May 1991 sorted in ascending order of last name.

select last_name ,first_name,employee_no from hire_date hd 
where Job_Title ='Programmer' and hire_date <='1991-05-21' 
order by Last_Name asc ;

#2 List the department number, last name and salary of all employees 
#who were hired between 16/09/87 and 12/05/96 sorted in ascending order of last name within department number

select department_no ,last_name, Annual_Salary from hire_date where Hire_Date  between '1987-09-16' and '1996-05-12';

#3 List all the data for each job 
#where the average salary is greater than 15000 sorted in descending order of the average salary.
select Department_Name ,Department_No ,avg(Annual_Salary ) as average_salary 
from hire_date 
group by Department_Name 
having average_salary > 15000
order by average_salary desc;

select * from hire_date where Department_No in (
select Department_No 
from hire_date 
group by Department_No 
having avg(Annual_Salary ) > 15000
order by avg(Annual_Salary ) desc);	

#4 List the last name, first name, job id and commission of employees 
#  who earn commission sorted in ascending order of first name. (Commision=Annual_Salary* Commission_Percent)

select last_name,first_name ,job_id ,Annual_Salary*Commission_Percent as commission from hire_date 
order by First_Name ;

#5 Which Job Title are found in the IT and Sales departments?
select job_title from hire_date hd where Department_Name in ('IT','Sales');

#6 List the last name of all employees in department no 10 and 40 
#  together with their monthly salaries (rounded to 2 decimal places), sorted in ascending order of last name.
select last_name, round(Annual_Salary,2) from hire_date hd where Department_No in(10,40) 
order by Last_Name asc;

#7 Show the Annual Salary salaries displayed with no decimal places.
select round(Annual_Salary) from hire_date;

#8 Show the total number of employees.
select count(*) from hire_date hd ;

#9 List the department number, department name and the number of employees for
#  each department that has more than 2 employees grouping by department number and department name
select department_no,department_name ,count(*) from hire_date hd 
group by Department_Name ,Department_No 
having count(*) >= 2; 

#10 List the department number, department name and the number of employees 
#for the department that has the highest number of employees using appropriate grouping.
select department_no,department_name ,count(*) as total_employees from hire_date hd 
group by Department_Name 
order by total_employees desc limit 1;

#11 List the department number and name for all departments where no programmers work.
select Department_No ,department_name from hire_date where Job_Title  <> 'programmer';
select Department_No ,department_name from hire_date where Job_Title  != 'programmer';

#12 Update all the Annual salaries for jobs with an increase of 1000.
create table dup_hire_Date  as select * from hire_date hd ;
select * from dup_hire_date ;
update dup_hire_date set Annual_salary = annual_Salary+1000 ;

#13 List all the data for jobs sorted in ascending order of job id.
select * from hire_date hd order by Job_ID ;

#14 The job history for employee number 102 is no longer required. Delete this record.
delete from dup_hire_date where employee_no =102;

#15 Prepare a table with percentage raises, employee numbers and old and new salaries. 
#Employees in departments 20 and 10 are given a 5% rise, 
#employees in departments 50, 90 and 30 are given a 10% rise and employees in other departments are not given a rise.
create table employee_hire_date as select employee_no , annual_salary as old_salaries from hire_date hd ;
select * from employee_hire_date ;
alter table employee_hire_date add column new_salaries int(20);

update employee_hire_date set new_salaries = old_salaries + (old_salaries * 5)/100 
where employee_no in (select employee_no from hire_date where Department_No in (20,10));

update employee_hire_date set new_salaries = old_salaries + (old_salaries * 10)/100 
where employee_no in (select employee_no from hire_date where Department_No in (50,90,30));

select * from employee_hire_date ;

#16 Create a new view for manager’s details only using all the fields from the employee table.
create view manager as select * from hire_date hd where Job_Title ='Manager';

#17 Show all the fields and all the managers using the view for managers sorted in ascending order of employee number.
select * from manager order by employee_no ;

