// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterDialog extends StatefulWidget {
  final Function(String) onSuccess;

  RegisterDialog({required this.onSuccess});

  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String emailError = '';
  String passwordError = '';

  void _showError(){
    setState(() {
    });
  }

  void _registerUser() async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if(user != null){
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'username': user.email,
            'password': passwordController.text.trim(), //user.password is not a valid getter for security reasons, so this workaround is used
            'email': user.email,
            'phoneNumber': '',
            'imageURL': 'https://cdn3.iconfinder.com/data/icons/office-485/100/ICON_BASIC-11-512.png',
          });
          widget.onSuccess('Registration Successful.');
        }
        Navigator.of(context).pop();
    }
    catch (e){
      print(e);
      if(e is FirebaseAuthException){
        if(e.code == 'invalid-email'){
          emailError = 'Email is invalid';
        }
        if(e.code == 'email-already-in-use'){
          emailError = 'Email already in use';
        }
        if(e.code == 'weak-password'){
          passwordError = 'Password must be at least 6 characters';
        }
        _showError();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              emailError,
              style: TextStyle(fontSize: 12.0, color: Colors.red[900]),
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              passwordError,
              style: TextStyle(fontSize: 12.0, color: Colors.red[900]),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            emailError = '';
            passwordError = '';
            _registerUser();
          },
          child: const Text('Register'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
