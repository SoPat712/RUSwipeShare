import 'package:flutter/material.dart';
import 'meetings.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    print("OOOGABOOGA");
    getSellers(Filter(
            ["Sbarro"],
            PriceRange(8, 10),
            TimeRange(Timestamp.fromDate(DateTime(2023, 2, 26, 12, 50)),
                Timestamp.fromDate(DateTime(2023, 2, 26, 11, 50)))))
        .then((value) => {print(value)});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Beens"),
      ),
      body: const Center(
        child: Text("Main Green"),
      ),
    );
  }
}
