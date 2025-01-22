CREATE TABLE Classes (
    class_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
    class_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE Terms (
    term_id INT AUTO_INCREMENT PRIMARY KEY,
    term_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    gender ENUM('Nam', 'Nữ', 'Khác') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    class_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    email VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    address VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    study_status ENUM('Học', 'Thôi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    term_id INT, -- Thêm cột khóa ngoại tham chiếu đến term_id trong bảng Terms
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (term_id) REFERENCES Terms(term_id) ON DELETE CASCADE -- Tạo ràng buộc khóa ngoại
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    gender ENUM('Nam', 'Nữ', 'Khác') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    teaching_subject VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    email VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    address VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin','student', 'teacher') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    student_id INT,
    teacher_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE CASCADE
);

CREATE TABLE Subjects (
    subject_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
    subject_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE CASCADE
);

CREATE TABLE Scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    class_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    term_id INT,
    mid_term_score FLOAT,
    final_term_score FLOAT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (term_id) REFERENCES Terms(term_id) ON DELETE CASCADE
);

ALTER TABLE Scores
ADD COLUMN total_score FLOAT;

UPDATE Scores
SET total_score = CASE 
                        WHEN mid_term_score IS NULL OR final_term_score IS NULL THEN 0
                        ELSE (mid_term_score + final_term_score) / 2
                  END;

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,  
    student_id INT, 
    subject_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, 
    class_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,  
    term_id INT,  
    session_date DATE, 
    attended ENUM('Yes', 'No') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,  
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,  
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE, 
    FOREIGN KEY (term_id) REFERENCES Terms(term_id) ON DELETE CASCADE 
);


-- Thêm thông tin lớp học
INSERT INTO Classes (class_id, class_name) VALUES
('10A','10A'),
('10B','10B'),
('10C','10C'),
('10D','10D'),
('10E','10E');

-- Thêm thông tin kì học
INSERT INTO Terms (term_id ,term_name) VALUES
(101,'Kì 1'),
(102,'Kì 2');

-- Thêm thông tin học sinh
INSERT INTO Students (student_id, full_name, gender, class_id, email, address, study_status,term_id) VALUES
(1001, 'Nguyễn Công Lộc', 'Nam', '10A', 'nguyenvana@gmail.com', 'Hà Nội', 'Học',101),
(1002, 'Nguyễn Thị B', 'Nữ', '10B', 'nguyenthib@gmail.com', 'Quảng Ninh', 'Học',101),
(1003, 'Trần Văn C', 'Nam', '10C', 'tranvanc@gmail.com', 'Bắc Giang', 'Học',101),
(1004, 'Trần Thị D', 'Nữ', '10D', 'tranthid@gmail.com', 'Hà Tĩnh', 'Học',101),
(1005, 'Lê Văn E', 'Nam', '10E', 'levane@gmail.com', 'Lâm Đồng', 'Học',101),
(1006, 'Lê Thị F', 'Nữ', '10A', 'lethif@gmail.com', 'Hải Dương', 'Học',101),
(1007, 'Phạm Văn G', 'Nam', '10B', 'phamvang@gmail.com', 'Hải Phòng', 'Học',101),
(1008, 'Phạm Thị H', 'Nữ', '10C', 'phamthih@gmail.com', 'Hà Nội', 'Học',101),
(1009, 'Hoàng Văn I', 'Nam', '10D', 'hoangvani@gmail.com', 'Hà Nội', 'Học',101),
(1010, 'Hoàng Thị K', 'Nữ', '10E', 'hoangthik@gmail.com', 'Hà Nội', 'Học',101);

