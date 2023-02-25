import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ruswipeshare/home.dart';
import 'package:ruswipeshare/main.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text("Hi"),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
