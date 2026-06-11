# DBProject316691054 - Clinic Management System

**Database Systems Project**
**Submitted by:** David Bracha | **ID:** 316691054

---

## 1. Project Introduction & System Description
This project features a robust **Clinic Management System** built on a normalized relational database designed for managing patients, doctors, appointments, medical visits, prescriptions, and billing. 

Following a strict refactoring process, the system strictly adheres to classic database normalization rules (up to 3NF) for maximum data integrity. All unstructured data types (such as JSON/JSONB) have been completely eliminated in favor of clear table schemas, scalar variables, and structured relations. This ensures strong consistency, foreign key constraints, and optimal relational querying.

## 2. UI/UX Interface Characterization (HTML Screens)
The system's interface and workflow are characterized by 4 main screens implemented in the accompanying HTML files:
* **Dashboard & Appointment Management**: A daily schedule view displaying appointment statuses and doctor availability.
* **Digital Patient File**: Comprehensive medical history, medication sensitivities, and contact information.
* **Doctor Onboarding**: Registration screen for new medical staff, including their specialties and working hours.
* **Billing & Invoice Management**: Generation of charges for medical services and payment tracking.

## 3. Refactored Data Dictionary
The following table illustrates the logical structure of the core, newly-refactored tables in the system:

| Table Name | Field Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Patients** | Patient_ID | INT | PK | Unique identifier (ID) for the patient |
| **Patients** | Phone | VARCHAR(20) | - | Patient's phone number |
| **Patients** | Email | VARCHAR(100) | - | Patient's email address |
| **Patients** | Address | VARCHAR(255) | - | Patient's physical address |
| **Doctors** | License_Number | INT | PK | Government medical license number |
| **Doctor_Working_Hours** | Schedule_ID | SERIAL | PK | Unique identifier for a shift |
| **Doctor_Working_Hours** | License_Number | INT | FK | References the Doctors table |
| **Doctor_Working_Hours** | Day_Of_Week | VARCHAR(15) | - | Day of the week for the shift |
| **Doctor_Working_Hours** | Start_Time | TIME | - | Shift start time |
| **Doctor_Working_Hours** | End_Time | TIME | - | Shift end time |
| **Appointments** | Appointment_ID | INT | PK | Unique identifier for calendar appointments |
| **Appointments** | Status | VARCHAR(20) | CHECK | E.g., Scheduled, Completed, Cancelled |
| **Visits_Records** | Visit_ID | INT | PK | Unique identifier for medical summaries |
| **Visits_Records** | Temperature | DECIMAL(4,2)| - | Body temperature |
| **Visits_Records** | Blood_Pressure | VARCHAR(20) | - | Blood pressure reading (e.g., '120/80') |
| **Visits_Records** | Weight | DECIMAL(5,2)| - | Patient weight |
| **Visits_Records** | Pulse | INT | - | Pulse rate |
| **Prescriptions** | Prescription_ID| INT | PK | Unique identifier for a prescription |
| **Prescriptions** | Medication_Name| VARCHAR(100)| NOT NULL | Name of the medication |
| **Payments** | Payment_ID | INT | PK | Unique identifier for invoices/receipts |
| **Payments** | Amount | DECIMAL(10,2)| CHECK (> 0)| Payment amount |

## 4. Data Seeding Methodologies
The database was aggressively load-tested and populated with over 20,000 relational records. We accomplished this using 3 distinct data population techniques:

1. **Manual Seeding**: Basic, hand-written SQL `INSERT` statements to establish initial schema validation and confirm that core relationships and foreign key constraints function properly.
2. **Mockaroo Generation**: Bulk generation of 500 highly realistic, structured rows of data for both the Patients and Doctors tables.
3. **Automated Python Scripting**: A custom script (`generate_data.py`) algorithmically generated over 20,000 rigorous relational rows (specifically targeting heavy-load tables like Payments and Visits_Records) utilizing pure scalar inputs and loop-based logic.
