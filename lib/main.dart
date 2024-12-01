import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:realty_group_project/UserModel.dart';
import 'ListingsPage.dart';
import 'StarredListings.dart';
import 'firebase_options.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => StarredListings()),
      ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error initializing Firebase');
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Temp Title',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
            ),
            routes: {
              '/listings': (context) => const ListingsPage()
            },
            home: const ListingsPage(),
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
