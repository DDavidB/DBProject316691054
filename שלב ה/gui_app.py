import os
import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import psycopg2
from psycopg2.extras import RealDictCursor
from datetime import datetime
from dotenv import load_dotenv

TABLES = [
    'Patients','Doctors','Doctor_Working_Hours','Appointments','Visits_Records','Prescriptions','Payments'
]

class DBClient:
    def __init__(self, conn_params):
        self.conn_params = conn_params
        self.conn = None

    def connect(self):
        if self.conn:
            self.conn.close()
        self.conn = psycopg2.connect(**self.conn_params)

    def fetch_all(self, query, params=None):
        with self.conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params or ())
            return cur.fetchall()

    def fetch_one(self, query, params=None):
        with self.conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params or ())
            row = cur.fetchone()
            return row

    def execute(self, query, params=None):
        with self.conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params or ())
            try:
                res = cur.fetchone()
            except Exception:
                res = None
            self.conn.commit()
            return res

    def callproc(self, name, args):
        with self.conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.callproc(name, args)
            try:
                rows = cur.fetchall()
            except Exception:
                rows = None
            self.conn.commit()
            return rows


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('ClinicaDB - Stage E GUI')
        self.geometry('1100x650')
        self.db = None
        # load .env from repository root (two levels up from this file)
        try:
            repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
            load_dotenv(os.path.join(repo_root, '.env'))
        except Exception:
            # best-effort; if loading fails continue with defaults
            pass

        self.create_login()

    def create_login(self):
        frm = ttk.Frame(self)
        frm.pack(padx=10, pady=10, anchor='nw')
        ttk.Label(frm, text='Host').grid(row=0, column=0)
        self.host = ttk.Entry(frm)
        self.host.insert(0, os.getenv('DB_HOST', 'localhost'))
        self.host.grid(row=0, column=1)
        ttk.Label(frm, text='Port').grid(row=0, column=2)
        self.port = ttk.Entry(frm)
        self.port.insert(0, os.getenv('DB_PORT', '5432'))
        self.port.grid(row=0, column=3)
        ttk.Label(frm, text='DB').grid(row=1, column=0)
        self.dbname = ttk.Entry(frm)
        self.dbname.insert(0, os.getenv('DB_NAME_SECRET', 'ClinicaDB'))
        self.dbname.grid(row=1, column=1)
        ttk.Label(frm, text='User').grid(row=1, column=2)
        self.user = ttk.Entry(frm)
        self.user.insert(0, os.getenv('DB_USER_SECRET', 'postgres'))
        self.user.grid(row=1, column=3)
        ttk.Label(frm, text='Password').grid(row=2, column=0)
        self.password = ttk.Entry(frm, show='*')
        self.password.grid(row=2, column=1)
        ttk.Button(frm, text='Connect', command=self.do_connect).grid(row=2, column=3)

    def do_connect(self):
        params = {
            'host': self.host.get(), 'port': self.port.get(), 'dbname': self.dbname.get(),
            'user': self.user.get(), 'password': self.password.get()
        }
        try:
            self.db = DBClient(params)
            self.db.connect()
        except Exception as e:
            messagebox.showerror('Connection failed', str(e))
            return
        self.build_main()

    def build_main(self):
        for w in self.winfo_children(): w.destroy()
        top = ttk.Frame(self)
        top.pack(fill='x', padx=8, pady=8)
        ttk.Label(top, text='Select Table:').pack(side='left')
        self.table_var = tk.StringVar(value=TABLES[0])
        self.table_cb = ttk.Combobox(top, values=TABLES, textvariable=self.table_var, state='readonly')
        self.table_cb.pack(side='left', padx=4)
        ttk.Button(top, text='Load', command=self.load_table).pack(side='left', padx=4)
        ttk.Button(top, text='Refresh', command=self.load_table).pack(side='left', padx=4)

        main = ttk.Panedwindow(self, orient='horizontal')
        main.pack(fill='both', expand=True, padx=8, pady=8)

        # Left: records
        left = ttk.Frame(main, width=650)
        main.add(left)
        self.tree = ttk.Treeview(left, columns=('c',), show='headings')
        self.tree.pack(fill='both', expand=True)
        self.tree.bind('<Double-1>', lambda e: self.on_select())

        btns = ttk.Frame(left)
        btns.pack(fill='x')
        ttk.Button(btns, text='Create', command=self.create_record).pack(side='left')
        ttk.Button(btns, text='Load by PK', command=self.load_by_pk).pack(side='left')
        ttk.Button(btns, text='Update', command=self.update_record).pack(side='left')
        ttk.Button(btns, text='Delete', command=self.delete_record).pack(side='left')

        # Right: queries and procedures
        right = ttk.Frame(main, width=420)
        main.add(right)
        ttk.Label(right, text='Queries & Procedures').pack()
        ttk.Button(right, text='High-risk patients (Query 2)', command=self.run_query_high_risk).pack(fill='x', pady=4)
        ttk.Button(right, text='No-show patients (Query 7)', command=self.run_query_noshow).pack(fill='x', pady=4)
        ttk.Separator(right).pack(fill='x', pady=6)
        ttk.Button(right, text='fn_doctor_stats (enter license)', command=self.call_fn_doctor_stats).pack(fill='x', pady=4)
        ttk.Button(right, text='proc_schedule_appointment', command=self.call_proc_schedule).pack(fill='x', pady=4)
        self.out = tk.Text(right, height=20)
        self.out.pack(fill='both', expand=True, pady=6)

        self.load_table()

    def load_table(self):
        tbl = self.table_var.get()
        # fetch columns
        try:
            cols = self.db.fetch_all(f"SELECT column_name FROM information_schema.columns WHERE table_name = %s ORDER BY ordinal_position", (tbl,))
            cols = [c['column_name'] for c in cols]
            rows = self.db.fetch_all(f"SELECT * FROM {tbl} ORDER BY 1 LIMIT 200")
        except Exception as e:
            messagebox.showerror('Error', str(e))
            return
        # set up tree
        self.tree.delete(*self.tree.get_children())
        self.tree['columns'] = cols
        for c in cols:
            self.tree.heading(c, text=c)
            self.tree.column(c, width=100)
        for r in rows:
            display = [self.fk_display(tbl, c, r.get(c)) for c in cols]
            self.tree.insert('', 'end', values=display)

    def fk_display(self, table, col, val):
        if val is None:
            return ''
        # common FK patterns
        try:
            if col in ('Patient_ID',) and table != 'Patients':
                row = self.db.fetch_one('SELECT First_Name, Last_Name FROM Patients WHERE Patient_ID = %s', (val,))
                return f"{row['first_name']} {row['last_name']}" if row else str(val)
            if col in ('License_Number',) and table != 'Doctors':
                row = self.db.fetch_one('SELECT First_Name, Last_Name FROM Doctors WHERE License_Number = %s', (val,))
                return f"{row['first_name']} {row['last_name']}" if row else str(val)
            if col == 'Appointment_ID' and table != 'Appointments':
                row = self.db.fetch_one('SELECT Appointment_Date, Start_Time FROM Appointments WHERE Appointment_ID = %s', (val,))
                if row:
                    return f"{row['appointment_date']} {row['start_time']}"
        except Exception:
            return str(val)
        return str(val)

    def on_select(self):
        item = self.tree.focus()
        if not item: return
        vals = self.tree.item(item,'values')
        messagebox.showinfo('Row', str(vals))

    def prompt_fields(self, cols, defaults=None):
        d = defaults or {}
        top = tk.Toplevel(self)
        top.title('Record')
        entries = {}
        for i,c in enumerate(cols):
            ttk.Label(top, text=c).grid(row=i, column=0, sticky='w')
            e = ttk.Entry(top)
            e.grid(row=i, column=1, sticky='we')
            if c in d and d[c] is not None:
                e.insert(0, str(d[c]))
            entries[c]=e
        def on_ok():
            res = {c: entries[c].get() or None for c in cols}
            top.result = res
            top.destroy()
        ttk.Button(top, text='OK', command=on_ok).grid(row=len(cols), column=0)
        ttk.Button(top, text='Cancel', command=top.destroy).grid(row=len(cols), column=1)
        self.wait_window(top)
        return getattr(top,'result', None)

    def create_record(self):
        tbl = self.table_var.get()
        cols = [c['column_name'] for c in self.db.fetch_all("SELECT column_name FROM information_schema.columns WHERE table_name = %s ORDER BY ordinal_position", (tbl,))]
        data = self.prompt_fields(cols)
        if not data: return
        keys = ','.join(cols)
        vals = ','.join(['%s']*len(cols))
        params = [None if data[c]=='' else data[c] for c in cols]
        try:
            self.db.execute(f"INSERT INTO {tbl}({keys}) VALUES ({vals})", params)
            messagebox.showinfo('OK','Inserted')
            self.load_table()
        except Exception as e:
            messagebox.showerror('Error', str(e))

    def load_by_pk(self):
        tbl = self.table_var.get()
        pk = simpledialog.askstring('Primary Key','Enter primary key value (ID)')
        if not pk: return
        row = self.db.fetch_one(f"SELECT * FROM {tbl} WHERE " + self.get_pk_where(tbl), (pk,))
        if not row:
            messagebox.showinfo('Not found','No row')
            return
        data = self.prompt_fields(list(row.keys()), row)
        if data:
            messagebox.showinfo('Loaded','You may now click Update to save changes')
            self._loaded_row = (tbl, row, data)

    def get_pk_where(self, tbl):
        # naive: assume first column is PK
        col = self.db.fetch_one("SELECT column_name FROM information_schema.columns WHERE table_name = %s ORDER BY ordinal_position LIMIT 1", (tbl,))
        return f"{col['column_name']} = %s"

    def update_record(self):
        if not hasattr(self,'_loaded_row'):
            messagebox.showwarning('Error','Load row by PK first')
            return
        tbl, orig, data = self._loaded_row
        cols = list(orig.keys())
        pkcol = cols[0]
        set_clause = ','.join([f"{c} = %s" for c in cols[1:]])
        params = [data[c] for c in cols[1:]] + [orig[pkcol]]
        try:
            self.db.execute(f"UPDATE {tbl} SET {set_clause} WHERE {pkcol} = %s", params)
            messagebox.showinfo('OK','Updated')
            self.load_table()
        except Exception as e:
            messagebox.showerror('Error', str(e))

    def delete_record(self):
        item = self.tree.focus()
        if not item:
            messagebox.showwarning('Select','Select a row')
            return
        vals = self.tree.item(item,'values')
        pk = vals[0]
        tbl = self.table_var.get()
        if not messagebox.askyesno('Confirm',f'Delete {pk}?'):
            return
        try:
            self.db.execute(f"DELETE FROM {tbl} WHERE " + self.get_pk_where(tbl), (pk,))
            messagebox.showinfo('OK','Deleted')
            self.load_table()
        except Exception as e:
            messagebox.showerror('Error', str(e))

    # Queries from Stage B: Query 2 and Query 7
    def run_query_high_risk(self):
        q = """
SELECT p.Patient_ID, p.First_Name || ' ' || p.Last_Name AS Patient_Name, p.Phone, v.Temperature, v.Blood_Pressure, v.Diagnosis
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
WHERE v.Temperature > 38.0
  AND EXTRACT(YEAR FROM a.Appointment_Date) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND EXISTS (SELECT 1 FROM Prescriptions pr WHERE pr.Visit_ID = v.Visit_ID AND pr.Medication_Name LIKE '%Amlo%')
LIMIT 200
"""
        try:
            rows = self.db.fetch_all(q)
            self.out.delete('1.0','end')
            for r in rows:
                self.out.insert('end', str(r) + '\n')
        except Exception as e:
            messagebox.showerror('Error', str(e))

    def run_query_noshow(self):
        q = """
SELECT p.Patient_ID, p.First_Name || ' ' || p.Last_Name AS Patient_Name, p.Phone, p.Email, a.Appointment_Date, a.Status
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
LEFT JOIN Visits_Records v ON a.Appointment_ID = v.Appointment_ID
WHERE v.Visit_ID IS NULL AND a.Appointment_Date < CURRENT_DATE
ORDER BY a.Appointment_Date DESC LIMIT 200
"""
        try:
            rows = self.db.fetch_all(q)
            self.out.delete('1.0','end')
            for r in rows:
                self.out.insert('end', str(r) + '\n')
        except Exception as e:
            messagebox.showerror('Error', str(e))

    def call_fn_doctor_stats(self):
        lic = simpledialog.askinteger('License','Enter doctor license number')
        if lic is None: return
        try:
            # fn_doctor_stats returns a refcursor in DB; we'll call via SELECT fn_doctor_stats(%s)
            rows = self.db.fetch_all('SELECT * FROM fn_doctor_stats(%s)', (lic,))
            self.out.delete('1.0','end')
            for r in rows:
                self.out.insert('end', str(r) + '\n')
        except Exception as e:
            messagebox.showerror('Error', str(e))

    def call_proc_schedule(self):
        data_ok = False
        try:
            p_patient = simpledialog.askinteger('Patient','Patient_ID')
            p_license = simpledialog.askinteger('License','License_Number')
            p_date = simpledialog.askstring('Date','Appointment date YYYY-MM-DD')
            p_time = simpledialog.askstring('Time','Start time HH:MM:SS')
            if None in (p_patient,p_license,p_date,p_time):
                return
            # call stored procedure
            with self.db.conn.cursor() as cur:
                cur.execute('CALL proc_schedule_appointment(%s,%s,%s,%s)', (p_patient,p_license,p_date,p_time))
                self.db.conn.commit()
            messagebox.showinfo('OK','Procedure executed (check DB)')
        except Exception as e:
            messagebox.showerror('Error', str(e))

if __name__ == '__main__':
    app = App()
    app.mainloop()
