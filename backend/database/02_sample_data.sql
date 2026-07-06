-- ================================================================
-- College Engineering & Degree MIS Sample Data
-- 8 Departments, Faculty, Courses, 22 Students, Marks, Attendance
-- ================================================================

-- 1. Insert 8 College Departments with HODs
INSERT INTO department (department_id, department_name, hod_name) VALUES
(1, 'Computer Science and Engineering', 'Prof. Subhajit Bhattacharya'),
(2, 'Mechanical Engineering', 'Dr. Arindam Chakraborty'),
(3, 'Electronics and Communication Engineering', 'Prof. Debasish Mukherjee'),
(4, 'Electrical Engineering', 'Dr. Sayan Chatterjee'),
(5, 'Civil Engineering', 'Prof. Indranil Dutta'),
(6, 'B.Sc. Mathematics', 'Dr. Anirban Sengupta'),
(7, 'B.Sc. Physics', 'Dr. Soumya Ray'),
(8, 'B.Sc. Chemistry', 'Dr. Pallab Majumder');

-- 2. Insert Faculty / Professors (HODs)
INSERT INTO teacher (teacher_id, teacher_name, email, designation) VALUES
(1, 'Prof. Subhajit Bhattacharya', 's.bhattacharya@college.edu', 'Professor & HOD (CSE)'),
(2, 'Dr. Arindam Chakraborty', 'a.chakraborty@college.edu', 'Professor & HOD (Mechanical)'),
(3, 'Prof. Debasish Mukherjee', 'd.mukherjee@college.edu', 'Professor & HOD (ECE)'),
(4, 'Dr. Sayan Chatterjee', 's.chatterjee@college.edu', 'Professor & HOD (Electrical)'),
(5, 'Prof. Indranil Dutta', 'i.dutta@college.edu', 'Professor & HOD (Civil)'),
(6, 'Dr. Anirban Sengupta', 'a.sengupta@college.edu', 'Professor & HOD (Mathematics)'),
(7, 'Dr. Soumya Ray', 's.ray@college.edu', 'Professor & HOD (Physics)'),
(8, 'Dr. Pallab Majumder', 'p.majumder@college.edu', 'Professor & HOD (Chemistry)');

-- 3. Insert College Subjects / Courses
INSERT INTO course (course_id, course_code, course_name, department_id, teacher_id, credits) VALUES
(1, 'CS101', 'Data Structures & Algorithms', 1, 1, 4),
(2, 'CS202', 'Operating Systems & Kernel Design', 1, 1, 4),
(3, 'ME101', 'Engineering Thermodynamics', 2, 2, 4),
(4, 'ME202', 'Fluid Mechanics & Machinery', 2, 2, 4),
(5, 'EC101', 'Digital Electronics & VLSI Design', 3, 3, 4),
(6, 'EE101', 'Electrical Circuit Analysis', 4, 4, 4),
(7, 'CE101', 'Structural Analysis & Design', 5, 5, 4),
(8, 'MA101', 'Advanced Linear Algebra', 6, 6, 3),
(9, 'MA202', 'Real & Complex Analysis', 6, 6, 3),
(10, 'PH101', 'Quantum Mechanics & Relativity', 7, 7, 3),
(11, 'CH101', 'Organic & Inorganic Chemistry', 8, 8, 3);

-- 4. Insert 22 College Students across Semesters 1 to 8
INSERT INTO student (student_id, roll_no, student_name, email, department_id, semester, admission_date, cgpa) VALUES
-- CSE Students
(1, '24-BT-CS-01', 'Tanmoy Paul', 'tanmoy.p@college.edu', 1, 4, '2024-08-01', 9.80), -- Dean Scholar (>9.5)
(2, '24-BT-CS-02', 'Aditi Sharma', 'aditi.s@college.edu', 1, 4, '2024-08-01', 8.90),
(3, '23-BT-CS-01', 'Rohan Gupta', 'rohan.g@college.edu', 1, 6, '2023-08-01', 8.20),
(4, '22-BT-CS-01', 'Kavya Nair', 'kavya.n@college.edu', 1, 8, '2022-08-01', 9.10),

