import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_group_project/UserModel.dart';
import 'NotificationHandler.dart';
import 'AppDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserData.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  NotificationHandler notificationHandler = NotificationHandler();
  final TextEditingController usernameController = TextEditingController();
  UserData? userData;

  @override
  void initState() {
    super.initState();
    getUser();
    notificationHandler.initializeNotifications();
  }

  void getUser() async{
    try{
      User? user = _auth.currentUser;
      if(user != null){
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if(userDoc.exists){
          print(userDoc.data());
          setState(() {
            userData = UserData.fromMap(userDoc.data() as Map<String, dynamic>);
          });
        }
      }
    }
    catch(e){

    }
  }
  
  void changeField(String field, String fieldValue) async{
    try{
      User? user = _auth.currentUser;
      if(user != null){
        String uid = user.uid;
        await _firestore.collection('users').doc(uid).update({
          field: fieldValue,
        });
        getUser();
      }
    }
    catch(e){
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const SizedBox(height:16.0),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://cdn3.iconfinder.com/data/icons/office-485/100/ICON_BASIC-11-512.png'),
              ),
              const SizedBox(height:24.0),
              Row(
                children: [
                  Text(
                    userData?.username ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text(
                              'Change Username'
                            ),
                            content: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: 'New Username'
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if(usernameController.text.trim().isNotEmpty){
                                    setState(() {
                                      changeField('username', usernameController.text);
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  else{
                                    _showSnackbar('Username Empty');
                                  }
                                },
                                child: Text('Save'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        }
                      );
                    },
                  )
                ]
              ),
              Text(userData?.emailAddress ?? ''),
            ],
        ),
      ),
    );
  }
}