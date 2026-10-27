-- =============================================================================
-- Kongu Engineering College (Autonomous) - Regulation 2024
-- Academic Management & Continuous Evaluation System Database Schema
-- Database Name: kec_academic
-- =============================================================================

CREATE DATABASE IF NOT EXISTS kec_academic;
USE kec_academic;

-- 1. Students Table
CREATE TABLE IF NOT EXISTS students (
    roll_no VARCHAR(10) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(10) NOT NULL,
    current_semester INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Courses Table
CREATE TABLE IF NOT EXISTS courses (
    course_code VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    course_type VARCHAR(10) NOT NULL CHECK (course_type IN ('THEORY', 'PRACTICAL', 'EMBEDDED'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Enrollments Table
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(10) NOT NULL,
    course_code VARCHAR(10) NOT NULL,
    semester INT NOT NULL,
    classes_held INT DEFAULT 0,
    classes_attended INT DEFAULT 0,
    medical_condonation BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_enrollment_student FOREIGN KEY (roll_no) REFERENCES students(roll_no) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_code) REFERENCES courses(course_code) ON DELETE CASCADE,
    CONSTRAINT uq_student_course_semester UNIQUE (roll_no, course_code, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Assessment Marks Table
CREATE TABLE IF NOT EXISTS assessment_marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL UNIQUE,
    cia1 DECIMAL(5,2) DEFAULT NULL,
    cia2 DECIMAL(5,2) DEFAULT NULL,
    assignment_marks DECIMAL(5,2) DEFAULT NULL,
    quiz_marks DECIMAL(5,2) DEFAULT NULL,
    lab_evaluation DECIMAL(5,2) DEFAULT NULL,
    ese_marks DECIMAL(5,2) DEFAULT NULL,
    ese_status VARCHAR(10) DEFAULT 'PENDING',
    CONSTRAINT fk_marks_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