-- Mechanical Students
(5, '24-BT-ME-01', 'Rahul Agarwal', 'rahul.a@college.edu', 2, 4, '2024-08-01', 6.80), -- Low Attendance & Backlog
(6, '23-BT-ME-01', 'Vikramaditya Rao', 'vikram.r@college.edu', 2, 6, '2023-08-01', 8.75),
(7, '25-BT-ME-01', 'Suresh Kumar', 'suresh.k@college.edu', 2, 2, '2025-08-01', 7.50),

-- ECE Students
(8, '23-BT-EC-01', 'Sneha Mukherjee', 'sneha.m@college.edu', 3, 6, '2023-08-01', 9.65), -- Dean Scholar (>9.5)
(9, '24-BT-EC-01', 'Arjun Verma', 'arjun.v@college.edu', 3, 4, '2024-08-01', 8.10),
(10, '25-BT-EC-01', 'Pooja Reddy', 'pooja.r@college.edu', 3, 2, '2025-08-01', 7.90),

-- Electrical Students
(11, '24-BT-EE-01', 'Priya Nair', 'priya.n@college.edu', 4, 4, '2024-08-01', 5.90), -- Backlog
(12, '23-BT-EE-01', 'Deepak Ghosh', 'deepak.g@college.edu', 4, 6, '2023-08-01', 8.40),

-- Civil Students
(13, '23-BT-CE-01', 'Sameer Verma', 'sameer.v@college.edu', 5, 6, '2023-08-01', 6.20), -- Low Attendance
(14, '24-BT-CE-01', 'Anjali Desai', 'anjali.d@college.edu', 5, 4, '2024-08-01', 8.00),

-- B.Sc. Mathematics Students
(15, '24-BS-MA-01', 'Raman Das', 'raman.d@college.edu', 6, 4, '2024-08-01', 9.90), -- Dean Scholar (>9.5)
(16, '25-BS-MA-01', 'Neeraj Chopra', 'neeraj.c@college.edu', 6, 2, '2025-08-01', 8.60),
(17, '23-BS-MA-01', 'Divya Singh', 'divya.s@college.edu', 6, 6, '2023-08-01', 9.20),

-- B.Sc. Physics Students
(18, '24-BS-PH-01', 'Amit Kumar', 'amit.k@college.edu', 7, 4, '2024-08-01', 6.10), -- Backlog
(19, '23-BS-PH-01', 'Siddharth Joshi', 'siddharth.j@college.edu', 7, 6, '2023-08-01', 8.80),

-- B.Sc. Chemistry Students
(20, '24-BS-CH-01', 'Rohit Gupta', 'rohit.g@college.edu', 8, 4, '2024-08-01', 7.10), -- Low Attendance
(21, '23-BS-CH-01', 'Meera Bai', 'meera.b@college.edu', 8, 6, '2023-08-01', 8.50),
(22, '25-BS-CH-01', 'Alok Nath', 'alok.n@college.edu', 8, 2, '2025-08-01', 7.80);

-- 5. Insert Enrollments
INSERT INTO student_course_enrollment (enrollment_id, student_id, course_id, session_year) VALUES
(1, 1, 1, '2025-2026'),  -- Tanmoy -> CS101
(2, 1, 2, '2025-2026'),  -- Tanmoy -> CS202
(3, 2, 1, '2025-2026'),  -- Aditi -> CS101
(4, 5, 3, '2025-2026'),  -- Rahul -> ME101
(5, 6, 4, '2025-2026'),  -- Vikramaditya -> ME202
(6, 8, 5, '2025-2026'),  -- Sneha -> EC101
(7, 9, 5, '2025-2026'),  -- Arjun -> EC101
(8, 11, 6, '2025-2026'), -- Priya -> EE101
(9, 12, 6, '2025-2026'), -- Deepak -> EE101
(10, 13, 7, '2025-2026'), -- Sameer -> CE101
(11, 14, 7, '2025-2026'), -- Anjali -> CE101
(12, 15, 8, '2025-2026'), -- Raman -> MA101
(13, 15, 9, '2025-2026'), -- Raman -> MA202
(14, 18, 10, '2025-2026'), -- Amit -> PH101
(15, 19, 10, '2025-2026'), -- Siddharth -> PH101
(16, 20, 11, '2025-2026'), -- Rohit -> CH101
(17, 21, 11, '2025-2026'); -- Meera -> CH101

