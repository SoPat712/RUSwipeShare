import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory, color: Colors.red),
          Expanded(
            child: const Text('Place'),
          ),
          Icon(Icons.access_time, color: Colors.red),
          Expanded(
            child: const Text('Time'),
          ),
          Icon(Icons.attach_money, color: Colors.red),
          Expanded(
            child: const Text('Cost'),
          ),
        ],
      ),
    );
  }
}
