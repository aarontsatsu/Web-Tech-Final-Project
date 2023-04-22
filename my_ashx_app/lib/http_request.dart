import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// URIs to process requests
String _userURI = "http://192.168.106.84:8080/users";
String _postURI = "http://192.168.106.84:8080/posts";


Future<void> createUser(body) {
  return http.post(
    Uri.parse(_userURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
}

Future<void> editUser(body) {
  return http.patch(
    Uri.parse(_userURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
}

Future<void> getUser(body) {
  return http.get(
    Uri.parse(_userURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
}

Future<void> createPost(body) {
  return http.post(
    Uri.parse(_postURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
}

Future<void> getPosts(body) {
  return http.get(
    Uri.parse(_postURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
}