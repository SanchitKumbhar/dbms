-- Design and develop sql ddl statements which demonstartes the use of sql objects such as tables.
create database collegeDB;
use collegeDB;

create table student(
    roll_no int primary key,
    name varchar(50) not null,
    dob date not null,
    age int check(age >= 17 and age <= 30),
    marks decimal(5,2),
    dept varchar(50) not null,
    email varchar(50) unique
);

insert into student(roll_no, name, dob, age, marks, dept, email)
values
(101, "Yashraj", "04-03-2005", 21, 8.77, "Comp", "yashraj12@gmail.com"),
(101, "Tejas", "04-03-2005", 21, 9.10, "Comp", "tkasbekar@gmail.com"),
(101, "Bushra", "19-12-2005", 21, 7.77, "Comp", "bushus@gmail.com"),
(101, "Sanchit", "14-11-2005", 21, 8.27, "Comp", "sanchit72@gmail.com"),
(101, "Aayush", "12-08-2005", 21, 7.97, "Comp", "anbuchade@gmail.com");

select * from student;

-- View
create view student_view as
select
 roll_no, name, dept, marks
from
 student
where
 marks=>75;
select * from student_view;

-- Index
create index student_indx on student(name);
select * from student where name = "Yashraj";

-- Synonym 
create view stu as 
select * from stu;

create view stu as
select 
 roll_no, name, dept, marks
from
 student
where
 marks >= 75;
select * from stu;  