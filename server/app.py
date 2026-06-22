"""
ClinicaDB — Flask Backend Server
REST API for managing the clinic database.
"""
from flask import Flask, request, jsonify, render_template, redirect
from flask_cors import CORS
import db
import json
import decimal
import datetime

app = Flask(__name__, static_folder='static', template_folder='templates')
CORS(app)


# --- Custom JSON encoder for Decimal and Date types ---
class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, decimal.Decimal):
            return float(obj)
        if isinstance(obj, (datetime.date, datetime.datetime)):
            return obj.isoformat()
        if isinstance(obj, datetime.time):
            return obj.isoformat()
        if isinstance(obj, datetime.timedelta):
            total_seconds = int(obj.total_seconds())
            hours = total_seconds // 3600
            minutes = (total_seconds % 3600) // 60
            return f"{hours:02d}:{minutes:02d}"
        return super().default(obj)


app.json_encoder = CustomJSONEncoder


def jsonify_custom(data, status=200):
    """Custom jsonify that handles Decimal/Date types."""
    return app.response_class(
        response=json.dumps(data, cls=CustomJSONEncoder, ensure_ascii=False),
        status=status,
        mimetype='application/json'
    )


# ========================================
#  FRONTEND — Serve the SPA
# ========================================

@app.route('/')
def index():
    return redirect('/screen')


@app.route('/screen')
def screen():
    return render_template('screen.html')


@app.route('/billing')
def billing():
    return render_template('billing.html')


# ========================================
#  API — PATIENTS
# ========================================

