-- 1. Patients table (includes DATE field and mandatory JSON field)
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Birth_Date DATE, -- DATE field 1
    Gender VARCHAR(10),
    Contact_Info JSONB -- JSON field 1
);

-- 2. Doctors table (includes JSON field for working hours)
CREATE TABLE Doctors (
    License_Number INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Specialization VARCHAR(50),
    Hire_Date DATE,
    Working_Hours JSONB -- JSON field 2
);

-- 3. Appointments table (links between doctor and patient)
CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Appointment_Date DATE, -- DATE field 2
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
    Vitals_Data JSONB, -- Additional JSON field for vitals
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
    Transaction_Details JSONB,
    Patient_ID INT REFERENCES Patients(Patient_ID)
);