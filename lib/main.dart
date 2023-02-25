import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruswipeshare/home.dart';

import 'firebase_options.dart';
import 'authGate.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.android,
 );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: const AuthGate(),
   );
 }
}
