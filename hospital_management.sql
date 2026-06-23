CREATE DATABASE HospitalDB;
USE HospitalDB;

-- Department Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL
);

-- Doctor Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Patient Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

-- Appointment Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Billing Table
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Sample Data
INSERT INTO Departments(dept_name)
VALUES ('Cardiology'),
       ('Neurology'),
       ('Orthopedics');

INSERT INTO Doctors(doctor_name, specialization, dept_id)
VALUES ('Raj Kumar','Heart Specialist',1),
       ('Priya Sharma','Neurologist',2),
       ('Arun Kumar','Orthopedic',3);

INSERT INTO Patients(patient_name, age, gender, phone)
VALUES ('John',25,'Male','9876543210'),
       ('Alice',30,'Female','9876543211'),
       ('David',40,'Male','9876543212');

INSERT INTO Appointments(patient_id, doctor_id, appointment_date)
VALUES (1,1,'2026-06-20'),
       (2,2,'2026-06-21'),
       (3,3,'2026-06-22');

INSERT INTO Bills(patient_id, amount, payment_status)
VALUES (1,5000,'Paid'),
       (2,7000,'Pending'),
       (3,4500,'Paid');

-- View
CREATE VIEW PatientAppointments AS
SELECT
    p.patient_name,
    d.doctor_name,
    a.appointment_date
FROM Patients p
JOIN Appointments a
ON p.patient_id = a.patient_id
JOIN Doctors d
ON d.doctor_id = a.doctor_id;

-- Stored Procedure
DELIMITER //

CREATE PROCEDURE GetPatientBills(IN pid INT)
BEGIN
    SELECT *
    FROM Bills
    WHERE patient_id = pid;
END //

DELIMITER ;

-- Trigger
DELIMITER //

CREATE TRIGGER BillValidation
BEFORE INSERT ON Bills
FOR EACH ROW
BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount must be greater than zero';
    END IF;
END //

DELIMITER ;

-- Queries

-- All Patients
SELECT * FROM Patients;

-- Doctor-wise Appointments
SELECT d.doctor_name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;

-- Total Revenue
SELECT SUM(amount) AS TotalRevenue
FROM Bills
WHERE payment_status='Paid';

-- Pending Bills
SELECT *
FROM Bills
WHERE payment_status='Pending';

-- Patient Appointment Details
SELECT *
FROM PatientAppointments;

-- Execute Procedure
CALL GetPatientBills(1);
