CREATE DATABASE school_demo;

USE school_demo;

CREATE TABLE students (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
grade_level INT
);

INSERT INTO students (first_name, last_name, grade_level) VALUES
('Emily', 'Carter', 10),
('Jason', 'Hill', 11),
('Maria', 'Lopez', 10);

SELECT * FROM students;

SHOW DATABASES;

CREATE TABLE classes (
id INT AUTO_INCREMENT PRIMARY KEY,
class_name VARCHAR(100),
teacher_name VARCHAR(100)
);

INSERT INTO classes (class_name, teacher_name) VALUES
('Algebra 1', 'Mr. Brown'),
('Biology', 'Ms. Green'),
('English 10', 'Mrs. Taylor');

SELECT * FROM classes;

CREATE TABLE enrollments (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
class_id INT,
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO enrollments (student_id, class_id) VALUES
(1 ,1),
(1, 2),
(2, 1),
(3, 3);

SELECT * FROM enrollments

-- DELETE FROM enrollments WHERE id

-- ALTAR TABLE enrollments AUTO_INCREMENT = 5;

SELECT students.first_name, students.last_name, classes.class_name, classes.teacher_name FROM enrollments JOIN students ON enrollments.student_id = students.id JOIN classes 	ON enrollments.class_id = classes.id; 

CREATE TABLE grades (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
class_id INT,
grade_value VARCHAR(5),
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO grades (student_id, class_id, grade_value) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(3, 3, 'C');

SELECT * FROM grades;

SELECT students.first_name, students.last_name, classes.class_name, grades.grade_value FROM grades JOIN students ON grades.student_id = students.id JOIN classes ON grades.class_id = classes.id;

CREATE TABLE assignments (
id INT AUTO_INCREMENT PRIMARY KEY,
class_id INT,
assignment_name VARCHAR (150),
due_date DATE,
max_points INT,
FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO assignments (class_id, assignment_name, due_date, max_points) VALUES
(1, 'Algebra Quiz 1', '2026-09-11', 100),
(1, 'Linear Equations Project', '2026-09-25', 150),
(2, 'Biology Lab Report', '2026-09-19', 100);

SELECT * FROM assignments;

CREATE TABLE student_assignments (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
assignment_id INT,
score INT,
submitted_date DATE,
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (assignment_id) REFERENCES assignments(id)
);

INSERT INTO student_assignments (student_id, assignment_id, score, submitted_date) VALUES
(1, 1, 95, '2026-09-10'),
(1, 2, 88, '2026-09-24');

SELECT * FROM student_assignments;

CREATE TABLE attendance (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
class_id INT,
date DATE,
status ENUM ('present', 'absent', 'tardy'),
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO attendance (student_id, class_id, date, status) VALUES
(1, 1, '2026-09-08', 'present'),
(1, 1, '2026-09-09', 'present'),
(1, 2, '2026-09-08', 'tardy'),
(2, 1, '2026-09-09', 'present'),
(2, 1, '2026-09-10', 'tardy');

SELECT * FROM attendance
SELECT * FROM student_assignments;

SHOW TABLES;