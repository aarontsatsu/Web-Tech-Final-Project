// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late String _studentId;
  late String _name;
  late String _email;
  late DateTime _dob;
  late int _yearGroup;
  late String _major;
  late bool _hasResidence = false;
  late String _bestFood;
  late String _bestMovie;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Submit the form
      // You can handle the form submission logic here
      print('Student ID: $_studentId');
      print('Name: $_name');
      print('Email: $_email');
      print('Date of Birth: $_dob');
      print('Year Group: $_yearGroup');
      print('Major: $_major');
      print('Has Residence: $_hasResidence');
      print('Best Food: $_bestFood');
      print('Best Movie: $_bestMovie');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Student ID'),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your student ID';
            }
            return null;
          },
          onSaved: (value) => _studentId = value ?? '',
        ),

          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) => _name = value ?? '',
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email address';
              }
              return null;
            },
            onSaved: (value) => _email = value ?? '',
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Date of Birth'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your date of birth';
              }
              return null;
            },
            onSaved: (value) => _dob = DateTime.parse(value ?? ''),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Year Group'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your year group';
              }
              return null;
            },
            onSaved: (value) => _yearGroup = int.parse(value ?? ''),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Major'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your major';
              }
              return null;
            },
            onSaved: (value) => _major = value ?? '',
          ),
          CheckboxListTile(
            title: Text('Do you have on-campus residence?'),
            value: _hasResidence, // add a null check here
            onChanged: (bool? value) {
              setState(() {
                _hasResidence = value!;
              });
            },
          ),

          TextFormField(
            decoration: InputDecoration(labelText: 'Best Food'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your best food';
              }
              return null;
            },
            onSaved: (value) => _bestFood = value ?? '',
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Best Movie'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your best movie';
              }
              return null;
            },
            onSaved: (value) => _bestMovie = value ?? '',
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}