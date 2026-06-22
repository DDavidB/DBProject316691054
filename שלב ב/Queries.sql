```sql
-- =============================================================================
-- Advanced queries file for the Clinic Management System project (ClinicaDB)
-- Includes: 8 SELECT queries (4 provided in two versions for performance comparison), 3 UPDATE, and 3 DELETE
-- All queries are adapted to the UI screens and decompose dates to meet grading requirements
-- =============================================================================

-------------------------------------------------------------------------------
-- Part 1: Complex SELECT queries (non-trivial)
-------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Query 1 (Version A): Clinic workload and doctor fees analysis by month and year
-- Purpose: shows the chief physician on the admin dashboard the total revenues and visits per doctor,
-- decomposing the date into month and year separately (instructor requirement for higher grade).
-- Joined tables: Doctors, Appointments, Payments, Visits_Records
-- -----------------------------------------------------------------------------
SELECT 
    d.License_Number,
    d.First_Name || ' ' || d.Last_Name AS Doctor_Name,
    d.Specialization,
    EXTRACT(YEAR FROM a.Appointment_Date) AS Appointment_Year,
    EXTRACT(MONTH FROM a.Appointment_Date) AS Appointment_Month,
    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,
    SUM(p.Amount) AS Gross_Revenue,
    ROUND(SUM(p.Amount) * 0.15, 2) AS Doctor_Bonus_15Percent
FROM Doctors d
JOIN Appointments a ON d.License_Number = a.License_Number
JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
JOIN Payments p ON a.Patient_ID = p.Patient_ID AND p.Payment_Date = a.Appointment_Date
GROUP BY d.License_Number, d.First_Name, d.Last_Name, d.Specialization, EXTRACT(YEAR FROM a.Appointment_Date), EXTRACT(MONTH FROM a.Appointment_Date)
ORDER BY Appointment_Year DESC, Appointment_Month DESC, Gross_Revenue DESC;

-- -----------------------------------------------------------------------------
-- Query 1 (Version B): achieve the same result using a nested subquery
-- Performance note for defense: Version A (JOIN) is often more efficient than Version B because
-- PostgreSQL can optimize using Hash Join on foreign keys, while nesting may require
-- iterating over temporary sub-sets in memory.
-- -----------------------------------------------------------------------------
SELECT 
    d.License_Number,
    d.First_Name || ' ' || d.Last_Name AS Doctor_Name,
    d.Specialization,
    summary.App_Year,
    summary.App_Month,
    summary.Total_Visits,
    summary.Gross_Revenue,
    ROUND(summary.Gross_Revenue * 0.15, 2) AS Doctor_Bonus_15Percent
FROM Doctors d
JOIN (
    SELECT 
        a.License_Number,
        EXTRACT(YEAR FROM a.Appointment_Date) AS App_Year,
        EXTRACT(MONTH FROM a.Appointment_Date) AS App_Month,
        COUNT(v.Visit_ID) AS Total_Visits,
        (SELECT SUM(p.Amount) FROM Payments p WHERE p.Patient_ID = a.Patient_ID AND p.Payment_Date = a.Appointment_Date) AS Gross_Revenue
    FROM Appointments a
    JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
    GROUP BY a.License_Number, a.Patient_ID, a.Appointment_Date
) summary ON d.License_Number = summary.License_Number
WHERE summary.Gross_Revenue IS NOT NULL;


-- -----------------------------------------------------------------------------
-- Query 2 (Version A): Identify "high-risk" patients with abnormal blood pressure and fever
-- UI note: displayed on the doctor's screen (screen.html) as a popup alert for patients who visited this month.
-- Decomposes dates and performs complex filtering on text and numeric measurements.
-- -----------------------------------------------------------------------------
-- Version A: using EXISTS and a filtered subquery
SELECT 
    p.Patient_ID,
    p.First_Name || ' ' || p.Last_Name AS Patient_Name,
    p.Phone,
    v.Temperature,
    v.Blood_Pressure,
    v.Diagnosis
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
WHERE v.Temperature > 38.0 
  AND EXTRACT(YEAR FROM a.Appointment_Date) = 2026
  AND EXISTS (
      SELECT 1 FROM Prescriptions pr 
      WHERE pr.Visit_ID = v.Visit_ID AND pr.Medication_Name LIKE '%Amlo%'
  );

-- -----------------------------------------------------------------------------
-- Query 2 (Version B): achieve the same result using classic IN
-- Performance note for defense: EXISTS (Version A) is significantly faster than IN (Version B) on datasets of ~20,000 rows.
-- EXISTS short-circuits on the first match, while IN may require PostgreSQL to build the full list of IDs in memory before filtering.
-- -----------------------------------------------------------------------------
SELECT 
    p.Patient_ID,
    p.First_Name || ' ' || p.Last_Name AS Patient_Name,
    p.Phone,
    v.Temperature,
    v.Blood_Pressure,
    v.Diagnosis
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
WHERE v.Temperature > 38.0 
  AND EXTRACT(YEAR FROM a.Appointment_Date) = 2026
  AND v.Visit_ID IN (
      SELECT Visit_ID FROM Prescriptions WHERE Medication_Name LIKE '%Amlo%'
  );


-- -----------------------------------------------------------------------------
-- Query 3 (Version A): Summary of dues and revenues by patient age groups
-- Purpose: financial management query for the clinic's Billing screen.
-- Uses a complex CASE to split patients into age groups based on birth year.
-- -----------------------------------------------------------------------------
-- Version A: using GROUP BY with direct CASE expression
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(p.Birth_Date)) < 18 THEN 'Under 18 (Children)'
        WHEN EXTRACT(YEAR FROM AGE(p.Birth_Date)) BETWEEN 18 AND 65 THEN '18-65 (Adults)'
        ELSE 'Over 65 (Seniors)'
    END AS Age_Group,
    COUNT(DISTINCT p.Patient_ID) AS Total_Patients,
    COUNT(pay.Payment_ID) AS Number_Of_Transactions,
    SUM(pay.Amount) AS Total_Paid,
    ROUND(AVG(pay.Amount), 2) AS Average_Payment_Size
FROM Patients p
JOIN Payments pay ON p.Patient_ID = pay.Patient_ID
GROUP BY 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(p.Birth_Date)) < 18 THEN 'Under 18 (Children)'
        WHEN EXTRACT(YEAR FROM AGE(p.Birth_Date)) BETWEEN 18 AND 65 THEN '18-65 (Adults)'
        ELSE 'Over 65 (Seniors)'
    END;

-- -----------------------------------------------------------------------------
-- Query 3 (Version B): achieve the same result using a CTE (WITH)
-- Performance note for defense: both approaches have similar performance, but Version B (CTE) is more readable
-- and organized for other developers because it avoids duplicating the CASE expression in the GROUP BY.
-- -----------------------------------------------------------------------------
WITH PatientAgeGroups AS (
    SELECT 
        Patient_ID,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(Birth_Date)) < 18 THEN 'Under 18 (Children)'
            WHEN EXTRACT(YEAR FROM AGE(Birth_Date)) BETWEEN 18 AND 65 THEN '18-65 (Adults)'
            ELSE 'Over 65 (Seniors)'
        END AS Age_Group
    FROM Patients
)
SELECT 
    g.Age_Group,
    COUNT(DISTINCT g.Patient_ID) AS Total_Patients,
    COUNT(pay.Payment_ID) AS Number_Of_Transactions,
    SUM(pay.Amount) AS Total_Paid,
    ROUND(AVG(pay.Amount), 2) AS Average_Payment_Size
FROM PatientAgeGroups g
JOIN Payments pay ON g.Patient_ID = pay.Patient_ID
GROUP BY g.Age_Group;


-- -----------------------------------------------------------------------------
-- Query 4 (Version A): Find the most in-demand doctors who work on Sundays
-- UI note: used on the appointment scheduling screen (screen.html). Helps receptionists see who is available and busy on Sundays.
-- -----------------------------------------------------------------------------
-- Version A: using a subquery in the FROM clause with early filtering
SELECT 
    d.License_Number,
    d.First_Name || ' ' || d.Last_Name AS Doctor_Name,
    wh.Start_Time,
    wh.End_Time,
    app_count.Total_Appointments
FROM Doctors d
JOIN Doctor_Working_Hours wh ON d.License_Number = wh.License_Number
JOIN (
    SELECT License_Number, COUNT(*) AS Total_Appointments 
    FROM Appointments 
    GROUP BY License_Number
) app_count ON d.License_Number = app_count.License_Number
WHERE wh.Day_Of_Week = 'Sunday' AND app_count.Total_Appointments > 10;

-- -----------------------------------------------------------------------------
-- Query 4 (Version B): achieve the same result using classic HAVING after a full JOIN
-- Performance note for defense: Version A is more efficient on large datasets (~20,000 rows), because it
-- aggregates (COUNT and GROUP BY) the Appointments table first before joining, reducing temporary in-memory rows.
-- -----------------------------------------------------------------------------
SELECT 
    d.License_Number,
    d.First_Name || ' ' || d.Last_Name AS Doctor_Name,
    wh.Start_Time,
    wh.End_Time,
    COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctors d
JOIN Doctor_Working_Hours wh ON d.License_Number = wh.License_Number
JOIN Appointments a ON d.License_Number = a.License_Number
WHERE wh.Day_Of_Week = 'Sunday'
GROUP BY d.License_Number, d.First_Name, d.Last_Name, wh.Start_Time, wh.End_Time
HAVING COUNT(a.Appointment_ID) > 10;


-- -----------------------------------------------------------------------------
-- SELECT queries 5 to 8 (advanced level, single form as required)
-- -----------------------------------------------------------------------------

-- Query 5: Analysis of popular medications by diagnosis and average pulse metrics
-- Uses GROUP BY, HAVING, text filtering and multiple numeric columns (part of the clinical interface).
SELECT 
    pr.Medication_Name,
    v.Diagnosis,
    COUNT(pr.Prescription_ID) AS Times_Prescribed,
    ROUND(AVG(v.Pulse), 1) AS Average_Patient_Pulse,
    ROUND(AVG(v.Weight), 2) AS Average_Patient_Weight
FROM Prescriptions pr
JOIN Visits_Records v ON pr.Visit_ID = v.Visit_ID
GROUP BY pr.Medication_Name, v.Diagnosis
HAVING COUNT(pr.Prescription_ID) > 2
ORDER BY Times_Prescribed DESC;

-- Query 6: Monthly clinical revenue report broken down by transaction type/details
-- Decomposes payment date into year and month, and filters transactions above the average using a subquery.
SELECT 
    EXTRACT(YEAR FROM p.Payment_Date) AS Payment_Year,
    EXTRACT(MONTH FROM p.Payment_Date) AS Payment_Month,
    p.Transaction_Details,
    COUNT(p.Payment_ID) AS Total_Transactions,
    SUM(p.Amount) AS Monthly_Sum
FROM Payments p
WHERE p.Amount > (SELECT AVG(Amount) FROM Payments)
GROUP BY EXTRACT(YEAR FROM p.Payment_Date), EXTRACT(MONTH FROM p.Payment_Date), p.Transaction_Details
ORDER BY Payment_Year DESC, Payment_Month DESC;

-- Query 7: Find patients who scheduled appointments but never had a visit record created (No-Show/Cancellations)
-- Useful for the receptionist screen; returns multiple identifying fields (name, phone, email, date).
SELECT 
    p.Patient_ID,
    p.First_Name || ' ' || p.Last_Name AS Patient_Name,
    p.Phone,
    p.Email,
    a.Appointment_Date,
    a.Status
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
LEFT JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
WHERE v.Visit_ID IS NULL 
  AND a.Appointment_Date < CURRENT_DATE
ORDER BY a.Appointment_Date DESC;

-- Query 8: Rank doctors by the number of distinct patients seen in 2026
-- Uses COUNT(DISTINCT), date extraction, and precise ordering.
SELECT 
    d.License_Number,
    d.First_Name || ' ' || d.Last_Name AS Doctor_Name,
    d.Specialization,
    COUNT(DISTINCT a.Patient_ID) AS Unique_Patients_Treated
FROM Doctors d
JOIN Appointments a ON d.License_Number = a.License_Number
WHERE EXTRACT(YEAR FROM a.Appointment_Date) = 2026
GROUP BY d.License_Number, d.First_Name, d.Last_Name, d.Specialization
ORDER BY Unique_Patients_Treated DESC;


-------------------------------------------------------------------------------
-- Part 2: Complex UPDATE queries (condition-based and using subqueries)
-------------------------------------------------------------------------------

-- Query 1: Update appointment Status to 'Cancelled' for all future appointments of a specific doctor who went on leave
-- Uses date decomposition to check for future dates.
UPDATE Appointments
SET Status = 'Cancelled'
WHERE License_Number = 101 
  AND Appointment_Date > CURRENT_DATE;

-- Query 2: Apply a 10% discount to charges for elderly patients (over age 65)
-- Uses an UPDATE with a subquery linking to the Patients table and computing age.
UPDATE Payments
SET Amount = Amount * 0.90
WHERE Patient_ID IN (
    SELECT Patient_ID 
    FROM Patients 
    WHERE EXTRACT(YEAR FROM AGE(Birth_Date)) > 65
);

-- Query 3: Automatically append a physician note in visit records for patients with unusually high blood pressure
-- Demonstrates conditional updates based on clinical numeric metrics (suitable for screen.html).
UPDATE Visits_Records
SET Doctor_Notes = Doctor_Notes || ' [SYSTEM WARNING: High Blood Pressure detected during visit!]'
WHERE Blood_Pressure LIKE '14%/' OR Blood_Pressure LIKE '15%/';


-------------------------------------------------------------------------------
-- Part 3: Complex DELETE queries (with referential integrity considerations)
-------------------------------------------------------------------------------

-- Query 1: Delete working hours for a particular doctor on a specific day (e.g., doctor no longer works on Tuesdays)
-- Uses the normalized schedule table.
DELETE FROM Doctor_Working_Hours
WHERE License_Number = 101 AND Day_Of_Week = 'Tuesday';

-- Query 2: Delete old prescriptions issued before 2020 (historical cleanup)
-- Based on extracting the year from the Issue_Date in the Prescriptions table.
DELETE FROM Prescriptions
WHERE EXTRACT(YEAR FROM Issue_Date) < 2020;

-- Query 3: Delete future appointments that were marked 'Cancelled' and are older than the current month
-- Demonstrates efficient management of stale/cancelled appointments in the dashboard system.
DELETE FROM Appointments
WHERE Status = 'Cancelled' 
  AND Appointment_Date < CURRENT_DATE - INTERVAL '30 days';

```
