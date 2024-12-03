import 'package:flutter/material.dart';
import '../services/NotificationHandler.dart';
import '../widgets/AppDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserData.dart';

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
  final TextEditingController phoneController = TextEditingController();
  UserData? userData;

  @override
  void initState() {
    super.initState();
    getUser();
    notificationHandler.initializeNotifications();
  }

  void getUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          print(userDoc.data());
          setState(() {
            userData = UserData.fromMap(userDoc.data() as Map<String, dynamic>);
          });
        }
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  void changeField(String field, String fieldValue) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        await _firestore.collection('users').doc(uid).update({
          field: fieldValue,
        });
        getUser();
      }
    } catch (e) {
      print('Error updating field: $e');
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

  void _logout() async {
    await _auth.signOut();
    Navigator.pop(context);
    _showSnackbar("You have been signed out");
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://cdn3.iconfinder.com/data/icons/office-485/100/ICON_BASIC-11-512.png'),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Text(
                  userData?.username ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Change Username'),
                          content: TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(labelText: 'New Username'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (usernameController.text.trim().isNotEmpty) {
                                  setState(() {
                                    changeField('username', usernameController.text);
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  _showSnackbar('Username Empty');
                                }
                              },
                              child: const Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Text(userData?.emailAddress ?? ''),
            const SizedBox(height: 24.0),
            // Contact Information Section
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Phone Number: ',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  userData?.phoneNumber ?? 'No Phone Number',
                  style: const TextStyle(fontSize: 14)
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Change Phone Number'),
                          content: TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(labelText: 'New Phone Number'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (phoneController.text.trim().isNotEmpty) {
                                  setState(() {
                                    changeField('phoneNumber', phoneController.text);
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  _showSnackbar('Phone Number Empty');
                                }
                              },
                              child: const Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            // Log Out Button
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _logout,
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
