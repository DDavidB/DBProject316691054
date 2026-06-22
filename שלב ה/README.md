שלב ה - ממשק גרפי (Tkinter)

קבצים:
- `gui_app.py` : אפליקציית Tkinter לקישור לבסיס הנתונים וביצוע CRUD, שאילתות והפעלת פרוצדורות/פונקציות.
- `requirements.txt` : תלותיות 

הוראות הפעלה (Windows):
1. ליצור ולפעיל וירטואל אנווירונמנט (המלצה):
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```
2. להפעיל את מסד הנתונים ו/או ה-Flask API שלכם (הפרויקט כולל `server/app.py` ו-`docker-compose.yml`).
3. להפעיל את ה-GUI:
```powershell
python gui_app.py
```

מה האפליקציה עושה:
- מסך כניסה (ממשק קבלת פרטי חיבור DB).
- בחירה בטבלה והצגת רשומות (Treeview) עם החלפת מפתחות זרים לשמות אדם/רופא.
- CRUD: יצירה, עדכון (טען לפי מפתח), מחיקה ושאילת נתונים.
- הרצת 2 שאילתות מוכנות מקובץ `שלב ב/Queries.sql` (דוגמה: "High-risk patients", "No-show patients").
- קריאה להליך `proc_schedule_appointment` ופונקציה `fn_doctor_stats` (נדרשים הרשאות DB).

הוראות לצילומי מסך:
- הריצו את ה-GUI והוסיפו תיקיית `screenshots` עם תמונות של מסכי ה-Login, CRUD וטבלת השאילתות.

הגשה ב-GIT:
- צרו TAG שמייצג את השלב, לדוגמה `stage-E-gui`.

הערות:
- האפליקציה מבצעת פעולות ישירות מול PostgreSQL; ודאו שה-BD פעיל ושנתנו למשתמש הרשאות לקרוא/לכתוב ולהפעיל פרוצדורות.
