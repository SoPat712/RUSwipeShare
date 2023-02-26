import 'package:flutter/material.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:material_dialogs/material_dialogs.dart';

enum CampusState { campuses, list_options, offers }

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: Text("Choose A Different Location")),
          ),
          const Expanded(child: ContentDisplay()),
        ],
      ),
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
final List<List<String>> eatingLocations = [
  <String>['Brower Dining Hall', 'Cafe West'],
  <String>['Busch Dining Hall', 'Woody\'s'],
  <String>[
    'Livingston Dining Hall',
    'Kilmer\'s Market',
    'Sbarro\'s',
  ],
  <String>[
    'Neilson Dining Hall',
    'Cook Cafe',
    'Douglass Cafe',
    'Harvest INFH',
    'Red Pine Pizza'
  ]
];
final List<int> colorCodes = <int>[600, 500, 100];

class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Dialogs.materialDialog(
                color: Colors.white,
                customView: TransactionDetails(),
                customViewPosition: CustomViewPosition.BEFORE_ACTION,
                msg: 'Please read all the information below before purchasing.',
                title: 'Transaction Details',
                context: context,
                actions: [
                  IconsOutlineButton(
                    onPressed: () {},
                    text: 'Cancel',
                    iconData: Icons.cancel_outlined,
                    textStyle: TextStyle(color: Colors.grey),
                    iconColor: Colors.grey,
                  ),
                  IconsButton(
                    onPressed: () {},
                    text: 'Purchase',
                    iconData: Icons.done,
                    color: Colors.blue,
                    textStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                ],
              );
            },
            child: Container(
              height: 80,
              color: Colors.blue,
              margin: const EdgeInsets.only(bottom: 4),
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
                            children: const [
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
                              children: const [
                                Text(
                                  '88:88PM - 88:88PM',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
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
            ),
          );
        });
  }
}

class ContentDisplay extends StatefulWidget {
  const ContentDisplay({super.key});
  @override
  _CampusGridViewState createState() => _CampusGridViewState();
}

class _CampusGridViewState extends State<ContentDisplay> {
  CampusState _currentState = CampusState.campuses;
  List<String> _diningOptions = List.empty();
  String selectedLocation = "";
  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case CampusState.campuses:
        return Center(
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 1,
            mainAxisSpacing: 15,
            padding: EdgeInsets.all(10),
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _currentState = CampusState.list_options;
                    _diningOptions = eatingLocations[3];
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/ca_bg.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        color: Colors.red,
                        child: Text(
                          "College Avenue",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/busch_bg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      color: Colors.green,
                      child: Text(
                        "Busch",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/livi_bg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Text(
                        "Livingston",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/cd_bg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      color: Colors.yellow,
                      child: Text(
                        "Cook-Douglass",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case CampusState.list_options:
        return ListView.builder(
            itemCount: _diningOptions.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _currentState = CampusState.offers;
                    selectedLocation = _diningOptions.elementAt(index);
                  });
                },
                child: Container(
                  height: 80,
                  color: Colors.blue,
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.red,
                        margin: EdgeInsets.only(top: 4, left: 4, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _diningOptions[index],
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });

      case CampusState.offers:
        return ListView.builder(
            itemCount: 30,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Dialogs.materialDialog(
                    color: Colors.white,
                    customView: TransactionDetails(),
                    customViewPosition: CustomViewPosition.BEFORE_ACTION,
                    msg:
                        'Please read all the information below before purchasing.',
                    title: 'Transaction Details',
                    context: context,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {},
                        text: 'Cancel',
                        iconData: Icons.cancel_outlined,
                        textStyle: TextStyle(color: Colors.grey),
                        iconColor: Colors.grey,
                      ),
                      IconsButton(
                        onPressed: () {},
                        text: 'Purchase',
                        iconData: Icons.done,
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                      ),
                    ],
                  );
                },
                child: Container(
                  height: 80,
                  color: Colors.blue,
                  margin: const EdgeInsets.only(bottom: 4),
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
                                children: const [
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
                                  children: const [
                                    Text(
                                      '88:88PM - 88:88PM',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
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
                ),
              );
            });
    }
  }
}

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.blue,
    );
  }
}
