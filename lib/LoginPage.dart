import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_group_project/Authservice.dart';
import 'package:realty_group_project/ListingsPage.dart';
import 'NotificationHandler.dart';
import 'AppDrawer.dart';
import 'Register.dart';
import 'UserModel.dart';


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
      Provider.of<UserModel>(context, listen: false).setUser(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ListingsPage()),
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
      drawer: AppDrawer(notificationHandler: notificationHandler),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
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
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}


//TODO: Login Page with Username/Password
//TODO: Track login status throughout app, allow using the app as a guest
//TODO: Add Login/Logout button to the app drawer