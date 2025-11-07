-- Joins, Sub-Query and View.
create database collegeDB;
use collegeDB;

create table student(
    roll_no int primary key,
    name varchar(50),
    dob date,
    age int,
    marks decimal(5,2),
    dept varchar(50),
    email varchar(50)
);

insert into student(roll_no, name, dob, age, marks, dept, email)
values
(101, "Yashraj", "04-03-2005", 21, 8.77, "Comp", "yashraj12@gmail.com"),
(101, "Tejas", "04-03-2005", 21, 9.10, "Comp", "tkasbekar@gmail.com"),
(101, "Bushra", "19-12-2005", 21, 7.77, "Comp", "bushus@gmail.com"),
(101, "Sanchit", "14-11-2005", 21, 8.27, "Comp", "sanchit72@gmail.com"),
(101, "Aayush", "12-08-2005", 21, 7.97, "Comp", "anbuchade@gmail.com");

select * from student;

update student 
set marks = 9.22, email = "chotaliayashraj12@gmail.com"
where roll_no = 101;
select * from student;

update student
set marks = 8.22, email = "tejask@gmail.com"
where roll_no = 102;
select * from student;

delete from student
where roll_no = 102;
select * from student;

delete from student
where marks < 7.00;
select * from student;

insert into student(roll_no, name, dob, age, marks, dept, email)
values
(101, "Kavya", "04-07-2005", 21, 8.27, "Comp", "ykavya12@gmail.com"),
(101, "Sumedh", "14-05-2005", 21, 7.10, "Comp", "sumedh@gmail.com");

select * from student order by marks desc;
select * from student limit 3;

-- Joins

create table students(
    roll int primary key;
    name varchar(50) not null;
    department varchar(50) not null;
);

create table course(
    course_id int primary key;
    course_name varchar(50) not null;
    department varchar(50) not null;
);

create table enrollmnet(
    enroll_id int primary key,
    roll int,
    course_id int,
    foreign key(roll) references students(roll),
    foreign key(course_id) references course(course_id)
);

insert into students(roll, name, department)
values 
(101, "Yashraj", "Computer"),
(102, "Tejas", "Electronics"),
(103, "Sanchit", "Computer");

insert into course(course_id, course_name, department)
values
(1, "DBMS", "Computer"),
(2, "Microprocessor", "Electronics"),
(3, "Data Structures", "Computer");

insert into enrollmnet(enroll_id, roll, course_id)
values
(1, 1, 101),
(2, 2, 102),
(3, 3, 103),
(4, 2, 101);

-- Inner Join

select s.name, c.course_name
from student s
inner join enrollmnet e on s.roll = e.roll
inner join course c on e.course_id = c.course_id;

-- Left Join

select s.name, c.course_name
from student s
left join enrollmnet e on s.roll = e.roll
left join course c on e.course_id = c.course_id;

-- Right Join

select s.name, c.course_name
from student s
right join enrollmnet e on s.roll = e.roll
right join course c on e.course_id = c.course_id;