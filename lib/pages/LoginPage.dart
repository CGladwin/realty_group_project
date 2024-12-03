import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_group_project/Authservice.dart';
import 'package:realty_group_project/pages/ListingsPage.dart';
import '../services/NotificationHandler.dart';
import '../widgets/AppDrawer.dart';
import 'Register.dart';
import '../models/UserModel.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{

  NotificationHandler notificationHandler = NotificationHandler();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    notificationHandler.initializeNotifications();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _login() async {
      User? user = await _auth.signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
      );
    if(user != null){
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': user.email,
          'password': passwordController.text.trim(), //user.password is not a valid getter for security reasons, so this workaround is used
          'email': user.email,
          'phoneNumber': '',
          'imageURL': 'https://cdn3.iconfinder.com/data/icons/office-485/100/ICON_BASIC-11-512.png',
          'favouriteListings': [],
        });
      }

      Provider.of<UserModel>(context, listen: false).setUser(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ListingsPage()),
      );
      _showSnackbar("Successfully logged in.");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Realty"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Show the register dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RegisterDialog(
                      onSuccess: _showSnackbar,
                    );
                  },
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}