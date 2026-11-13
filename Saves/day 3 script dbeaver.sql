USE school_demo;

SHOW TABLES;

SELECT students.first_name, students.last_name, classes.class_name, classes.teacher_name FROM enrollments JOIN students ON enrollments.student_id
= students.id JOIN classes ON enrollments.class_id = classes.id;

SELECT * FROM attendance WHERE student_id = 1;