-- 6. Insert Examination Marks (Midsem & Endsem)
-- 6. Insert Examination Marks (Midsem out of 40, Endsem out of 60)
INSERT INTO marks (enrollment_id, exam_type, marks_obtained, max_marks, exam_date) VALUES
(1, 'Midsem', 38.00, 40, '2025-10-15'), -- Tanmoy -> CS101 (95%)
(1, 'Endsem', 58.00, 60, '2026-04-10'), -- (96.6%)
(2, 'Midsem', 37.00, 40, '2025-10-16'), -- Tanmoy -> CS202 (92.5%)
(2, 'Endsem', 57.00, 60, '2026-04-12'), -- (95%)
(3, 'Midsem', 35.00, 40, '2025-10-15'), -- Aditi -> CS101 (87.5%)
(3, 'Endsem', 54.00, 60, '2026-04-10'), -- (90%)
(4, 'Midsem', 18.00, 40, '2025-10-15'), -- Rahul ME101 (45%)
(4, 'Endsem', 18.00, 60, '2026-04-10'), -- Backlog (<40% -> 30%)
(5, 'Midsem', 34.00, 40, '2025-10-16'), -- Vikramaditya ME202 (85%)
(5, 'Endsem', 53.00, 60, '2026-04-12'), -- (88.3%)
(6, 'Midsem', 38.00, 40, '2025-10-15'), -- Sneha EC101 (95%)
(6, 'Endsem', 58.00, 60, '2026-04-10'), -- (96.6%)
(8, 'Midsem', 14.00, 40, '2025-10-15'), -- Priya EE101 Backlog (<40% -> 35%)
(8, 'Endsem', 30.00, 60, '2026-04-10'), -- (50%)
(10, 'Midsem', 25.00, 40, '2025-10-15'), -- Sameer CE101 (62.5%)
(10, 'Endsem', 38.00, 60, '2026-04-10'), -- (63.3%)
(12, 'Midsem', 39.00, 40, '2025-10-15'), -- Raman MA101 (97.5%)
(12, 'Endsem', 60.00, 60, '2026-04-10'), -- (100%)
(14, 'Midsem', 12.00, 40, '2025-10-15'), -- Amit PH101 Backlog (<40% -> 30%)
(14, 'Endsem', 28.00, 60, '2026-04-10'), -- (46.6%)
(16, 'Midsem', 28.00, 40, '2025-10-15'), -- Rohit CH101 (70%)
(16, 'Endsem', 44.00, 60, '2026-04-10'); -- (73.3%)

-- 7. Insert Attendance Records (10 Days Sample)
INSERT INTO attendance (enrollment_id, attendance_date, status) VALUES
-- Tanmoy (100% Present)
(1, '2026-03-01', 'Present'), (1, '2026-03-02', 'Present'), (1, '2026-03-03', 'Present'), (1, '2026-03-04', 'Present'), (1, '2026-03-05', 'Present'),
(1, '2026-03-08', 'Present'), (1, '2026-03-09', 'Present'), (1, '2026-03-10', 'Present'), (1, '2026-03-11', 'Present'), (1, '2026-03-12', 'Present'),

-- Rahul Agarwal (60% Present -> Defaulter <75%)
(4, '2026-03-01', 'Present'), (4, '2026-03-02', 'Absent'),  (4, '2026-03-03', 'Present'), (4, '2026-03-04', 'Absent'),  (4, '2026-03-05', 'Present'),
(4, '2026-03-08', 'Present'), (4, '2026-03-09', 'Absent'),  (4, '2026-03-10', 'Present'), (4, '2026-03-11', 'Absent'),  (4, '2026-03-12', 'Present'),

