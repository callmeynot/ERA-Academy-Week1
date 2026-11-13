const express = require('express');
const db = require('./db');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// root route - confirms the server is running // 

app.get('/', (req, res) => {
    res.send('backend is running with my SQL');
});

// GET /students - returns all students from my SQL //
app.get('/students', (req, res) => {
    const sql = 'SELECT * FROM students';
    db.query(sql, (error, results) => {
        if (error) {
            console.error('Error getting students:', error);
            return res.status(500).json({error:"failed to get students"});
        }
        res.json(results);
    });
});

// POST /students - receieves new student data and inserts into my SQL //
app.post('/students', (req, res) => {
    const {first_name, last_name, grade_level} = req.body;

// VAL(IDATION) - reject if any field is missing //
    if (!first_name || !last_name || !grade_level){
        return res.status(400).json({error:'first_name, last_name & grade_level are required'});
    }
    const sql = 'INSERT INTO students (first_name, last_name, grade_level) VALUES (?, ?, ?)';
    db.query(sql, [first_name, last_name, grade_level], (error, results) => {
        if (error) {
        console.error('error adding student:', error);
        return res.status(500).json({error:'failed to add student'});
        }
        res.status(201).json({
            message:'student added successfully',
            studentId: results.insertId
        });
    });
});

// GET /students/:id/assignments - returns one students assignments and scores //
app.get('/students/:id/assignments', (req, res) => {
    const {id} = req.params;
    const sql = 'SELECT assignments.assignment_name, assignments.due_date, assignments.max_points, student_assignments.score, student_assignments.submitted_date, classes.class_name FROM assignments JOIN classes ON assignments.class_id = classes.id LEFT JOIN student_assignments ON student_assignments.assignment_id = assignments.id AND student_assignments.student_id = ? WHERE assignments.class_id IN (SELECT class_id FROM enrollments WHERE student_id = ?)';
    db.query(sql, [id,id], (error, results) => {
        if (error) {
            console.error('Error getting assignments:', error);
            return res.status(500).json({error:"failed to get assignments"});
        }
        res.json(results);
    });
});


// GET /classes - returns all classes from my sql //
app.get('/classes', (req, res) => {
    const sql = 'SELECT * FROM classes';
    db.query(sql, (error, results) => {
        if (error) {
            console.error('error getting classes', error);
            return res.status(500).json({error:'failed to get classes'});
        }
        res.json(results);
    });
});

// GET /enrollments - returns joined data (student_name + class_name) //
app.get('/enrollments', (req, res) => {
    const sql = 'SELECT students.first_name, students.last_name, classes.class_name, classes.teacher_name FROM enrollments JOIN students ON enrollments.student_id = students.id JOIN classes ON enrollments.class_id = classes.id';
    db.query(sql, (error, results) => {
        if (error) {
            console.error('error getting enrollments', error);
            return res.status(500).json({error:'failed to get enrollments'});
        }
        res.json(results);
    });
});

// GET /students/:id - returns a specific student by ID //
app.get('/students/:id', (req, res) => {
    const {id} = req.params;
    const sql = 'SELECT * FROM students WHERE id = ?';
    db.query(sql, [id], (error, results) => {
        if (error) {
            console.error('error getting student:', error);
            return res.status(500).json({error:'failed to get student'});
        }
        if (results.length === 0) {
            return res.status(404).json({error:'student not found'});
        }
        res.json(results[0]);
    });
});

// GET /students/:id/grades - returns grades for one student //

app.get('/students/:id/grades', (req, res) => {
    const {id} = req.params;
    const sql = 'SELECT classes.class_name, grades.grade_value FROM grades JOIN classes ON grades.class_id = classes.id WHERE grades.student_id = ?';
    db.query(sql, [id], (error, results) => {
        if (error) {
            console.error('error getting grades:', error);
            return res.status(500).json({error:'failed to get grades'});
        }
        res.json(results);
    });
});

// GET /students/:id/attendance - returns attendance for one student //
app.get('/students/:id/attendance', (req, res) => {
    const {id} = req.params;
    const sql = 'SELECT classes.class_name, attendance.date, attendance.status FROM attendance JOIN classes ON attendance.class_id = classes.id WHERE attendance.student_id = ? ORDER BY attendance.date DESC';
    db.query(sql, [id], (error, results) => {
        if (error) {
            console.error('error getting attendance:', error);
            return res.status(500).json({error:'failed to get attendance'});
        }
        res.json(results);
    });
});


app.listen(PORT, () => {
    console.log(`server running at http://localhost:${PORT}`);
});

