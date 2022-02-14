from joblib import load
import json


def handler(event, context):
    body = json.loads(event['body'])
    model = load('titanic_model.sav')
    sex = body['sex']
    pclass = body['pclass']
    X = [[pclass, int(sex != 'm'), int(sex == 'm')]]
    survived = model.predict(X)

    return {
        "statusCode": 200,
        "body": "not survived" if survived == 0 else "survived"
    }


