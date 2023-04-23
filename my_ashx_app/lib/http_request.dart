import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// URIs to process requests
String _userURI = "http://127.0.0.1:8080/users";
String _postURI = "http://127.0.0.1:8080/posts";


Future<int> createUser(body) async{

  final uri = Uri.parse(_userURI);
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding
  );

  if (response.statusCode == 201){
    return response.statusCode;
  }else{
    throw Exception('Failed to create user');
  }
}

Future<int> editUser(body) async{

  final uri = Uri.parse(_userURI);
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.patch(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding
  );

  if (response.statusCode == 200){
    return response.statusCode;
  }else{
    throw Exception('Failed to edit user');
  }
}

Future<List<dynamic>> getUser(body) async{

  final uri = Uri.parse(_userURI);
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};

  http.Response response = await http.get(
    uri,
    headers: headers
  );

  if (response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    throw Exception('Failed to get user');
  }
}

Future<int> createPost(body) async{

  final uri = Uri.parse(_postURI);
  final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding
  );
  if (response.statusCode == 201){
    return response.statusCode;
  }else{
    throw Exception('Failed to create post');
  }
}

Future<List<dynamic>> getPosts(body) async{

  final uri = Uri.parse(_postURI);
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};

  http.Response response = await http.get(
    uri,
    headers: headers
  );

  if (response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    throw Exception('Failed to get posts');
  }
}