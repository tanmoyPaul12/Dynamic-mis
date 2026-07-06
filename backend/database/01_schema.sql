-- ================================================================
-- College Engineering & Degree Dynamic MIS Reporting Service Schema
-- Targets B.Tech (4-Year) & B.Sc (3-Year) across 8 Departments
-- ================================================================

DROP TABLE IF EXISTS report_execution_log CASCADE;
DROP TABLE IF EXISTS report_parameter CASCADE;
DROP TABLE IF EXISTS report_master CASCADE;
DROP TABLE IF EXISTS marks CASCADE;
DROP TABLE IF EXISTS attendance CASCADE;
DROP TABLE IF EXISTS student_course_enrollment CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS teacher CASCADE;
DROP TABLE IF EXISTS department CASCADE;

-- 1. Academic Departments (Engineering & Degree Courses)
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100)
);

-- 2. College Professors / Faculty
CREATE TABLE teacher (
    teacher_id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    designation VARCHAR(100)
);

-- 3. College Courses / Subjects (e.g., Data Structures, Thermodynamics)
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    department_id INTEGER REFERENCES department(department_id),
    teacher_id INTEGER REFERENCES teacher(teacher_id),
    credits INTEGER NOT NULL DEFAULT 4
);

-- 4. Students (College Scholars)
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    department_id INTEGER REFERENCES department(department_id),
    semester INTEGER NOT NULL CHECK (semester BETWEEN 1 AND 8), -- Stores College Semester 1 to 8
    admission_date DATE NOT NULL,
    cgpa NUMERIC(5, 2) -- Stores 10-point CGPA scale
);

-- 5. Student Subject Enrollments
CREATE TABLE student_course_enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES student(student_id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(course_id) ON DELETE CASCADE,
    session_year VARCHAR(20) NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id, session_year)
);

-- 6. Attendance Register
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    enrollment_id INTEGER REFERENCES student_course_enrollment(enrollment_id) ON DELETE CASCADE,
    attendance_date DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Present', 'Absent', 'Leave'))
);

-- 7. Examination Marks
CREATE TABLE marks (
    marks_id SERIAL PRIMARY KEY,
    enrollment_id INTEGER REFERENCES student_course_enrollment(enrollment_id) ON DELETE CASCADE,
    exam_type VARCHAR(50) NOT NULL, -- e.g., 'Mid-Term Exam', 'Annual Exam'
    marks_obtained NUMERIC(5, 2) NOT NULL,
    max_marks NUMERIC(5, 2) NOT NULL DEFAULT 100,
    exam_date DATE NOT NULL
);

-- ================================================================
-- Dynamic Reporting Metadata Tables
-- ================================================================

-- 8. Report Master (Stores Dynamic Queries)
CREATE TABLE report_master (
    report_id BIGSERIAL PRIMARY KEY,
    report_name VARCHAR(200) NOT NULL,
    report_description TEXT,
    report_query TEXT NOT NULL,
    active_flag BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. Report Parameter (Stores Required Filters)
CREATE TABLE report_parameter (
    parameter_id BIGSERIAL PRIMARY KEY,
    report_id BIGINT NOT NULL REFERENCES report_master(report_id) ON DELETE CASCADE,
    parameter_name VARCHAR(100) NOT NULL,
    parameter_label VARCHAR(100) NOT NULL,
    parameter_type VARCHAR(50) NOT NULL, -- 'DROPDOWN', 'NUMBER', 'TEXT', 'DATE'
    required_flag BOOLEAN DEFAULT FALSE,
    dropdown_query TEXT,
    display_order INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Report Execution Log (Auditing & Execution Tracking)
CREATE TABLE report_execution_log (
    log_id BIGSERIAL PRIMARY KEY,
    report_id BIGINT REFERENCES report_master(report_id),
    executed_by VARCHAR(100) DEFAULT 'SYSTEM',
    execution_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    execution_duration_ms BIGINT,
    execution_status VARCHAR(50) DEFAULT 'SUCCESS',
    output_format VARCHAR(50) DEFAULT 'JSON'
);
