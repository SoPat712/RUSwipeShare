import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay _time = TimeOfDay.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        automaticallyImplyLeading: false,
      ),
      body: OffersListView(),
    );
  }
}

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            color: Colors.amber[colorCodes[index % 3]],
            child: Center(child: Text('Entry ${entries[index % 3]}')),
          );
        });
  }
}
