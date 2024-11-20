import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatelessWidget {
  final FirebaseFirestore? _firestore;

  NotificationPage({Key? key})
      : _firestore = Firebase.apps.isNotEmpty ? FirebaseFirestore.instance : null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_firestore == null) {
      return _buildLocalNotifications(context); // Use local fallback
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Changed from red to blue
        foregroundColor: Colors.white,
        title: const Text("Notifications"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore!.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyNotifications();
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.blue), // Changed from red to blue
                  title: Text(
                    notification['message'],
                    style: const TextStyle(fontSize: 19), // Increased font size
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLocalNotifications(BuildContext context) {
    final List<String> localNotifications = [
      "Local: New listing added!",
      "Local: Your bid is successful!",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Changed from red to blue
        foregroundColor: Colors.white,
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: localNotifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: Text(
                localNotifications[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyNotifications() {
    return Center(
      child: Text(
        'No notifications.',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade700), // Adjusted color and message
      ),
    );
  }
}