-- Sneha Mukherjee (100% Present)
(6, '2026-03-01', 'Present'), (6, '2026-03-02', 'Present'), (6, '2026-03-03', 'Present'), (6, '2026-03-04', 'Present'), (6, '2026-03-05', 'Present'),
(6, '2026-03-08', 'Present'), (6, '2026-03-09', 'Present'), (6, '2026-03-10', 'Present'), (6, '2026-03-11', 'Present'), (6, '2026-03-12', 'Present'),

-- Sameer Verma (50% Present -> Defaulter <75%)
(10, '2026-03-01', 'Present'), (10, '2026-03-02', 'Absent'), (10, '2026-03-03', 'Present'), (10, '2026-03-04', 'Absent'), (10, '2026-03-05', 'Present'),
(10, '2026-03-08', 'Absent'),  (10, '2026-03-09', 'Present'), (10, '2026-03-10', 'Absent'),  (10, '2026-03-11', 'Present'), (10, '2026-03-12', 'Absent'),

-- Rohit Gupta (70% Present -> Defaulter <75%)
(16, '2026-03-01', 'Present'), (16, '2026-03-02', 'Present'), (16, '2026-03-03', 'Absent'),  (16, '2026-03-04', 'Present'), (16, '2026-03-05', 'Present'),
(16, '2026-03-08', 'Absent'),  (16, '2026-03-09', 'Present'), (16, '2026-03-10', 'Present'), (16, '2026-03-11', 'Absent'),  (16, '2026-03-12', 'Present');

-- 8. Insert 5 Specialized College Reports into Report Master
INSERT INTO report_master (report_id, report_name, report_description, report_query, active_flag) VALUES
(1, 'Department-Wise Student Enrollment Overview', 'Administrative summary of enrollment figures and leadership structures across all engineering and B.Sc degree departments.', 'SELECT d.department_name AS "Department Name", d.hod_name AS "Head of Department (HOD)", CASE WHEN d.department_name LIKE ''B.Sc.%'' THEN ''3-Year B.Sc. Degree'' ELSE ''4-Year B.Tech. Engineering'' END AS "Program Type", COUNT(DISTINCT s.student_id) AS "Total Students Enrolled" FROM department d LEFT JOIN student s ON d.department_id = s.department_id WHERE 1=1 GROUP BY d.department_id, d.department_name, d.hod_name', true),

(2, 'Term Examination Performance Breakdown', 'Detailed examination marks breakdown across subjects and exam terms (Midsem out of 40 vs Endsem out of 60).', 'SELECT s.roll_no AS "Roll No", s.student_name AS "Student Name", d.department_name AS "Department", s.semester AS "Semester", c.course_name AS "Subject", m.exam_type AS "Exam Term", m.marks_obtained || '' / '' || m.max_marks AS "Marks (Out of Max)", ROUND(m.marks_obtained * 100.0 / m.max_marks, 1) || ''%'' AS "Score (%)" FROM student s JOIN department d ON s.department_id = d.department_id JOIN student_course_enrollment e ON s.student_id = e.student_id JOIN course c ON e.course_id = c.course_id JOIN marks m ON e.enrollment_id = m.enrollment_id WHERE 1=1', true),

(3, 'Department-Wise Low Attendance Defaulters (< 75%)', 'Identify college scholars whose classroom attendance falls below the mandatory 75% threshold.', 'SELECT s.roll_no AS "Roll No", s.student_name AS "Student Name", d.department_name AS "Department", s.semester AS "Semester", ROUND(COUNT(CASE WHEN a.status = ''Present'' THEN 1 END) * 100.0 / NULLIF(COUNT(a.attendance_id), 0), 2) AS "Attendance (%)", COUNT(CASE WHEN a.status = ''Present'' THEN 1 END) || '' / '' || COUNT(a.attendance_id) AS "Days Present / Total" FROM student s JOIN department d ON s.department_id = d.department_id JOIN student_course_enrollment e ON s.student_id = e.student_id JOIN attendance a ON e.enrollment_id = a.enrollment_id WHERE 1=1 GROUP BY s.student_id, s.roll_no, s.student_name, d.department_name, s.semester HAVING ROUND(COUNT(CASE WHEN a.status = ''Present'' THEN 1 END) * 100.0 / NULLIF(COUNT(a.attendance_id), 0), 2) < 75.00', true),

