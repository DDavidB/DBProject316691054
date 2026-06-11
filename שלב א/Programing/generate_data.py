import random

# Function to generate a random date
def random_date(start_year, end_year):
    year = random.randint(start_year, end_year)
    month = random.randint(1, 12)
    day = random.randint(1, 28)
    return f"{year}-{month:02d}-{day:02d}"

# Defining quantities (according to the lecturer's requirements)
NUM_PATIENTS = 500
NUM_DOCTORS = 100
NUM_APPOINTMENTS = 500
NUM_VISITS = 20000  # Requirement for 20,000
NUM_PRESCRIPTIONS = 500
NUM_PAYMENTS = 20000     # Requirement for 20,000

with open('insertTables.sql', 'w', encoding='utf-8') as f:
    f.write("-- Method C: Creating data using Python script\n\n")

    # 1. Patients
    f.write("-- Patients\n")
    for i in range(1, NUM_PATIENTS + 1):
        phone = f"050-{random.randint(1000000, 9999999)}"
        email = f"user{i}@clinic.com"
        address = f"{random.randint(1, 100)} Main St, City{random.randint(1, 50)}"
        f.write(f"INSERT INTO Patients VALUES ({i}, 'First{i}', 'Last{i}', '{random_date(1950, 2020)}', 'Other', '{phone}', '{email}', '{address}') ON CONFLICT DO NOTHING;\n")

    # 2. Doctors
    f.write("\n-- Doctors\n")
    specs = ['Cardiology', 'Pediatrics', 'Orthopedics', 'General']
    for i in range(101, 101 + NUM_DOCTORS):
        f.write(f"INSERT INTO Doctors VALUES ({i}, 'Dr_{i}', 'DocLast', '{random.choice(specs)}', '{random_date(2010, 2024)}') ON CONFLICT DO NOTHING;\n")

    # 2b. Doctor_Working_Hours
    f.write("\n-- Doctor_Working_Hours\n")
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
    for i in range(101, 101 + NUM_DOCTORS):
        num_shifts = random.randint(1, 3)
        selected_days = random.sample(days, num_shifts)
        for day in selected_days:
            # We don't insert Schedule_ID because it's SERIAL. We specify the columns.
            f.write(f"INSERT INTO Doctor_Working_Hours (License_Number, Day_Of_Week, Start_Time, End_Time) VALUES ({i}, '{day}', '08:00:00', '16:00:00') ON CONFLICT DO NOTHING;\n")

    # 3. Appointments
    f.write("\n-- Appointments\n")
    for i in range(5000, 5000 + NUM_APPOINTMENTS):
        p_id = random.randint(1, NUM_PATIENTS)
        d_id = random.randint(101, 101 + NUM_DOCTORS - 1)
        f.write(f"INSERT INTO Appointments VALUES ({i}, '{random_date(2024, 2025)}', '10:00:00', 'Completed', {p_id}, {d_id}) ON CONFLICT DO NOTHING;\n")

    # 4. Visits_Records (20,000 records)
    f.write("\n-- Visits_Records (20,000 records)\n")
    for i in range(1, NUM_VISITS + 1):
        app_id = 5000 + (i % NUM_APPOINTMENTS) # Links to existing appointments in cycles
        temp = round(random.uniform(36.0, 39.5), 1)
        bp = f"{random.randint(110, 140)}/{random.randint(70, 90)}"
        weight = round(random.uniform(50.0, 100.0), 1)
        pulse = random.randint(60, 100)
        
        f.write(f"INSERT INTO Visits_Records VALUES ({i}, 'Diagnosis_{i}', 'Notes_{i}', {temp}, '{bp}', {weight}, {pulse}, 'No', {app_id}) ON CONFLICT DO NOTHING;\n")

    # 5. Prescriptions
    f.write("\n-- Prescriptions\n")
    for i in range(1, NUM_PRESCRIPTIONS + 1):
        v_id = random.randint(1, NUM_VISITS)
        f.write(f"INSERT INTO Prescriptions VALUES ({i}, 'Medicine_{i}', '10mg', '{random_date(2024, 2025)}', 'Take daily', {v_id}) ON CONFLICT DO NOTHING;\n")

    # 6. Payments (20,000 records)
    f.write("\n-- Payments (20,000 records)\n")
    for i in range(1, NUM_PAYMENTS + 1):
        p_id = random.randint(1, NUM_PATIENTS)
        amount = round(random.uniform(50.0, 500.0), 2)
        card_last4 = f"{random.randint(1000, 9999)}"
        auth_code = f"AUTH{random.randint(10000, 99999)}"
        receipt_no = f"REC-{random.randint(100000, 999999)}"
        
        f.write(f"INSERT INTO Payments VALUES ({i}, {amount}, '{random_date(2024, 2025)}', 'Credit', '{card_last4}', '{auth_code}', '{receipt_no}', {p_id}) ON CONFLICT DO NOTHING;\n")

print("Done! insertTables.sql was created with 20,000+ records.")