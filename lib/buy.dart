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
      body: const OffersListView(),
    );
  }
}

final List<String> entries = <String>[
  'Antoinette Beauchamp',
  'Iliana Campbell',
  'Angelique Straub',
  'Ryleigh Pond',
  'Andy Watters',
  'Raphael Gossett',
  'Kent Deutsch',
  'Bridger Mojica',
  'Pearl Morse',
  'Jana Munguia'
];
final List<int> colorCodes = <int>[600, 500, 100];

class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            color: Colors.blue,
            margin: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.red,
                    margin: EdgeInsets.only(top: 4, left: 4, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entries[index % entries.length],
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16),
                            Icon(Icons.star, size: 16),
                            Icon(Icons.star, size: 16),
                            Icon(Icons.star_half, size: 16),
                            Icon(Icons.star_border, size: 16),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                '\88:88PM - 88:88PM',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.orange,
                    child: const Text(
                      '\$88',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 44),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
// return Container(
//   height: 80,
//   color: Colors.amber[colorCodes[index % colorCodes.length]],
//   child: Center(child: Text(entries[index % entries.length])),
// );