-- Thêm thông tin giáo viên
INSERT INTO Teachers (teacher_id, full_name, gender, teaching_subject, email, address) VALUES
(2001, 'Nguyễn Văn Giáo', 'Nam', 'Toán', 'nguyenvangiao@gmail.com', 'Hà Nội'),
(2002, 'Trần Thị Giáo', 'Nữ', 'Văn', 'tranthigiao@gmail.com', 'Bắc Giang'),
(2003, 'Lê Văn Khoa', 'Nam', 'Lịch sử', 'levankhoa@gmail.com', 'Hà Nam'),
(2004, 'Nguyễn Thị Lan', 'Nữ', 'Địa lý', 'nguyenthilan@gmail.com', 'Hải Phòng'),
(2005, 'Trần Văn Mạnh', 'Nam', 'Hóa học', 'tranvanmanh@gmail.com', 'Vũng Tàu'),
(2006, 'Lê Thị Nhung', 'Nữ', 'Sinh học', 'lethinung@gmail.com', 'Hà Nội'),
(2007, 'Phạm Văn Quân', 'Nam', 'Vật lý', 'phamvanquan@gmail.com', 'Hà Nội'),
(2008, 'Trần Thị Quỳnh', 'Nữ', 'Ngoại ngữ', 'tranthiquynh@gmail.com', 'Hà Nội'),
(2009, 'Hoàng Văn Sơn', 'Nam', 'Công nghệ', 'hoangvanson@gmail.com', 'Cao Bằng '),
(2010, 'Hoàng Thị Tâm', 'Nữ', 'Âm nhạc', 'hoangthitam@gmail.com', 'Nghệ Tĩnh'),
(2011, 'Nguyễn Văn Vinh', 'Nam', 'Thể dục', 'nguyenvanvinh@gmail.com', 'Kon Tum'),
(2012, 'Trần Thị Xuân', 'Nữ', 'Mỹ thuật', 'tranthixuan@gmail.com', 'Điện Biên');

-- Thêm dữ liệu vào bảng Subjects
INSERT INTO Subjects (subject_id, subject_name, teacher_id) VALUES
('TOAN', 'Toán', 2001),
('VAN', 'Văn', 2002),
('LS', 'Lịch sử', 2003),
('DL', 'Địa lý', 2004),
('HH', 'Hóa học', 2005),
('SH', 'Sinh học', 2006),
('VL', 'Vật lý', 2007),
('NN', 'Ngoại ngữ', 2008),
('CNTT', 'Công nghệ', 2009),
('AMNHAC', 'Âm nhạc', 2010),
('TD', 'Thể dục', 2011),
('MT', 'Mỹ thuật', 2012);

INSERT INTO Scores (student_id, subject_id, class_id, term_id, mid_term_score, final_term_score) VALUES
-- Lớp 10A
(1001, 'TOAN', '10A', 101, 8.5, 9),
(1001, 'VAN', '10A', 101, 7.0, NULL),
(1001, 'LS', '10A', 101, 6.5, NULL),
(1001, 'DL', '10A', 101, 7.5, NULL),
(1001, 'HH', '10A', 101, 9.0, NULL),
(1001, 'SH', '10A', 101, 8.0,NULL),
(1001, 'VL', '10A', 101, 8.5, NULL),
(1001, 'NN', '10A', 101, 7.0, NULL),
(1001, 'CNTT', '10A', 101, 8.0,NULL),
(1001, 'AMNHAC', '10A', 101, 7.5, NULL),
(1001, 'TD', '10A', 101, 8.5, NULL),
(1001, 'MT', '10A', 101,NULL, NULL),

-- Lớp 10B
(1002, 'TOAN', '10B', 101, NULL,NULL),
(1002, 'VAN', '10B', 101, NULL, NULL),
(1002, 'LS', '10B', 101, NULL, NULL),
(1002, 'DL', '10B', 101, NULL, NULL),
(1002, 'HH', '10B', 101, NULL, NULL),
(1002, 'SH', '10B', 101, NULL, NULL),
(1002, 'VL', '10B', 101, NULL, NULL),
(1002, 'NN', '10B', 101, NULL, NULL),
(1002, 'CNTT', '10B', 101, NULL,NULL),
(1002, 'AMNHAC', '10B', 101, NULL,NULL),
(1002, 'TD', '10B', 101, NULL, NULL),
(1002, 'MT', '10B', 101, NULL, NULL);

INSERT INTO Users (username, email, password, role) 
VALUES ('admin', 'admin@gmail.com', '1', 'admin');

INSERT INTO Users (username, email, password, role, student_id) 
VALUES 
('student', 'student@gmail.com', '1', 'student', 1001);

INSERT INTO Users (username, email, password, role, teacher_id) 
VALUES
('teacher', 'teacher@gmail.com', '1', 'teacher', 2001);

