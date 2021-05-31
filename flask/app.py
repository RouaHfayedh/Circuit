from flask import Flask, jsonify , request
from joblib import load
from datetime import datetime
import random

app = Flask(__name__)

classes = {
    '0' : 'train',
    '1' : 'louage',
    '2' : 'car'
}

city = {
    1 : [33.8933, 10.1029],
    2 : [36.8039, 10.169],
    3 : [35.5053, 11.0646],
    4 : [36.8333, 9.8333],
    5 : [33.924, 8.1312],
    6 : [35.8256, 10.6084]
}




def getCity(coord1, coord2):
    ville = {}
    for key, value in city.items():
        if value == coord1:
            
            ville['dep'] = key
        elif value == coord2:
            ville['arr'] = key
    return ville

def getAge():
    n = random.randint(22, 69)
    return n

def getGender():
    n = random.randint(0, 1)
    return n

# get current date and time
dat = datetime.today().strftime('%Y-%m-%d')
lst_date = dat.split('-')
day = int(lst_date[2])
month = int(lst_date[1])
year = int(lst_date[0])

now = datetime.now()
current_time = now.strftime("%H:%M:%S")
h = int(current_time.split(':')[0])

# laod model
model = load('predict.joblib')



@app.route('/', methods=['POST', 'GET'])
def home():
    if request.method == 'POST':
        data = request.form
        
        lat1 = float(data['lat1'])
        lan1 = float(data['lan1'])
        lat2 = float(data['lat2'])
        lan2 = float(data['lan2'])
        
        coord1 = [lat1, lan1]
        coord2 = [lat2, lan2]
        
        city = getCity(coord1, coord2)
        age = getAge()
        gender = getGender()
        print(city)

        input = [[]]
        input[0].append(gender)
        input[0].append(age)
        input[0].append(city['dep'])
        input[0].append(city['arr'])
        input[0].append(year)
        input[0].append(month)
        input[0].append(day)
        input[0].append(h)


        y = model.predict(input).tolist()
        result = classes[str(y[0])]
        return jsonify(result)