(4, 'Dean''s Merit & Scholars List (CGPA > 9.5)', 'Honors list featuring top academic scholars across B.Tech and B.Sc programs qualifying for university distinctions.', 'SELECT s.roll_no AS "Roll No", s.student_name AS "Student Name", d.department_name AS "Department", s.semester AS "Semester", s.cgpa AS "CGPA", ''First Class with Distinction'' AS "Academic Standing" FROM student s JOIN department d ON s.department_id = d.department_id WHERE s.cgpa > 9.50', true),

(5, 'Subject Backlog & Supplementary Exam List (< 40%)', 'Roster of students who scored failing marks below 40% in term examinations and require supplementary re-examination.', 'SELECT s.roll_no AS "Roll No", s.student_name AS "Student Name", d.department_name AS "Department", s.semester AS "Semester", c.course_name AS "Subject", m.exam_type AS "Exam Term", m.marks_obtained || '' / '' || m.max_marks AS "Marks Obtained", ROUND(m.marks_obtained * 100.0 / m.max_marks, 1) || ''%'' AS "Score (%)", ''Supplementary Required'' AS "Action Required" FROM student s JOIN department d ON s.department_id = d.department_id JOIN student_course_enrollment e ON s.student_id = e.student_id JOIN course c ON e.course_id = c.course_id JOIN marks m ON e.enrollment_id = m.enrollment_id WHERE ROUND(m.marks_obtained * 100.0 / m.max_marks, 2) < 40.00', true);

-- Reset sequence for report_master
SELECT pg_catalog.setval('report_master_report_id_seq', 5, true);

-- 9. Insert Dynamic Report Parameters into report_parameter
INSERT INTO report_parameter (report_id, parameter_name, parameter_label, parameter_type, required_flag, dropdown_query, display_order) VALUES
-- Report 1: Department-Wise Student Enrollment Overview
(1, 'department_id', 'Department / Degree', 'DROPDOWN', false, 'SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id', 1),

-- Report 2: Term Examination Performance Breakdown
(2, 'department_id', 'Department / Degree', 'DROPDOWN', false, 'SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id', 1),
(2, 'semester', 'Semester / Year', 'DROPDOWN', false, 'SELECT semester AS value, ''Semester '' || semester AS label FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS t(semester)', 2),
(2, 'exam_type', 'Exam Term', 'DROPDOWN', false, 'SELECT DISTINCT exam_type AS value, exam_type AS label FROM marks', 3),
(2, 'student_name', 'Search Student Name', 'TEXT', false, NULL, 4),
(2, 'roll_no', 'Search Roll No', 'TEXT', false, NULL, 5),

-- Report 3: Department-Wise Low Attendance Defaulters (< 75%)
(3, 'department_id', 'Department / Degree', 'DROPDOWN', false, 'SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id', 1),
(3, 'semester', 'Semester / Year', 'DROPDOWN', false, 'SELECT semester AS value, ''Semester '' || semester AS label FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS t(semester)', 2),

-- Report 4: Dean''s Merit & Scholars List (CGPA > 9.5)
(4, 'department_id', 'Department / Degree', 'DROPDOWN', false, 'SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id', 1),
(4, 'semester', 'Semester / Year', 'DROPDOWN', false, 'SELECT semester AS value, ''Semester '' || semester AS label FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS t(semester)', 2),

-- Report 5: Subject Backlog & Supplementary Exam List (< 40%)
(5, 'department_id', 'Department / Degree', 'DROPDOWN', false, 'SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id', 1),
(5, 'semester', 'Semester / Year', 'DROPDOWN', false, 'SELECT semester AS value, ''Semester '' || semester AS label FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS t(semester)', 2),
(5, 'exam_type', 'Exam Term', 'DROPDOWN', false, 'SELECT DISTINCT exam_type AS value, exam_type AS label FROM marks', 3);

-- Reset sequence for report_parameter
SELECT pg_catalog.setval('report_parameter_parameter_id_seq', (SELECT MAX(parameter_id) FROM report_parameter), true);
