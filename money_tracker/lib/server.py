from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

expenses = [
    {"date": "2024-11-25", "category": "Food", "cost": 200, "description": "Lunch"},
    {"date": "2024-11-25", "category": "Transport", "cost": 150, "description": "Bus ticket"},
    {"date": "2024-11-25", "category": "Entertainment", "cost": 300, "description": "Movie"},
    {"date": "2024-11-24", "category": "Food", "cost": 250, "description": "Dinner"},
    {"date": "2024-11-24", "category": "Transport", "cost": 100, "description": "Taxi"},
    {"date": "2024-11-24", "category": "Transport", "cost": 10, "description": "Bus"},
    {"date": "2024-11-24", "category": "Food", "cost": 200, "description": "Taco"},
    {"date": "2024-11-24", "category": "Food", "cost": 20, "description": "Burger"}
]

@app.route('/api/get-expenses', methods=['GET'])
def get_expense_summary():
    date_str = request.args.get('date', None)
    
    if date_str:
        try:
            selected_date = datetime.strptime(date_str, '%Y-%m-%d').date()
            filtered_expenses = [
                expense for expense in expenses if expense['date'] == date_str
            ]
        except ValueError:
            return jsonify({"error": "Invalid date format. Use YYYY-MM-DD."}), 400
    else:
        filtered_expenses = expenses

    category_data = {}
    total_cost = 0
    
    for expense in filtered_expenses:
        category = expense['category']
        cost = expense['cost']
        description = expense['description']
        
        if category not in category_data:
            category_data[category] = []
        
        category_data[category].append({
            "cost": cost,
            "description": description
        })
        
        total_cost += int(cost)

    response = {
        "categories": [
            {"category": category, "data": data} 
            for category, data in category_data.items()
        ],
        "total": total_cost
    }

    return jsonify(response)

@app.route('/api/post-expenses', methods=['POST'])
def add_expense():
    try:
        data = request.get_json()
        if not all(key in data for key in ('date', 'category', 'cost', 'description')):
            return jsonify({"error": "Invalid data format"}), 400

        expenses.append({
            "date": data["date"],
            "category": data["category"],
            "cost": int(data["cost"]),
            "description": data["description"],
        })

        return jsonify({"message": "Expense added successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