-- Ngày 12/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'TOAN', '10A', 101, '2024-06-12', 'NO'),
(1001, 'VAN', '10A', 101, '2024-06-12', 'YES'),
(1002, 'TOAN', '10B', 101, '2024-06-12', NULL),
(1002, 'VAN', '10B', 101, '2024-06-12', NULL),
(1003, 'TOAN', '10C', 101, '2024-06-12', NULL),
(1003, 'VAN', '10C', 101, '2024-06-12', NULL),
(1004, 'TOAN', '10D', 101, '2024-06-12', NULL),
(1004, 'VAN', '10D', 101, '2024-06-12', NULL),
(1005, 'TOAN', '10E', 101, '2024-06-12', NULL),
(1005, 'VAN', '10E', 101, '2024-06-12', NULL),
(1006, 'TOAN', '10A', 101, '2024-06-12', NULL),
(1006, 'VAN', '10A', 101, '2024-06-12', NULL),
(1007, 'TOAN', '10B', 101, '2024-06-12', NULL),
(1007, 'VAN', '10B', 101, '2024-06-12', NULL),
(1008, 'TOAN', '10C', 101, '2024-06-12', NULL),
(1008, 'VAN', '10C', 101, '2024-06-12', NULL),
(1009, 'TOAN', '10D', 101, '2024-06-12', NULL),
(1009, 'VAN', '10D', 101, '2024-06-12', NULL),
(1010, 'TOAN', '10E', 101, '2024-06-12', NULL),
(1010, 'VAN', '10E', 101, '2024-06-12', NULL);

-- Ngày 13/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'LS', '10A', 101, '2024-06-13', 'YES'),
(1001, 'DL', '10A', 101, '2024-06-13', 'NO'),
(1002, 'LS', '10B', 101, '2024-06-13', NULL),
(1002, 'DL', '10B', 101, '2024-06-13', NULL),
(1003, 'LS', '10C', 101, '2024-06-13', NULL),
(1003, 'DL', '10C', 101, '2024-06-13', NULL),
(1004, 'LS', '10D', 101, '2024-06-13', NULL),
(1004, 'DL', '10D', 101, '2024-06-13', NULL),
(1005, 'LS', '10E', 101, '2024-06-13', NULL),
(1005, 'DL', '10E', 101, '2024-06-13', NULL),
(1006, 'LS', '10A', 101, '2024-06-13', NULL),
(1006, 'DL', '10A', 101, '2024-06-13', NULL),
(1007, 'LS', '10B', 101, '2024-06-13', NULL),
(1007, 'DL', '10B', 101, '2024-06-13', NULL),
(1008, 'LS', '10C', 101, '2024-06-13', NULL),
(1008, 'DL', '10C', 101, '2024-06-13', NULL),
(1009, 'LS', '10D', 101, '2024-06-13', NULL),
(1009, 'DL', '10D', 101, '2024-06-13', NULL),
(1010, 'LS', '10E', 101, '2024-06-13', NULL),
(1010, 'DL', '10E', 101, '2024-06-13', NULL);

-- Ngày 14/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'HH', '10A', 101, '2024-06-14', NULL),
(1001, 'SH', '10A', 101, '2024-06-14', NULL),
(1002, 'HH', '10B', 101, '2024-06-14', NULL),
(1002, 'SH', '10B', 101, '2024-06-14', NULL),
(1003, 'HH', '10C', 101, '2024-06-14', NULL),
(1003, 'SH', '10C', 101, '2024-06-14', NULL),
(1004, 'HH', '10D', 101, '2024-06-14', NULL),
(1004, 'SH', '10D', 101, '2024-06-14', NULL),
(1005, 'HH', '10E', 101, '2024-06-14', NULL),
(1005, 'SH', '10E', 101, '2024-06-14', NULL),
(1006, 'HH', '10A', 101, '2024-06-14', NULL),
(1006, 'SH', '10A', 101, '2024-06-14', NULL),
(1007, 'HH', '10B', 101, '2024-06-14', NULL),
(1007, 'SH', '10B', 101, '2024-06-14', NULL),
(1008, 'HH', '10C', 101, '2024-06-14', NULL),
(1008, 'SH', '10C', 101, '2024-06-14', NULL),
(1009, 'HH', '10D', 101, '2024-06-14', NULL),
(1009, 'SH', '10D', 101, '2024-06-14', NULL),
(1010, 'HH', '10E', 101, '2024-06-14', NULL),
(1010, 'SH', '10E', 101, '2024-06-14', NULL);

