import json, os.path, functions_framework, smtplib
from flask import Flask, request, jsonify
from google.cloud import firestore
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


#initializing the firestore client with the project ID
db = firestore.Client(project="ashesi-social-connect")

app = Flask(__name__)

@functions_framework.http
def main(request):
    if 'users' in request.path:
        if request.method == 'GET':
            get_path = os.path.split(request.path)[-1]
            return get_user_byID(get_path)
        elif request.method == 'POST':
            return create_user()
        elif request.method == 'PATCH':
            get_path = os.path.split(request.path)[-1]
            return edit_user(get_path)
        # elif request.method == 'DELETE':
        #     get_path = os.path.split(request.path)[-1]
        #     return delete_user(get_path)
    
    elif 'posts' in request.path:
        if request.method == 'GET':
            get_path = os.path.split(request.path)[-1]
            return get_post_byID(get_path)
        elif request.method == 'POST':
            return create_post()
        # elif request.method == 'DELETE':
        #     get_path = os.path.split(request.path)[-1]
        #     return delete_post(get_path)
    
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
        user_dict['student_id'] = user_id
        return jsonify(user_dict), 200

    return jsonify({'message': 'User ID not found'}), 404

# @app.route('/users', methods=['POST'])
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
            if u.student_id != user_id:
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

# # @app.route('/users/<string:user_id>', methods=['DELETE'])
# def delete_user(user_id):
#     user_data = db.collection('users').document(user_id)
#     user_doc = user_data.get()

#     if not user_doc.exists:
#         return jsonify({"error":f"User with ID {user_id} not found"}), 404
    
#     user_data.delete()
    
#     return jsonify({"message":f"User {user_id} deleted successfully"}), 204


"""
    Posts Resource
"""
# @app.route('/posts/<string:user_id>', methods=['GET'])
def get_post_byID(post_id):
    posts_data = db.collection('posts').document(post_id)
    post = posts_data.get()

    if post.exists:
        post_dict = post.to_dict()
        post_dict['postID'] = post.postID
        return jsonify(post_dict), 200
    return jsonify({'message': 'Post not found'}), 404

#email notification script
def send_email(to_addresses):
    # Set up the email message
    message = MIMEMultipart()
    message['To'] = ", ".join(to_addresses)
    message['Subject'] = "New Post on AshX Connect"
    body = """
    Hello,
    
    There is a new post on AshX Connect by ...
    Check it out.

    Best,
    AshX Connect
    (do not reply)
    
    """
    message.attach(MIMEText(body, 'plain'))

    # Connect to the SMTP server
    smtp_server = smtplib.SMTP('smtp.gmail.com', 587)
    smtp_server.ehlo()
    smtp_server.starttls()
    smtp_server.login('ashxconnect@gmail.com', 'ashx12345')

    # Send the email
    smtp_server.sendmail('aarontmkl@gmail.com', to_addresses, message.as_string())
    smtp_server.quit()

#get all email addresses in the database
def get_emails():
    emails = []
    users_ref = db.collection('users')
    docs = users_ref.stream()
    for doc in docs:
        data = doc.to_dict()
        if 'email' in data:
            emails.append(data['email'])

    return emails

# @app.route('/posts', methods=['POST'])
def create_post():
    record = json.loads(request.data)

    posts_data = db.collection('posts')
    query_check = posts_data.where('postID', '==', record['postID'])
    posts = query_check.stream()

    for post in posts:
        return jsonify({'message':f'Post with id {record["postID"]} already exists.'}), 400
    
    post_data = posts_data.document()
    post_data.set(record)
    record['postID'] = post_data.postID
    
    #email notification to all users
    send_email(get_emails())

    return jsonify(record), 201

# # @app.route('/posts/<string:post_id>', methods=['DELETE'])
# def delete_post(post_id):
#     post_data = db.collection('posts').document(post_id)
#     post_doc = post_data.get()

#     if not post_doc.exists:
#         return jsonify({"error":f"User with ID {post_id} not found"}), 404
    
#     post_data.delete()
    
#     return jsonify({"message":f"Post deleted successfully"}), 204

if __name__ == '__main__':
    app.run(debug=True)
