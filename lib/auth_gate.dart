import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> addUser(String? name, String uid) async {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  return await users
      .add({'name': name, 'uid': uid, 'swipes': 0, 'seller-id': ""})
      .then((value) => print(""))
      .catchError((error) => print("ERROR ADDING DATA: $error"));
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(  
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'assets/ruexpress.png',
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to RUSwipeShare, please sign in!')
                    : const Text('Welcome to RUSwipeShare, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }

       
        return const HomeScreen();
      },
    );
  }
}