-- Ngày 15/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'VL', '10A', 101, '2024-06-15', NULL),
(1001, 'NN', '10A', 101, '2024-06-15', NULL),
(1002, 'VL', '10B', 101, '2024-06-15', NULL),
(1002, 'NN', '10B', 101, '2024-06-15', NULL),
(1003, 'VL', '10C', 101, '2024-06-15', NULL),
(1003, 'NN', '10C', 101, '2024-06-15', NULL),
(1004, 'VL', '10D', 101, '2024-06-15', NULL),
(1004, 'NN', '10D', 101, '2024-06-15', NULL),
(1005, 'VL', '10E', 101, '2024-06-15', NULL),
(1005, 'NN', '10E', 101, '2024-06-15', NULL),
(1006, 'VL', '10A', 101, '2024-06-15', NULL),
(1006, 'NN', '10A', 101, '2024-06-15', NULL),
(1007, 'VL', '10B', 101, '2024-06-15', NULL),
(1007, 'NN', '10B', 101, '2024-06-15', NULL),
(1008, 'VL', '10C', 101, '2024-06-15', NULL),
(1008, 'NN', '10C', 101, '2024-06-15', NULL),
(1009, 'VL', '10D', 101, '2024-06-15', NULL),
(1009, 'NN', '10D', 101, '2024-06-15', NULL),
(1010, 'VL', '10E', 101, '2024-06-15', NULL),
(1010, 'NN', '10E', 101, '2024-06-15', NULL);

INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'TD', '10A', 101, '2024-06-16', NULL),
(1001, 'AM', '10A', 101, '2024-06-16', NULL),
(1002, 'TD', '10B', 101, '2024-06-16', NULL),
(1002, 'AM', '10B', 101, '2024-06-16', NULL),
(1003, 'TD', '10C', 101, '2024-06-16', NULL),
(1003, 'AM', '10C', 101, '2024-06-16', NULL),
(1004, 'TD', '10D', 101, '2024-06-16', NULL),
(1004, 'AM', '10D', 101, '2024-06-16', NULL),
(1005, 'TD', '10E', 101, '2024-06-16', NULL),
(1005, 'AM', '10E', 101, '2024-06-16', NULL),
(1006, 'TD', '10A', 101, '2024-06-16', NULL),
(1006, 'AM', '10A', 101, '2024-06-16', NULL),
(1007, 'TD', '10B', 101, '2024-06-16', NULL),
(1007, 'AM', '10B', 101, '2024-06-16', NULL),
(1008, 'TD', '10C', 101, '2024-06-16', NULL),
(1008, 'AM', '10C', 101, '2024-06-16', NULL),
(1009, 'TD', '10D', 101, '2024-06-16', NULL),
(1009, 'AM', '10D', 101, '2024-06-16', NULL),
(1010, 'TD', '10E', 101, '2024-06-16', NULL),
(1010, 'AM', '10E', 101, '2024-06-16', NULL);

-- Ngày 17/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'CN', '10A', 101, '2024-06-17', NULL),
(1001, 'MT', '10A', 101, '2024-06-17', NULL),
(1002, 'CN', '10B', 101, '2024-06-17', NULL),
(1002, 'MT', '10B', 101, '2024-06-17', NULL),
(1003, 'CN', '10C', 101, '2024-06-17', NULL),
(1003, 'MT', '10C', 101, '2024-06-17', NULL),
(1004, 'CN', '10D', 101, '2024-06-17', NULL),
(1004, 'MT', '10D', 101, '2024-06-17', NULL),
(1005, 'CN', '10E', 101, '2024-06-17', NULL),
(1005, 'MT', '10E', 101, '2024-06-17', NULL),
(1006, 'CN', '10A', 101, '2024-06-17', NULL),
(1006, 'MT', '10A', 101, '2024-06-17', NULL),
(1007, 'CN', '10B', 101, '2024-06-17', NULL),
(1007, 'MT', '10B', 101, '2024-06-17', NULL),
(1008, 'CN', '10C', 101, '2024-06-17', NULL),
(1008, 'MT', '10C', 101, '2024-06-17', NULL),
(1009, 'CN', '10D', 101, '2024-06-17', NULL),
(1009, 'MT', '10D', 101, '2024-06-17', NULL),
(1010, 'CN', '10E', 101, '2024-06-17', NULL),
(1010, 'MT', '10E', 101, '2024-06-17', NULL);

