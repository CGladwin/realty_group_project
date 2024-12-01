// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:realty_group_project/LoginPage.dart';
import 'package:realty_group_project/SearchHistory.dart';
import 'package:realty_group_project/UserPage.dart';
import 'ListingsPage.dart';
import 'FavouriteListings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatefulWidget {

  const AppDrawer({super.key});

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn = false;

  void checkLogin(){
    if(_auth.currentUser != null){
      _isLoggedIn = true;
    }
    return;
  }

  Future<void> _signOut(BuildContext context) async{
    await _auth.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have been signed out.'),
        duration: Duration(seconds: 2),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    checkLogin();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                'Realty',
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              _openHomePage();
            },
          ),
          if(_isLoggedIn)
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              _openUserPage();
            },
          ),
          ListTile(
            title: const Text('Favourite Listings'),
            onTap: () {
              Navigator.pop(context);
              _openNotificationPage();
            },
          ),
          ListTile(
            title: const Text('Search History'),
            onTap: () {
              Navigator.pop(context);
              _openSearchHistory();
            },
          ),
          _isLoggedIn
          ? ListTile(
            title: const Text('Sign Out'),
            onTap: (){
              Navigator.pop(context);
              _signOut(context);
            }
          )
          : ListTile(
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                _openLoginPage();
              },
           )
        ],
      ),
    );
  }

  void _openHomePage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ListingsPage(),
      ),
    );
  }

  void _openNotificationPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavouriteListings(),
      ),
    );
  }

  void _openSearchHistory() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchHistory(),
      ),
    );
  }

  void _openLoginPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _openUserPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserPage(),
      ),
    );
  }
}