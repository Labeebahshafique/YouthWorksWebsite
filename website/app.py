from flask import Flask, request, jsonify
from flask_cors import CORS
import pyodbc

app = Flask(__name__)
CORS(app)

def get_db_connection():
  
    return pyodbc.connect('DRIVER={SQL Server};SERVER=laptop-psto9kpg;DATABASE=youth_workss;Trusted_Connection=yes;')

@app.route('/api/get_jobs', methods=['GET'])
def get_jobs():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        query = """
            SELECT J.JobID, J.Title, J.Location, J.Salary, J.Category, J.PostedDate, E.CompanyName, J.Details 
            FROM Job J
            JOIN Employer E ON J.EmployerID = E.EmployerID
            ORDER BY J.JobID DESC
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        
        jobs = []
        for r in rows:
            jobs.append({
                "id": r[0],
                "title": r[1],
                "location": r[2],
                "salary": r[3],
                "category": r[4],
                "postedDate": str(r[5]) if r[5] else "Not Dated",
                "company": r[6],
                "details": r[7] if r[7] else "No details provided."
            })
        conn.close()
        return jsonify(jobs)
    except Exception as e:
        print(f"Fetch Error: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/api/add_job', methods=['POST'])
def add_job():
    data = request.json
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
    
        query = "INSERT INTO Job (Title, Location, Salary, Category, EmployerID, Details) VALUES (?, ?, ?, ?, ?, ?)"
        cursor.execute(query, (data['title'], data['location'], data['salary'], data['category'], 1, data['details']))
        
        conn.commit()
        conn.close()
        return jsonify({"message": "Job Added Successfully"}), 201
    except Exception as e:
        print(f"Insert Error: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/api/delete_job/<int:id>', methods=['DELETE'])
def delete_job(id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM Job WHERE JobID = ?", (id,))
        conn.commit()
        conn.close()
        return jsonify({"message": "Deleted"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)