-- 1. Patients table
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Birth_Date DATE,
    Gender VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- 2. Doctors table
CREATE TABLE Doctors (
    License_Number INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Specialization VARCHAR(50),
    Hire_Date DATE
);

-- 2b. Doctor Working Hours (Refactored from JSON)
CREATE TABLE Doctor_Working_Hours (
    Schedule_ID SERIAL PRIMARY KEY,
    License_Number INT REFERENCES Doctors(License_Number),
    Day_Of_Week VARCHAR(15),
    Start_Time TIME,
    End_Time TIME
);

-- 3. Appointments table (links between doctor and patient)
CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Appointment_Date DATE,
    Start_Time TIME,
    Status VARCHAR(20),
    Patient_ID INT REFERENCES Patients(Patient_ID),
    License_Number INT REFERENCES Doctors(License_Number)
);

-- 4. Visits records table
CREATE TABLE Visits_Records (
    Visit_ID INT PRIMARY KEY,
    Diagnosis TEXT,
    Doctor_Notes TEXT,
    Temperature DECIMAL(4,2),
    Blood_Pressure VARCHAR(20),
    Weight DECIMAL(5,2),
    Pulse INT,
    Follow_Up_Needed VARCHAR(10),
    Appointment_ID INT UNIQUE REFERENCES Appointments(Appointment_ID)
);

-- 5. Prescriptions table
CREATE TABLE Prescriptions (
    Prescription_ID INT PRIMARY KEY,
    Medication_Name VARCHAR(100),
    Dosage VARCHAR(50),
    Issue_Date DATE,
    Notes TEXT,
    Visit_ID INT REFERENCES Visits_Records(Visit_ID)
);

-- 6. Payments table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Amount DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Method VARCHAR(20),
    CardLast4 VARCHAR(4),
    AuthCode VARCHAR(20),
    ReceiptNo VARCHAR(50),
    Patient_ID INT REFERENCES Patients(Patient_ID)
);