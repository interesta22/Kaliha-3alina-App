from flask import Flask, request, jsonify
import json

app = Flask(__name__)

# تحميل بيانات المواصلات
with open('lib/core/assets/jsons/mwasalat_egypt_mock.json', 'r', encoding='utf-8') as f:
    routes = json.load(f)

# دالة تفهم السؤال وتستخرج "من" و"إلى"
def extract_places(user_input):
    user_input = user_input.lower()
    from_place = None
    to_place = None

    for route in routes:
        if route["from"] in user_input:
            from_place = route["from"]
        if route["to"] in user_input:
            to_place = route["to"]

    return from_place, to_place

# نقطة البداية
@app.route('/ask', methods=['POST'])
def ask():
    data = request.get_json()
    question = data.get("question", "")
    
    from_place, to_place = extract_places(question)

    if from_place and to_place:
        for route in routes:
            if route["from"] == from_place and route["to"] == to_place:
                method = route["method"]
                price = route["price"]
                response = f"بص يا باشا، تركب {method} من {from_place} لحد {to_place} والمشوار كله هيكلفك حوالي {price} جنيه كده."
                return jsonify({"answer": response})
        return jsonify({"answer": "معلش، لسه مش عارف أوصل الطريق ده بالمعلومات اللي عندي."})
    else:
        return jsonify({"answer": "ممكن توضّحلي رايح منين لفين؟"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

