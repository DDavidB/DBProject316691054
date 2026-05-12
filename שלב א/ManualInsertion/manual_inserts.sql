-- 1. הכנסת נתונים לטבלת מטופלים (שימוש ב-JSON ותאריכים)
INSERT INTO Patients (Patient_ID, First_Name, Last_Name, Birth_Date, Gender, Contact_Info) VALUES 
(1, 'ישראל', 'ישראלי', '1985-05-20', 'Male', '{"phone": "050-1234567", "email": "israel@email.com", "address": "Herzl 10, Tel Aviv"}'),
(2, 'שרה', 'לוי', '1992-11-03', 'Female', '{"phone": "052-7654321", "email": "sara.levi@email.com", "address": "Ben Gurion 5, Haifa"}'),
(3, 'משה', 'כהן', '1970-01-15', 'Male', '{"phone": "054-1112223", "email": "moshe.c@email.com", "address": "Rabin 12, Jerusalem"}');

-- 2. הכנסת נתונים לטבלת רופאים (כולל שעות עבודה ב-JSON)
INSERT INTO Doctors (License_Number, First_Name, Last_Name, Specialization, Hire_Date, Working_Hours) VALUES 
(101, 'ד"ר רות', 'אברהם', 'Cardiology', '2015-06-01', '{"Sunday": "08:00-14:00", "Tuesday": "12:00-18:00"}'),
(102, 'ד"ר אלון', 'מזרחי', 'Orthopedics', '2018-02-15', '{"Monday": "09:00-15:00", "Thursday": "10:00-16:00"}');

-- 3. הכנסת נתונים לטבלת תורים
INSERT INTO Appointments (Appointment_ID, Appointment_Date, Start_Time, Status, Patient_ID, License_Number) VALUES 
(5001, '2024-05-12', '09:00:00', 'Completed', 1, 101),
(5002, '2024-05-12', '10:30:00', 'Completed', 2, 101),
(5003, '2024-05-13', '11:00:00', 'Scheduled', 3, 102);

-- 4. הכנסת נתונים לטבלת סיכומי ביקור (כולל מדדים ב-JSON)
INSERT INTO Visits_Records (Visit_ID, Diagnosis, Doctor_Notes, Vitals_Data, Follow_Up_Needed, Appointment_ID) VALUES 
(9001, 'High Blood Pressure', 'Patient needs to reduce salt intake.', '{"BP": "145/90", "HeartRate": 82, "Temp": 36.6}', 'Yes', 5001),
(9002, 'Common Cold', 'Rest and fluids recommended.', '{"BP": "120/80", "HeartRate": 70, "Temp": 38.2}', 'No', 5002);

-- 5. הכנסת נתונים לטבלת מרשמים
INSERT INTO Prescriptions (Prescription_ID, Medication_Name, Dosage, Issue_Date, Notes, Visit_ID) VALUES 
(8001, 'Amlodipine', '5mg once daily', '2024-05-12', 'Take in the morning', 9001),
(8002, 'Paracetamol', '500mg as needed', '2024-05-12', 'Max 4 times a day', 9002);

-- 6. הכנסת נתונים לטבלת תשלומים (כולל פרטי עסקה ב-JSON)
INSERT INTO Payments (Payment_ID, Amount, Payment_Date, Payment_Method, Transaction_Details, Patient_ID) VALUES 
(7001, 150.00, '2024-05-12', 'Credit Card', '{"CardLast4": "4422", "AuthCode": "098765"}', 1),
(7002, 50.00, '2024-05-12', 'Cash', '{"ReceiptNo": "A-102"}', 2);
