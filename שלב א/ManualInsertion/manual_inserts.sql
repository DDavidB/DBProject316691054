-- 1. Inserting data into Patients table
INSERT INTO Patients (Patient_ID, First_Name, Last_Name, Birth_Date, Gender, Phone, Email, Address) VALUES 
(1, 'ישראל', 'ישראלי', '1985-05-20', 'Male', '050-1234567', 'israel@email.com', 'Herzl 10, Tel Aviv'),
(2, 'שרה', 'לוי', '1992-11-03', 'Female', '052-7654321', 'sara.levi@email.com', 'Ben Gurion 5, Haifa'),
(3, 'משה', 'כהן', '1970-01-15', 'Male', '054-1112223', 'moshe.c@email.com', 'Rabin 12, Jerusalem');

-- 2. Inserting data into Doctors table
INSERT INTO Doctors (License_Number, First_Name, Last_Name, Specialization, Hire_Date) VALUES 
(101, 'ד"ר רות', 'אברהם', 'Cardiology', '2015-06-01'),
(102, 'ד"ר אלון', 'מזרחי', 'Orthopedics', '2018-02-15');

-- 2b. Inserting data into Doctor_Working_Hours table
INSERT INTO Doctor_Working_Hours (License_Number, Day_Of_Week, Start_Time, End_Time) VALUES 
(101, 'Sunday', '08:00', '14:00'),
(101, 'Tuesday', '12:00', '18:00'),
(102, 'Monday', '09:00', '15:00'),
(102, 'Thursday', '10:00', '16:00');

-- 3. Inserting data into Appointments table
INSERT INTO Appointments (Appointment_ID, Appointment_Date, Start_Time, Status, Patient_ID, License_Number) VALUES 
(5001, '2024-05-12', '09:00:00', 'Completed', 1, 101),
(5002, '2024-05-12', '10:30:00', 'Completed', 2, 101),
(5003, '2024-05-13', '11:00:00', 'Scheduled', 3, 102);

-- 4. Inserting data into Visits Records table
INSERT INTO Visits_Records (Visit_ID, Diagnosis, Doctor_Notes, Temperature, Blood_Pressure, Weight, Pulse, Follow_Up_Needed, Appointment_ID) VALUES 
(9001, 'High Blood Pressure', 'Patient needs to reduce salt intake.', 36.6, '145/90', 80.0, 82, 'Yes', 5001),
(9002, 'Common Cold', 'Rest and fluids recommended.', 38.2, '120/80', 75.0, 70, 'No', 5002);

-- 5. Inserting data into Prescriptions table
INSERT INTO Prescriptions (Prescription_ID, Medication_Name, Dosage, Issue_Date, Notes, Visit_ID) VALUES 
(8001, 'Amlodipine', '5mg once daily', '2024-05-12', 'Take in the morning', 9001),
(8002, 'Paracetamol', '500mg as needed', '2024-05-12', 'Max 4 times a day', 9002);

-- 6. Inserting data into Payments table
INSERT INTO Payments (Payment_ID, Amount, Payment_Date, Payment_Method, CardLast4, AuthCode, ReceiptNo, Patient_ID) VALUES 
(7001, 150.00, '2024-05-12', 'Credit Card', '4422', '098765', NULL, 1),
(7002, 50.00, '2024-05-12', 'Cash', NULL, NULL, 'A-102', 2);
