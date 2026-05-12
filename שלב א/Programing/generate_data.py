import random
import json

# פונקציה ליצירת תאריך אקראי
def random_date(start_year, end_year):
    year = random.randint(start_year, end_year)
    month = random.randint(1, 12)
    day = random.randint(1, 28)
    return f"{year}-{month:02d}-{day:02d}"

# הגדרת כמויות (לפי דרישות המרצה)
NUM_PATIENTS = 500
NUM_DOCTORS = 100
NUM_APPOINTMENTS = 500
NUM_VISITS = 20000  # דרישה ל-20,000
NUM_PRESCRIPTIONS = 500
NUM_PAYMENTS = 20000     # דרישה ל-20,000

with open('insertTables.sql', 'w', encoding='utf-8') as f:
    f.write("-- שיטה ג': יצירת נתונים באמצעות סקריפט פייתון\n\n")

    # 1. Patients
    f.write("-- Patients\n")
    for i in range(1, NUM_PATIENTS + 1):
        contact = json.dumps({"phone": f"050-{random.randint(1000000, 9999999)}", "email": f"user{i}@clinic.com"})
        f.write(f"INSERT INTO Patients VALUES ({i}, 'First{i}', 'Last{i}', '{random_date(1950, 2020)}', 'Other', '{contact}');\n")

    # 2. Doctors
    f.write("\n-- Doctors\n")
    specs = ['Cardiology', 'Pediatrics', 'Orthopedics', 'General']
    for i in range(101, 101 + NUM_DOCTORS):
        hours = json.dumps({"Sunday": "08:00-14:00", "Monday": "10:00-16:00"})
        f.write(f"INSERT INTO Doctors VALUES ({i}, 'Dr_{i}', 'DocLast', '{random.choice(specs)}', '{random_date(2010, 2024)}', '{hours}');\n")

    # 3. Appointments
    f.write("\n-- Appointments\n")
    for i in range(5000, 5000 + NUM_APPOINTMENTS):
        p_id = random.randint(1, NUM_PATIENTS)
        d_id = random.randint(101, 101 + NUM_DOCTORS - 1)
        f.write(f"INSERT INTO Appointments VALUES ({i}, '{random_date(2024, 2025)}', '10:00:00', 'Completed', {p_id}, {d_id});\n")

    # 4. Visits_Records (20,000 רשומות)
    f.write("\n-- Visits_Records (20,000 records)\n")
    for i in range(1, NUM_VISITS + 1):
        app_id = 5000 + (i % NUM_APPOINTMENTS) # מקשר לתורים קיימים במחזוריות
        vitals = json.dumps({"temp": random.randint(36, 39), "bp": "120/80"})
        f.write(f"INSERT INTO Visits_Records VALUES ({i}, 'Diagnosis_{i}', 'Notes_{i}', '{vitals}', 'No', {app_id});\n")

    # 5. Prescriptions
    f.write("\n-- Prescriptions\n")
    for i in range(1, NUM_PRESCRIPTIONS + 1):
        v_id = random.randint(1, NUM_VISITS)
        f.write(f"INSERT INTO Prescriptions VALUES ({i}, 'Medicine_{i}', '10mg', '{random_date(2024, 2025)}', 'Take daily', {v_id});\n")

    # 6. Payments (20,000 רשומות)
    f.write("\n-- Payments (20,000 records)\n")
    for i in range(1, NUM_PAYMENTS + 1):
        p_id = random.randint(1, NUM_PATIENTS)
        trans = json.dumps({"auth_code": random.randint(1000, 9999)})
        f.write(f"INSERT INTO Payments VALUES ({i}, {random.randint(100, 1000)}, '{random_date(2024, 2025)}', 'Credit', '{trans}', {p_id});\n")

print("Done! insertTables.sql was created with 20,000+ records.")