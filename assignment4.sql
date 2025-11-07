-- Design at least 10 SQL queries for suitable database application using SQL DML statements
create database collegeDB;
use collegeDB;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    dept_id INT,
    marks INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES (1, 'Computer Science');
INSERT INTO Department VALUES (2, 'Mechanical');
INSERT INTO Department VALUES (3, 'Electrical');

INSERT INTO Student VALUES (101, 'Yash', 20, 1, 85);
INSERT INTO Student VALUES (102, 'Aarav', 21, 1, 72);
INSERT INTO Student VALUES (103, 'Neha', 22, 2, 90);
INSERT INTO Student VALUES (104, 'Riya', 20, 3, 60);

INSERT INTO Teacher VALUES (1, 'Mr. Sharma', 1);
INSERT INTO Teacher VALUES (2, 'Mrs. Iyer', 2);
INSERT INTO Teacher VALUES (3, 'Mr. Khan', 3);

SELECT * FROM Student;

SELECT name, marks FROM Student WHERE marks > 75;

-- inner join

SELECT s.name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Computer Science';

-- left outer join

SELECT s.name, d.dept_name
FROM Student s
LEFT JOIN Department d ON s.dept_id = d.dept_id;

-- right outer join

SELECT t.teacher_name, d.dept_name
FROM Teacher t
RIGHT JOIN Department d ON t.dept_id = d.dept_id;

-- aggregate function

SELECT d.dept_name, AVG(s.marks) AS avg_marks
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

UPDATE Student SET marks = marks + 5 WHERE name = 'Riya';

DELETE FROM Student WHERE marks < 65;

SELECT * FROM Student WHERE name LIKE 'N%';

SELECT a.name AS Student1, b.name AS Student2, a.dept_id
FROM Student a
JOIN Student b ON a.dept_id = b.dept_id AND a.roll_no <> b.roll_no;

