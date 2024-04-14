from birdnetlib import Recording
from birdnetlib.analyzer import Analyzer
from datetime import datetime
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

@app.route('/call_function', methods=['POST'])
def call_function():
    data = request.get_json()
    filename = data.get('filename')
    result = predict_bird_sound(filename)
    return jsonify({'result': result})

def predict_bird_sound(filename):
    # Perform bird sound recognition using birdnetlib
    analyzer = Analyzer()

    recording = Recording(
        analyzer,
        filename,
        lat=35.4244,
        lon=-120.7463,
        date=datetime(year=2022, month=5, day=10), # use date or week_48
        min_conf=0.25,
    )

    recording.analyze()
    guess = (recording.detections)
    print(guess)
    return guess

if __name__ == '__main__':
    app.run(debug=True)