@app.route('/api/patients', methods=['GET'])
def get_patients():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    if search:
        rows = db.fetch_all(
            """SELECT * FROM Patients 
               WHERE First_Name ILIKE %s OR Last_Name ILIKE %s 
                     OR Email ILIKE %s OR Phone ILIKE %s
               ORDER BY Patient_ID LIMIT %s OFFSET %s""",
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            """SELECT COUNT(*) as total FROM Patients 
               WHERE First_Name ILIKE %s OR Last_Name ILIKE %s 
                     OR Email ILIKE %s OR Phone ILIKE %s""",
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            "SELECT * FROM Patients ORDER BY Patient_ID LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Patients")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/patients/<int:patient_id>', methods=['GET'])
def get_patient(patient_id):
    row = db.fetch_one("SELECT * FROM Patients WHERE Patient_ID = %s", (patient_id,))
    if not row:
        return jsonify_custom({'error': 'Patient not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/patients', methods=['POST'])
def create_patient():
    data = request.json
    row = db.execute(
        """INSERT INTO Patients (Patient_ID, First_Name, Last_Name, Birth_Date, Gender, Phone, Email, Address)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING *""",
        (data['patient_id'], data['first_name'], data['last_name'],
         data.get('birth_date'), data.get('gender'), data.get('phone'),
         data.get('email'), data.get('address'))
    )
    return jsonify_custom(row, 201)


@app.route('/api/patients/<int:patient_id>', methods=['PUT'])
def update_patient(patient_id):
    data = request.json
    row = db.execute(
        """UPDATE Patients SET First_Name=%s, Last_Name=%s, Birth_Date=%s, 
           Gender=%s, Phone=%s, Email=%s, Address=%s
           WHERE Patient_ID=%s RETURNING *""",
        (data['first_name'], data['last_name'], data.get('birth_date'),
         data.get('gender'), data.get('phone'), data.get('email'),
         data.get('address'), patient_id)
    )
    if not row:
        return jsonify_custom({'error': 'Patient not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/patients/<int:patient_id>', methods=['DELETE'])
def delete_patient(patient_id):
    db.execute("DELETE FROM Patients WHERE Patient_ID = %s", (patient_id,))
    return jsonify_custom({'message': 'Patient deleted'})


# ========================================
#  API — DOCTORS
# ========================================

@app.route('/api/doctors', methods=['GET'])
def get_doctors():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    if search:
        rows = db.fetch_all(
            """SELECT * FROM Doctors 
               WHERE First_Name ILIKE %s OR Last_Name ILIKE %s OR Specialization ILIKE %s
               ORDER BY License_Number LIMIT %s OFFSET %s""",
            (f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            """SELECT COUNT(*) as total FROM Doctors 
               WHERE First_Name ILIKE %s OR Last_Name ILIKE %s OR Specialization ILIKE %s""",
            (f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            "SELECT * FROM Doctors ORDER BY License_Number LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Doctors")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/doctors/<int:license_number>', methods=['GET'])
def get_doctor(license_number):
    row = db.fetch_one("SELECT * FROM Doctors WHERE License_Number = %s", (license_number,))
    if not row:
        return jsonify_custom({'error': 'Doctor not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/doctors', methods=['POST'])
def create_doctor():
    data = request.json
    row = db.execute(
        """INSERT INTO Doctors (License_Number, First_Name, Last_Name, Specialization, Hire_Date)
           VALUES (%s, %s, %s, %s, %s) RETURNING *""",
        (data['license_number'], data['first_name'], data['last_name'],
         data.get('specialization'), data.get('hire_date'))
    )
    return jsonify_custom(row, 201)


@app.route('/api/doctors/<int:license_number>', methods=['PUT'])
def update_doctor(license_number):
    data = request.json
    row = db.execute(
        """UPDATE Doctors SET First_Name=%s, Last_Name=%s, Specialization=%s, Hire_Date=%s
           WHERE License_Number=%s RETURNING *""",
        (data['first_name'], data['last_name'], data.get('specialization'),
         data.get('hire_date'), license_number)
    )
    if not row:
        return jsonify_custom({'error': 'Doctor not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/doctors/<int:license_number>', methods=['DELETE'])
def delete_doctor(license_number):
    db.execute("DELETE FROM Doctors WHERE License_Number = %s", (license_number,))
    return jsonify_custom({'message': 'Doctor deleted'})


# ========================================
#  API — DOCTOR WORKING HOURS
# ========================================

@app.route('/api/working-hours', methods=['GET'])
def get_working_hours():
    license_number = request.args.get('license_number')
    if license_number:
        rows = db.fetch_all(
            """SELECT dwh.*, d.First_Name, d.Last_Name 
               FROM Doctor_Working_Hours dwh 
               JOIN Doctors d ON dwh.License_Number = d.License_Number
               WHERE dwh.License_Number = %s ORDER BY dwh.Schedule_ID""",
            (license_number,)
        )
    else:
        rows = db.fetch_all(
            """SELECT dwh.*, d.First_Name, d.Last_Name 
               FROM Doctor_Working_Hours dwh 
               JOIN Doctors d ON dwh.License_Number = d.License_Number
               ORDER BY dwh.Schedule_ID"""
        )
    return jsonify_custom({'data': rows, 'total': len(rows)})


@app.route('/api/working-hours', methods=['POST'])
def create_working_hours():
    data = request.json
    row = db.execute(
        """INSERT INTO Doctor_Working_Hours (License_Number, Day_Of_Week, Start_Time, End_Time)
           VALUES (%s, %s, %s, %s) RETURNING *""",
        (data['license_number'], data['day_of_week'], data['start_time'], data['end_time'])
    )
    return jsonify_custom(row, 201)


@app.route('/api/working-hours/<int:schedule_id>', methods=['DELETE'])
def delete_working_hours(schedule_id):
    db.execute("DELETE FROM Doctor_Working_Hours WHERE Schedule_ID = %s", (schedule_id,))
    return jsonify_custom({'message': 'Working hours deleted'})


# ========================================
#  API — APPOINTMENTS
# ========================================

@app.route('/api/appointments', methods=['GET'])
def get_appointments():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    base_query = """
        SELECT a.*, 
               p.First_Name as patient_first_name, p.Last_Name as patient_last_name,
               d.First_Name as doctor_first_name, d.Last_Name as doctor_last_name
        FROM Appointments a
        LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID
        LEFT JOIN Doctors d ON a.License_Number = d.License_Number
    """

    if search:
        where = """ WHERE p.First_Name ILIKE %s OR p.Last_Name ILIKE %s 
                          OR d.First_Name ILIKE %s OR d.Last_Name ILIKE %s
                          OR a.Status ILIKE %s"""
        rows = db.fetch_all(
            base_query + where + " ORDER BY a.Appointment_Date DESC, a.Start_Time LIMIT %s OFFSET %s",
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            "SELECT COUNT(*) as total FROM Appointments a LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID LEFT JOIN Doctors d ON a.License_Number = d.License_Number" + where,
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            base_query + " ORDER BY a.Appointment_Date DESC, a.Start_Time LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Appointments")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/appointments/<int:appointment_id>', methods=['GET'])
def get_appointment(appointment_id):
    row = db.fetch_one(
        """SELECT a.*, 
                  p.First_Name as patient_first_name, p.Last_Name as patient_last_name,
                  d.First_Name as doctor_first_name, d.Last_Name as doctor_last_name
           FROM Appointments a
           LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID
           LEFT JOIN Doctors d ON a.License_Number = d.License_Number
           WHERE a.Appointment_ID = %s""",
        (appointment_id,)
    )
    if not row:
        return jsonify_custom({'error': 'Appointment not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/appointments', methods=['POST'])
def create_appointment():
    data = request.json
    row = db.execute(
        """INSERT INTO Appointments (Appointment_ID, Appointment_Date, Start_Time, Status, Patient_ID, License_Number)
           VALUES (%s, %s, %s, %s, %s, %s) RETURNING *""",
        (data['appointment_id'], data['appointment_date'], data['start_time'],
         data.get('status', 'Scheduled'), data['patient_id'], data['license_number'])
    )
    return jsonify_custom(row, 201)


@app.route('/api/appointments/<int:appointment_id>', methods=['PUT'])
def update_appointment(appointment_id):
    data = request.json
    row = db.execute(
        """UPDATE Appointments SET Appointment_Date=%s, Start_Time=%s, Status=%s, 
           Patient_ID=%s, License_Number=%s
           WHERE Appointment_ID=%s RETURNING *""",
        (data['appointment_date'], data['start_time'], data.get('status'),
         data['patient_id'], data['license_number'], appointment_id)
    )
    if not row:
        return jsonify_custom({'error': 'Appointment not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/appointments/<int:appointment_id>', methods=['DELETE'])
def delete_appointment(appointment_id):
    db.execute("DELETE FROM Appointments WHERE Appointment_ID = %s", (appointment_id,))
    return jsonify_custom({'message': 'Appointment deleted'})


# ========================================
#  API — VISITS RECORDS
# ========================================

@app.route('/api/visits', methods=['GET'])
def get_visits():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    base_query = """
        SELECT v.*, a.Appointment_Date, a.Patient_ID, a.License_Number,
               p.First_Name as patient_first_name, p.Last_Name as patient_last_name,
               d.First_Name as doctor_first_name, d.Last_Name as doctor_last_name
        FROM Visits_Records v
        LEFT JOIN Appointments a ON v.Appointment_ID = a.Appointment_ID
        LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID
        LEFT JOIN Doctors d ON a.License_Number = d.License_Number
    """

    if search:
        where = " WHERE v.Diagnosis ILIKE %s OR p.First_Name ILIKE %s OR p.Last_Name ILIKE %s"
        rows = db.fetch_all(
            base_query + where + " ORDER BY v.Visit_ID DESC LIMIT %s OFFSET %s",
            (f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            "SELECT COUNT(*) as total FROM Visits_Records v LEFT JOIN Appointments a ON v.Appointment_ID = a.Appointment_ID LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID" + where,
            (f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            base_query + " ORDER BY v.Visit_ID DESC LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Visits_Records")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/visits/<int:visit_id>', methods=['GET'])
def get_visit(visit_id):
    row = db.fetch_one("SELECT * FROM Visits_Records WHERE Visit_ID = %s", (visit_id,))
    if not row:
        return jsonify_custom({'error': 'Visit not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/visits', methods=['POST'])
def create_visit():
    data = request.json
    row = db.execute(
        """INSERT INTO Visits_Records (Visit_ID, Diagnosis, Doctor_Notes, Temperature, 
           Blood_Pressure, Weight, Pulse, Follow_Up_Needed, Appointment_ID)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING *""",
        (data['visit_id'], data.get('diagnosis'), data.get('doctor_notes'),
         data.get('temperature'), data.get('blood_pressure'), data.get('weight'),
         data.get('pulse'), data.get('follow_up_needed'), data['appointment_id'])
    )
    return jsonify_custom(row, 201)


@app.route('/api/visits/<int:visit_id>', methods=['PUT'])
def update_visit(visit_id):
    data = request.json
    row = db.execute(
        """UPDATE Visits_Records SET Diagnosis=%s, Doctor_Notes=%s, Temperature=%s,
           Blood_Pressure=%s, Weight=%s, Pulse=%s, Follow_Up_Needed=%s, Appointment_ID=%s
           WHERE Visit_ID=%s RETURNING *""",
        (data.get('diagnosis'), data.get('doctor_notes'), data.get('temperature'),
         data.get('blood_pressure'), data.get('weight'), data.get('pulse'),
         data.get('follow_up_needed'), data['appointment_id'], visit_id)
    )
    if not row:
        return jsonify_custom({'error': 'Visit not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/visits/<int:visit_id>', methods=['DELETE'])
def delete_visit(visit_id):
    db.execute("DELETE FROM Visits_Records WHERE Visit_ID = %s", (visit_id,))
    return jsonify_custom({'message': 'Visit deleted'})


# ========================================
#  API — PRESCRIPTIONS
# ========================================

@app.route('/api/prescriptions', methods=['GET'])
def get_prescriptions():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    base_query = """
        SELECT pr.*, v.Diagnosis, a.Patient_ID,
               p.First_Name as patient_first_name, p.Last_Name as patient_last_name
        FROM Prescriptions pr
        LEFT JOIN Visits_Records v ON pr.Visit_ID = v.Visit_ID
        LEFT JOIN Appointments a ON v.Appointment_ID = a.Appointment_ID
        LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID
    """

    if search:
        where = " WHERE pr.Medication_Name ILIKE %s OR p.First_Name ILIKE %s OR p.Last_Name ILIKE %s"
        rows = db.fetch_all(
            base_query + where + " ORDER BY pr.Issue_Date DESC LIMIT %s OFFSET %s",
            (f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            "SELECT COUNT(*) as total FROM Prescriptions pr LEFT JOIN Visits_Records v ON pr.Visit_ID = v.Visit_ID LEFT JOIN Appointments a ON v.Appointment_ID = a.Appointment_ID LEFT JOIN Patients p ON a.Patient_ID = p.Patient_ID" + where,
            (f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            base_query + " ORDER BY pr.Issue_Date DESC LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Prescriptions")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/prescriptions/<int:prescription_id>', methods=['GET'])
def get_prescription(prescription_id):
    row = db.fetch_one("SELECT * FROM Prescriptions WHERE Prescription_ID = %s", (prescription_id,))
    if not row:
        return jsonify_custom({'error': 'Prescription not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/prescriptions', methods=['POST'])
def create_prescription():
    data = request.json
    row = db.execute(
        """INSERT INTO Prescriptions (Prescription_ID, Medication_Name, Dosage, Issue_Date, Notes, Visit_ID)
           VALUES (%s, %s, %s, %s, %s, %s) RETURNING *""",
        (data['prescription_id'], data['medication_name'], data.get('dosage'),
         data.get('issue_date'), data.get('notes'), data['visit_id'])
    )
    return jsonify_custom(row, 201)


@app.route('/api/prescriptions/<int:prescription_id>', methods=['PUT'])
def update_prescription(prescription_id):
    data = request.json
    row = db.execute(
        """UPDATE Prescriptions SET Medication_Name=%s, Dosage=%s, Issue_Date=%s, Notes=%s, Visit_ID=%s
           WHERE Prescription_ID=%s RETURNING *""",
        (data['medication_name'], data.get('dosage'), data.get('issue_date'),
         data.get('notes'), data['visit_id'], prescription_id)
    )
    if not row:
        return jsonify_custom({'error': 'Prescription not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/prescriptions/<int:prescription_id>', methods=['DELETE'])
def delete_prescription(prescription_id):
    db.execute("DELETE FROM Prescriptions WHERE Prescription_ID = %s", (prescription_id,))
    return jsonify_custom({'message': 'Prescription deleted'})


# ========================================
#  API — PAYMENTS
# ========================================

@app.route('/api/payments', methods=['GET'])
def get_payments():
    search = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    offset = (page - 1) * limit

    base_query = """
        SELECT pay.*, p.First_Name as patient_first_name, p.Last_Name as patient_last_name
        FROM Payments pay
        LEFT JOIN Patients p ON pay.Patient_ID = p.Patient_ID
    """

    if search:
        where = """ WHERE p.First_Name ILIKE %s OR p.Last_Name ILIKE %s 
                          OR pay.Payment_Method ILIKE %s OR pay.ReceiptNo ILIKE %s"""
        rows = db.fetch_all(
            base_query + where + " ORDER BY pay.Payment_Date DESC LIMIT %s OFFSET %s",
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%', limit, offset)
        )
        count_row = db.fetch_one(
            "SELECT COUNT(*) as total FROM Payments pay LEFT JOIN Patients p ON pay.Patient_ID = p.Patient_ID" + where,
            (f'%{search}%', f'%{search}%', f'%{search}%', f'%{search}%')
        )
    else:
        rows = db.fetch_all(
            base_query + " ORDER BY pay.Payment_Date DESC LIMIT %s OFFSET %s",
            (limit, offset)
        )
        count_row = db.fetch_one("SELECT COUNT(*) as total FROM Payments")

    return jsonify_custom({
        'data': rows,
        'total': count_row['total'] if count_row else 0,
        'page': page,
        'limit': limit
    })


@app.route('/api/payments/<int:payment_id>', methods=['GET'])
def get_payment(payment_id):
    row = db.fetch_one("SELECT * FROM Payments WHERE Payment_ID = %s", (payment_id,))
    if not row:
        return jsonify_custom({'error': 'Payment not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/payments', methods=['POST'])
def create_payment():
    data = request.json
    row = db.execute(
        """INSERT INTO Payments (Payment_ID, Amount, Payment_Date, Payment_Method, CardLast4, AuthCode, ReceiptNo, Patient_ID)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING *""",
        (data['payment_id'], data['amount'], data.get('payment_date'),
         data.get('payment_method'), data.get('cardlast4'), data.get('authcode'),
         data.get('receiptno'), data['patient_id'])
    )
    return jsonify_custom(row, 201)


@app.route('/api/payments/<int:payment_id>', methods=['PUT'])
def update_payment(payment_id):
    data = request.json
    row = db.execute(
        """UPDATE Payments SET Amount=%s, Payment_Date=%s, Payment_Method=%s, 
           CardLast4=%s, AuthCode=%s, ReceiptNo=%s, Patient_ID=%s
           WHERE Payment_ID=%s RETURNING *""",
        (data['amount'], data.get('payment_date'), data.get('payment_method'),
         data.get('cardlast4'), data.get('authcode'), data.get('receiptno'),
         data['patient_id'], payment_id)
    )
    if not row:
        return jsonify_custom({'error': 'Payment not found'}, 404)
    return jsonify_custom(row)


@app.route('/api/payments/<int:payment_id>', methods=['DELETE'])
def delete_payment(payment_id):
    db.execute("DELETE FROM Payments WHERE Payment_ID = %s", (payment_id,))
    return jsonify_custom({'message': 'Payment deleted'})


# ========================================
#  API — DASHBOARD STATS
# ========================================

@app.route('/api/stats', methods=['GET'])
def get_stats():
    patients = db.fetch_one("SELECT COUNT(*) as total FROM Patients")
    doctors = db.fetch_one("SELECT COUNT(*) as total FROM Doctors")
    appointments = db.fetch_one("SELECT COUNT(*) as total FROM Appointments")
    today_appointments = db.fetch_one(
        "SELECT COUNT(*) as total FROM Appointments WHERE Appointment_Date = CURRENT_DATE"
    )
    visits = db.fetch_one("SELECT COUNT(*) as total FROM Visits_Records")
    prescriptions = db.fetch_one("SELECT COUNT(*) as total FROM Prescriptions")
    payments = db.fetch_one("SELECT COUNT(*) as total FROM Payments")
    total_revenue = db.fetch_one("SELECT COALESCE(SUM(Amount), 0) as total FROM Payments")

    return jsonify_custom({
        'patients': patients['total'],
        'doctors': doctors['total'],
        'appointments': appointments['total'],
        'today_appointments': today_appointments['total'],
        'visits': visits['total'],
        'prescriptions': prescriptions['total'],
        'payments': payments['total'],
        'total_revenue': total_revenue['total']
    })


# ========================================
#  MAIN
# ========================================

if __name__ == '__main__':
    print("\n" + "=" * 50)
    print("  ClinicaDB — Clinic Management System")
    print("  Open: http://localhost:3000")
    print("=" * 50 + "\n")
    app.run(host='0.0.0.0', port=3000, debug=True)