-- Ngày 18/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'DL', '10A', 101, '2024-06-18', NULL),
(1001, 'SH', '10A', 101, '2024-06-18', NULL),
(1002, 'DL', '10B', 101, '2024-06-18', NULL),
(1002, 'SH', '10B', 101, '2024-06-18', NULL),
(1003, 'DL', '10C', 101, '2024-06-18', NULL),
(1003, 'SH', '10C', 101, '2024-06-18', NULL),
(1004, 'DL', '10D', 101, '2024-06-18', NULL),
(1004, 'SH', '10D', 101, '2024-06-18', NULL),
(1005, 'DL', '10E', 101, '2024-06-18', NULL),
(1005, 'SH', '10E', 101, '2024-06-18', NULL),
(1006, 'DL', '10A', 101, '2024-06-18', NULL),
(1006, 'SH', '10A', 101, '2024-06-18', NULL),
(1007, 'DL', '10B', 101, '2024-06-18', NULL),
(1007, 'SH', '10B', 101, '2024-06-18', NULL),
(1008, 'DL', '10C', 101, '2024-06-18', NULL),
(1008, 'SH', '10C', 101, '2024-06-18', NULL),
(1009, 'DL', '10D', 101, '2024-06-18', NULL),
(1009, 'SH', '10D', 101, '2024-06-18', NULL),
(1010, 'DL', '10E', 101, '2024-06-18', NULL),
(1010, 'SH', '10E', 101, '2024-06-18', NULL);

-- Ngày 19/6/2024
INSERT INTO Attendance (student_id, subject_id, class_id, term_id, session_date, attended) VALUES
(1001, 'TOAN', '10A', 101, '2024-06-19', NULL),
(1001, 'VAN', '10A', 101, '2024-06-19', NULL),
(1002, 'TOAN', '10B', 101, '2024-06-19', NULL),
(1002, 'VAN', '10B', 101, '2024-06-19', NULL),
(1003, 'TOAN', '10C', 101, '2024-06-19', NULL),
(1003, 'VAN', '10C', 101, '2024-06-19', NULL),
(1004, 'TOAN', '10D', 101, '2024-06-19', NULL),
(1004, 'VAN', '10D', 101, '2024-06-19', NULL),
(1005, 'TOAN', '10E', 101, '2024-06-19', NULL),
(1005, 'VAN', '10E', 101, '2024-06-19', NULL),
(1006, 'TOAN', '10A', 101, '2024-06-19', NULL),
(1006, 'VAN', '10A', 101, '2024-06-19', NULL),
(1007, 'TOAN', '10B', 101, '2024-06-19', NULL),
(1007, 'VAN', '10B', 101, '2024-06-19', NULL),
(1008, 'TOAN', '10C', 101, '2024-06-19', NULL),
(1008, 'VAN', '10C', 101, '2024-06-19', NULL),
(1009, 'TOAN', '10D', 101, '2024-06-19', NULL),
(1009, 'VAN', '10D', 101, '2024-06-19', NULL),
(1010, 'TOAN', '10E', 101, '2024-06-19', NULL),
(1010, 'VAN', '10E', 101, '2024-06-19', NULL);

CREATE TABLE TeacherClasses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    class_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    subject_id VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

INSERT INTO TeacherClasses (teacher_id, class_id, subject_id) VALUES
(2001, '10A', 'TOAN'),
(2001, '10B', 'TOAN'),
(2002, '10A', 'VAN'),
(2002, '10B', 'VAN'),
(2003, '10A', 'LS'),
(2003, '10B', 'LS'),
(2004, '10A', 'DL'),
(2004, '10B', 'DL'),
(2005, '10A', 'HH'),
(2005, '10B', 'HH'),
(2006, '10A', 'SH'),
(2006, '10B', 'SH'),
(2007, '10A', 'VL'),
(2007, '10B', 'VL'),
(2008, '10A', 'NN'),
(2008, '10B', 'NN'),
(2009, '10A', 'CNTT'),
(2009, '10B', 'CNTT'),
(2010, '10A', 'AMNHAC'),
(2010, '10B', 'AMNHAC'),
(2011, '10A', 'TD'),
(2011, '10B', 'TD'),
(2012, '10A', 'MT'),
(2012, '10B', 'MT');





