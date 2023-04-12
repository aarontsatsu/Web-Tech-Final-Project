import json, os.path, functions_framework
from flask import Flask, request, jsonify
from google.cloud import firestore

#initializing the firestore client with the project ID
db = firestore.Client(project="ashesi-social-connect")

app = Flask(__name__)

@functions_framework.http
def entry_point(request):
    if 'users' in request.path:
        if request.method == 'GET':
            get_path = os.path.split(request.path)[-1]
            return get_user_byID(get_path)
        elif request.method == 'POST':
            return create_user()
        elif request.method == 'PATCH':
            get_path = os.path.split(request.path)[-1]
            return edit_user(get_path)
        elif request.method == 'DELETE':
            get_path = os.path.split(request.path)[-1]
            return delete_user(get_path)
    else:
        return ({"error":"endpoint not found"}), 404
    


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

# @app.route('/voters/<string:voter_id>', methods=['PATCH'])
def edit_user(user_id):
    user_data = db.collection('users').document(user_id)
    user_doc = user_data.get()
    if not user_doc.exists:
        return jsonify({"error":f"User with ID {user_id} not found"}), 404

    user_info = user_doc.to_dict()
    if 'name' in request.json:
        user_info['name'] = request.json['name']

    if 'email' in request.json:
        updated_email = request.json['email']
        users_query = db.collection('users').where('email', '==', updated_email).get()
        for u in users_query:
            if u.id != user_id:
                return jsonify({"error":f"Email {updated_email} already exists"}), 400
            user_info['email'] = updated_email     
            
    if 'class' in request.json:
        user_info['class'] = request.json['class']
    
    if 'best_food' in request.json:
        user_info['best_food'] = request.json['best_food']
    
    if 'best_movie' in request.json:
        user_info['best_movie'] = request.json['best_movie']
    
    if 'major' in request.json:
        user_info['major'] = request.json['major']
    
    if 'on-campus' in request.json:
        user_info['on-campus'] = request.json['on-campus']
    
    if 'student_id' in request.json or 'class' in request.json:
        return jsonify({"message":"Sorry, you cannot alter your Student ID or Year Group! (contact admin support)"}), 403
    
    
    user_data.set(user_info)
    return jsonify(user_info), 200

# @app.route('/users/<string:user_id>', methods=['DELETE'])
def delete_user(user_id):
    user_data = db.collection('users').document(user_id)
    user_doc = user_data.get()

    if not user_doc.exists:
        return jsonify({"error":f"User with ID {user_id} not found"}), 404
    
    user_data.delete()
    
    return jsonify({"message":f"User {user_id} deleted successfully"}), 204
