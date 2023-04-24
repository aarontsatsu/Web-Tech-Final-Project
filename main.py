import json
from flask import Flask, request, jsonify
from google.cloud import firestore
from flask_cors import CORS
from firebase_admin import credentials, firestore, initialize_app

# Initialize Firestore Database
credential = credentials.Certificate('key.json')
default_app = initialize_app(credential)

#initializing the firestore client with the project ID
db = firestore.client()

app = Flask(__name__)
cors = CORS(app)

"""
    Users Resource
"""
@app.route('/users/<int:user_id>', methods=['GET'])
def get_user_byID(user_id):
    users_data = db.collection('users').document(str(user_id))
    user = users_data.get()

    if user.exists:
        user_dict = user.to_dict()
        user_dict['student_id'] = user_id
        return jsonify(user_dict), 200

    return jsonify({'message': 'User ID not found'}), 404

@app.route('/users', methods=['POST'])
def create_user():
    record = request.get_json()

    users_data = db.collection('users')
    user_id = record.get('student_id')

    # Check if a user with the same student ID already exists
    query_check = users_data.where('student_id', '==', user_id)
    users = query_check.stream()

    for user in users:
        return jsonify({'message': f'User with id {user_id} already exists.'}), 400
    
    user_data = users_data.document(str(user_id))
    user_data.set(record)

    record['student_id'] = user_data.id

    return jsonify(record), 201

@app.route('/users/<int:user_id>', methods=['PATCH'])
def edit_user(user_id):
    user_data = db.collection('users').document(str(user_id))
    user_doc = user_data.get()
    if not user_doc.exists:
        return jsonify({"error":f"User with ID {user_id} not found"}), 404

    user_info = user_doc.to_dict()
    if 'dob' in request.json:
        user_info['dob'] = request.json['dob']
            
    if 'class' in request.json:
        user_info['class'] = request.json['class']
    
    if 'best_food' in request.json:
        user_info['best_food'] = request.json['best_food']
    
    if 'best_movie' in request.json:
        user_info['best_movie'] = request.json['best_movie']
    
    if 'major' in request.json:
        user_info['major'] = request.json['major']
    
    if 'on-campus' in request.json:
        user_info['residence'] = request.json['residence']
    
    if 'user_id' in request.json or 'email' in request.json or 'name' in request.json:
        return jsonify({"message":"Sorry, you cannot alter your Student ID, Email OR Name! (contact admin support)"}), 403

    user_data.set(user_info)
    return jsonify(user_info), 200


"""
    Posts Resource
"""
@app.route('/posts', methods=['GET'])
def get_posts():
    posts_data = db.collection('posts')
    posts = posts_data.stream()
    result = []
    for post in posts:
        post_dict = post.to_dict()
        result.append(post_dict)
    if len(result) > 0:
        return jsonify(result), 200
    return jsonify({'error': 'post not found'}), 404

@app.route('/posts', methods=['POST'])
def create_post():
    record = json.loads(request.data)

    posts_data = db.collection('posts')
    post_data = posts_data.document()
    post_data.set(record)

    return jsonify(record), 201

# if __name__ == '__main__':
#     app.run(debug=True)
