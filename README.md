Hospital Management System (SQL DBMS Project)

Overview

The Hospital Management System is a database management project developed using MySQL. It is designed to manage hospital operations such as patient records, doctor information, appointments, and billing details. The project demonstrates core DBMS concepts including relational database design, normalization, primary and foreign keys, joins, views, stored procedures, and triggers.

Features

- Patient Management
- Doctor Management
- Department Management
- Appointment Scheduling
- Billing System
- Database Views
- Stored Procedures
- Triggers for Data Validation
- SQL Reports and Analytics

Database Schema

Tables

1. Departments
2. Doctors
3. Patients
4. Appointments
5. Bills

Relationships

- One Department can have multiple Doctors.
- One Doctor can handle multiple Appointments.
- One Patient can have multiple Appointments.
- One Patient can have multiple Bills.

Technologies Used

- MySQL
- SQL

Project Structure

Hospital-Management-System/

├── hospital_management.sql

└── README.md

Installation

1. Clone the repository:
   
   git clone https://github.com/janarthananr/Hospital-Management-System.git

2. Open MySQL Workbench or any MySQL client.

3. Execute the SQL script:
   
   SOURCE hospital_management.sql;

4. The database and sample data will be created automatically.

Sample Queries

View All Patients

SELECT * FROM Patients;

Doctor-wise Appointment Count

SELECT d.doctor_name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;

Total Revenue

SELECT SUM(amount) AS TotalRevenue
FROM Bills
WHERE payment_status = 'Paid';

Learning Outcomes

- Database Design
- Entity Relationship Modeling
- SQL Query Writing
- Joins and Subqueries
- Stored Procedures
- Triggers
- Views
- Database Normalization

Future Enhancements

- Web-based User Interface
- Authentication System
- Online Appointment Booking
- Medical Records Management
- Dashboard and Reporting

Author

Janarthanan R

License

This project is open-source and available for educational purposes.
