import json, os.path, functions_framework
from flask import Flask, request, jsonify
from google.cloud import firestore

#initializing the firestore client with the project ID
db = firestore.Client(project="ashesi-social-connect")

app = Flask(__name__)

"""
    Users Resource
"""
# @app.route('/users/<string:user_id>', methods=['GET'])
def get_user_byID(user_id):
    users_data = db.collection('users').document(user_id)
    user = users_data.get()

    if user.exists:
        user_dict = user.to_dict()
        user_dict['id'] = user.id
        return jsonify(user_dict), 200
    return jsonify({'message': 'User ID not found'}), 404

# @app.route('/users', methods=['POST'])
def create_user():
    record = json.loads(request.data)

    users_data = db.collection('users')
    query_check = users_data.where('id', '==', record['id'])
    users = query_check.stream()

    for user in users:
        return jsonify({'message':f'User with id {record["id"]} already exists.'}), 400
    
    user_data = users_data.document()
    user_data.set(record)
    record['id'] = user_data.id

    return jsonify(record), 201