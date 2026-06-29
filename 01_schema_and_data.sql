-- ============================================================
--  COLLEGE PLACEMENT ANALYTICS
--  Walchand Institute of Technology, Solapur
--  MySQL | Schema + Sample Data
-- ============================================================

CREATE DATABASE IF NOT EXISTS placement_analytics;
USE placement_analytics;

-- ────────────────────────────────────────────────────────────
-- 1. DEPARTMENTS
-- ────────────────────────────────────────────────────────────
CREATE TABLE departments (
    dept_id       INT PRIMARY KEY AUTO_INCREMENT,
    dept_name     VARCHAR(100) NOT NULL,
    total_seats   INT NOT NULL
);

INSERT INTO departments (dept_name, total_seats) VALUES
('Computer Engineering',        60),
('Information Technology',      60),
('Electronics & Telecomm',      60),
('Mechanical Engineering',      60),
('Civil Engineering',           60),
('Artificial Intelligence & DS',30);


-- ────────────────────────────────────────────────────────────
-- 2. STUDENTS
-- ────────────────────────────────────────────────────────────
CREATE TABLE students (
    student_id    INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    dept_id       INT NOT NULL,
    batch_year    YEAR NOT NULL,          -- graduation year
    cgpa          DECIMAL(4,2) NOT NULL,
    backlogs      INT DEFAULT 0,
    gender        ENUM('Male','Female','Other') NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO students (name, dept_id, batch_year, cgpa, backlogs, gender) VALUES
-- CE 2024
('Mansi Basutkar',       1, 2024, 9.1, 0, 'Female'),
('Rohan Kulkarni',       1, 2024, 8.7, 0, 'Male'),
('Priya Sharma',         1, 2024, 7.9, 0, 'Female'),
('Akash Desai',          1, 2024, 6.8, 1, 'Male'),
('Sneha Patil',          1, 2024, 8.2, 0, 'Female'),
-- IT 2024
('Rahul Joshi',          2, 2024, 8.9, 0, 'Male'),
('Pooja Mehta',          2, 2024, 7.5, 0, 'Female'),
('Vikas Nair',           2, 2024, 6.5, 2, 'Male'),
('Anita Rao',            2, 2024, 8.0, 0, 'Female'),
('Suresh Kumar',         2, 2024, 7.2, 1, 'Male'),
-- E&TC 2024
('Neha Gupta',           3, 2024, 7.8, 0, 'Female'),
('Arjun Verma',          3, 2024, 8.4, 0, 'Male'),
('Divya Singh',          3, 2024, 6.9, 1, 'Female'),
('Kiran Reddy',          3, 2024, 7.1, 0, 'Male'),
('Meera Pillai',         3, 2024, 8.6, 0, 'Female'),
-- Mechanical 2024
('Amit Pawar',           4, 2024, 7.3, 0, 'Male'),
('Saurabh Gaikwad',      4, 2024, 6.7, 2, 'Male'),
('Rutuja Shinde',        4, 2024, 7.9, 0, 'Female'),
('Omkar Jadhav',         4, 2024, 8.1, 0, 'Male'),
('Tanvi More',           4, 2024, 7.5, 1, 'Female'),
-- CE 2023
('Hardik Shah',          1, 2023, 9.2, 0, 'Male'),
('Ankita Jain',          1, 2023, 8.5, 0, 'Female'),
('Deepak Tiwari',        1, 2023, 7.6, 0, 'Male'),
('Shruti Bhat',          1, 2023, 8.8, 0, 'Female'),
('Nikhil Soni',          1, 2023, 7.1, 1, 'Male'),
-- AI&DS 2024
('Ishita Agarwal',       6, 2024, 9.0, 0, 'Female'),
('Yash Thakur',          6, 2024, 8.3, 0, 'Male'),
('Riya Kapoor',          6, 2024, 8.7, 0, 'Female');


-- ────────────────────────────────────────────────────────────
-- 3. COMPANIES
-- ────────────────────────────────────────────────────────────
CREATE TABLE companies (
    company_id    INT PRIMARY KEY AUTO_INCREMENT,
    company_name  VARCHAR(150) NOT NULL,
    sector        ENUM('IT','Core','BFSI','Consulting','Product','Startup') NOT NULL,
    tier          ENUM('Tier-1','Tier-2','Tier-3') NOT NULL,
    headquarters  VARCHAR(100)
);

INSERT INTO companies (company_name, sector, tier, headquarters) VALUES
('TCS',                  'IT',          'Tier-2', 'Mumbai'),
('Infosys',              'IT',          'Tier-2', 'Bengaluru'),
('Wipro',                'IT',          'Tier-2', 'Bengaluru'),
('Capgemini',            'IT',          'Tier-2', 'Mumbai'),
('Accenture',            'Consulting',  'Tier-1', 'Mumbai'),
('Goldman Sachs',        'BFSI',        'Tier-1', 'Bengaluru'),
('KPIT Technologies',    'Core',        'Tier-2', 'Pune'),
('Persistent Systems',   'Product',     'Tier-2', 'Pune'),
('Cummins India',        'Core',        'Tier-2', 'Pune'),
('Zomato',               'Startup',     'Tier-1', 'Gurugram'),
('Razorpay',             'BFSI',        'Tier-1', 'Bengaluru'),
('L&T Technology',       'Core',        'Tier-2', 'Mumbai'),
('Cognizant',            'IT',          'Tier-2', 'Chennai'),
('Deloitte',             'Consulting',  'Tier-1', 'Mumbai'),
('ICICI Bank',           'BFSI',        'Tier-2', 'Mumbai');


-- ────────────────────────────────────────────────────────────
-- 4. JOB ROLES
-- ────────────────────────────────────────────────────────────
CREATE TABLE job_roles (
    role_id       INT PRIMARY KEY AUTO_INCREMENT,
    company_id    INT NOT NULL,
    role_title    VARCHAR(150) NOT NULL,
    ctc_lpa       DECIMAL(6,2) NOT NULL,   -- CTC in LPA
    role_type     ENUM('Full-Time','Internship','PPO') NOT NULL,
    eligible_depts VARCHAR(200),           -- comma-separated dept names
    min_cgpa      DECIMAL(3,2) DEFAULT 6.0,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

INSERT INTO job_roles (company_id, role_title, ctc_lpa, role_type, eligible_depts, min_cgpa) VALUES
(1,  'System Engineer',              3.36, 'Full-Time', 'CE,IT,E&TC',        6.0),
(2,  'Systems Engineer',             3.60, 'Full-Time', 'CE,IT,E&TC,AI&DS',  6.5),
(3,  'Project Engineer',             3.50, 'Full-Time', 'CE,IT',             6.0),
(4,  'Analyst',                      4.00, 'Full-Time', 'CE,IT,AI&DS',       6.5),
(5,  'Associate Software Engineer',  4.50, 'Full-Time', 'CE,IT,AI&DS',       7.0),
(6,  'Analyst - Technology',        12.00, 'Full-Time', 'CE,IT,AI&DS',       8.0),
(7,  'Software Engineer',            6.50, 'Full-Time', 'CE,IT,E&TC',        7.0),
(8,  'Software Developer',           7.00, 'Full-Time', 'CE,IT,AI&DS',       7.5),
(9,  'Graduate Engineer Trainee',    4.80, 'Full-Time', 'Mechanical,E&TC',   6.5),
(10, 'SDE Intern',                   8.00, 'Internship','CE,IT,AI&DS',       8.0),
(11, 'Backend Engineer',            10.00, 'Full-Time', 'CE,IT,AI&DS',       8.5),
(12, 'Engineer - R&D',               5.50, 'Full-Time', 'Mechanical,E&TC',   6.5),
(13, 'Programmer Analyst',           4.00, 'Full-Time', 'CE,IT',             6.0),
(14, 'Business Technology Analyst',  8.50, 'Full-Time', 'CE,IT,AI&DS',       7.5),
(15, 'Banking Operations Analyst',   4.20, 'Full-Time', 'CE,IT,Mechanical',  6.0);


-- ────────────────────────────────────────────────────────────
-- 5. PLACEMENTS  (the core fact table)
-- ────────────────────────────────────────────────────────────
CREATE TABLE placements (
    placement_id      INT PRIMARY KEY AUTO_INCREMENT,
    student_id        INT NOT NULL,
    role_id           INT NOT NULL,
    offer_date        DATE NOT NULL,
    placement_round   ENUM('On-Campus','Off-Campus','Pool-Campus') NOT NULL,
    is_dream_offer    BOOLEAN DEFAULT FALSE,   -- CTC >= 8 LPA
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (role_id)    REFERENCES job_roles(role_id)
);

INSERT INTO placements (student_id, role_id, offer_date, placement_round, is_dream_offer) VALUES
(1,  6,  '2024-09-15', 'On-Campus',   TRUE),
(2,  8,  '2024-10-01', 'On-Campus',   FALSE),
(3,  5,  '2024-09-20', 'On-Campus',   FALSE),
(4,  1,  '2024-11-05', 'Pool-Campus', FALSE),
(5,  4,  '2024-09-25', 'On-Campus',   FALSE),
(6,  11, '2024-09-10', 'On-Campus',   TRUE),
(7,  3,  '2024-10-15', 'On-Campus',   FALSE),
(9,  14, '2024-09-30', 'On-Campus',   TRUE),
(11, 7,  '2024-10-10', 'On-Campus',   FALSE),
(12, 6,  '2024-09-12', 'On-Campus',   TRUE),
(14, 2,  '2024-10-20', 'On-Campus',   FALSE),
(15, 8,  '2024-09-28', 'On-Campus',   FALSE),
(16, 9,  '2024-10-05', 'On-Campus',   FALSE),
(18, 12, '2024-10-18', 'On-Campus',   FALSE),
(19, 9,  '2024-11-01', 'On-Campus',   FALSE),
(21, 8,  '2023-09-14', 'On-Campus',   FALSE),
(22, 6,  '2023-09-08', 'On-Campus',   TRUE),
(23, 1,  '2023-10-20', 'Pool-Campus', FALSE),
(24, 14, '2023-09-22', 'On-Campus',   TRUE),
(26, 10, '2024-09-05', 'On-Campus',   TRUE),
(27, 4,  '2024-09-18', 'On-Campus',   FALSE),
(28, 11, '2024-09-09', 'On-Campus',   TRUE);
