USE school_demo;

SHOW TABLES;

SELECT students.first_name, students.last_name, classes.class_name, classes.teacher_name FROM enrollments JOIN students ON enrollments.student_id
= students.id JOIN classes ON enrollments.class_id = classes.id;

SELECT * FROM attendance WHERE student_id = 1;

SELECT * FROM students;

CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100) UNIQUE NOT NULL,
password VARCHAR(255) NOT NULL
);

INSERT INTO students(first_name, last_name, grade_level) VALUES
('Test', 'User', 9);

INSERT INTO users(first_name, last_name, email, password, student_id) VALUES
('Test', "User", 'test@email.com', 'Test@123', 5);

SELECT * FROM users;

