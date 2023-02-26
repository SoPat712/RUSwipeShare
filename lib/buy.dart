import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ruswipeshare/main.dart';
import 'package:intl/intl.dart';

import 'meetings.dart';

enum CampusState { campuses, list_options, offers }

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
final Map<String, String> nameToAsset = {
  'Brower Dining Hall': 'brower.jpg',
  'Cafe West': 'cafe_west.jpg',
  'Busch Dining Hall': 'bdh.jpg',
  'Woody\'s Cafe': 'woodys.jpg',
  'Livingston Dining Hall': 'ldh.jpg',
  'Kilmer\'s Market': 'kilmers.png',
  'Sbarro\'s': 'sbarros.jpg',
  'Neilson Dining Hall': 'neilson.jpg',
  'Cook Cafe': 'cook_cafe.jpg',
  'Douglass Cafe': 'doug_cafe.jpg',
  'Harvest INFH': 'harvest.jpg',
  'Red Pine Pizza': 'red_pine.jpg'
};
final List<List<String>> eatingLocations = [
  <String>['Brower Dining Hall', 'Cafe West'],
  <String>['Busch Dining Hall', 'Woody\'s Cafe'],
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
final List<String> timeBgAssets = <String>[
  'assets/daytime_swipe.jpg',
  'assets/afternoon_swipe.jpg',
  'assets/nighttime_swipe.jpg'
];

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  CampusState _currentState = CampusState.campuses;
  List<String> _diningOptions = List.empty();
  List<Seller> _sellersAtDiningHall = [];

  String _selectedLocation = "";
  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case CampusState.campuses:
        return Scaffold(
          body: Column(
            children: [
              Row(children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "Campuses",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                )
              ]),
              Expanded(
                  child: Center(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 20,
                  padding: const EdgeInsets.all(10),
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentState = CampusState.list_options;
                          _diningOptions = eatingLocations[0];
                        });
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
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
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: const Text(
                                "College Avenue",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentState = CampusState.list_options;
                          _diningOptions = eatingLocations[1];
                        });
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
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
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: const Text(
                                "Busch",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentState = CampusState.list_options;
                          _diningOptions = eatingLocations[2];
                        });
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
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
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: const Text(
                                "Livi",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentState = CampusState.list_options;
                          _diningOptions = eatingLocations[3];
                        });
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
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
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: const Text(
                                "Cook-Douglass",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      case CampusState.list_options:
        return Scaffold(
          body: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentState = CampusState.campuses;
                    });
                  },
                  child: const Text("Choose A Different Location")),
            ),
            Row(children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  "Swipe Locations",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              )
            ]),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _diningOptions.length,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(4, 4, 4, 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomMaterialColor(240, 240, 240).mdColor,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentState = CampusState.offers;
                            _selectedLocation = _diningOptions.elementAt(index);
                          });
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/" +
                                  nameToAsset[
                                      _diningOptions.elementAt(index)]!),
                            )),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                padding: const EdgeInsets.only(right: 40),
                                alignment: Alignment.bottomRight,
                                margin: const EdgeInsets.only(
                                    top: 4, left: 20, bottom: 4),
                                child: Text(
                                  _diningOptions[index],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ]),
        );
      case CampusState.offers:
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentState = CampusState.campuses;
                              });
                            },
                            child: const Text("Choose A Different Location")),
                      ),
                      Flexible(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Icon(Icons.filter_list)))
                    ]),
              ),
              Row(children: [
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Available Swipes",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                )
              ]),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 30,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemBuilder: (BuildContext context, int index) {
                      List<Seller> sellers = [];
                      var loc = _diningOptions[index % _diningOptions.length];

                      return FutureBuilder<List<Seller>>(
                        future: getSellers(Filter([loc], null, null)),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Seller>> snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data ?? [];
                            String startTimeFmt = DateFormat("h:mm a").format(
                                data[index % data.length]
                                    .availableTime
                                    .startTime
                                    .toDate());

                            String endTimeFmt = DateFormat("h:mm a").format(
                                data[index % data.length]
                                    .availableTime
                                    .endTime
                                    .toDate());

                            final price = data[index % data.length].price;

                            return InkWell(
                              onTap: () {
                                showSheet(context, index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            CustomMaterialColor(240, 240, 240)
                                                .mdColor,
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                margin: const EdgeInsets.all(4),
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black26, BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage(timeBgAssets[index % 3]),
                                    )),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 2, sigmaY: 2),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              // color: Colors.red,
                                              margin: const EdgeInsets.only(
                                                  top: 4, left: 4, bottom: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data?[index % data.length]
                                                            .name ??
                                                        "Unknown Seller",
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 24),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color:
                                                              CustomMaterialColor(
                                                                      240,
                                                                      240,
                                                                      240)
                                                                  .mdColor,
                                                          size: 16),
                                                      Icon(Icons.star,
                                                          color:
                                                              CustomMaterialColor(
                                                                      240,
                                                                      240,
                                                                      240)
                                                                  .mdColor,
                                                          size: 16),
                                                      Icon(Icons.star,
                                                          color:
                                                              CustomMaterialColor(
                                                                      240,
                                                                      240,
                                                                      240)
                                                                  .mdColor,
                                                          size: 16),
                                                      Icon(Icons.star_half,
                                                          color:
                                                              CustomMaterialColor(
                                                                      240,
                                                                      240,
                                                                      240)
                                                                  .mdColor,
                                                          size: 16),
                                                      Icon(Icons.star_border,
                                                          color:
                                                              CustomMaterialColor(
                                                                      240,
                                                                      240,
                                                                      240)
                                                                  .mdColor,
                                                          size: 16),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "$startTimeFmt - $endTimeFmt",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              child: Text(
                                                '\$${price}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: 30),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    }),
              ),
            ],
          ),
        );
    }
  }

  Future<dynamic> showSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Container(
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    20,
                    0,
                    25,
                  ),
                  child: Text(
                    "Transaction Details",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Proxima',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.home,
                //   ),
                //   onTap: () async {
                //     Navigator.pop(context);

                //     if (myPlacesIds[index] != myHomeId) {
                //       scrollController.animateTo(0,
                //           duration: const Duration(milliseconds: 400),
                //           curve: Curves.easeInOutCirc);
                //       myHomeFullName = myPlacesFullName[index];
                //       myHomeId = myPlacesIds[index];
                //       myHomeMainText = myPlacesMainText[index];
                //       myHomeSecondaryText = myPlacesSecondaryText[index];
                //       if (index != 0) {
                //         myPlacesIds.insert(0, myHomeId);
                //         myPlacesFullName.insert(0, myHomeFullName);
                //         myPlacesMainText.insert(0, myHomeMainText);
                //         myPlacesSecondaryText.insert(0, myHomeSecondaryText);
                //         _listKey.currentState!.insertItem(0,
                //             duration: const Duration(milliseconds: 200));

                //         await Future.delayed(const Duration(milliseconds: 200),
                //             () async {
                //           myPlacesFullName.removeAt(index + 1);
                //           myPlacesMainText.removeAt(index + 1);
                //           myPlacesSecondaryText.removeAt(index + 1);
                //           myPlacesIds.removeAt(index + 1);
                //           _listKey.currentState!.removeItem(
                //             index + 1,
                //             (context, animation) {
                //               return _buildLocTileOutAnimate(
                //                   context,
                //                   animation,
                //                   myPlacesMainText[0],
                //                   myPlacesSecondaryText[0],
                //                   true);
                //             },
                //             duration: const Duration(milliseconds: 200),
                //           );
                //           indexrem = index;
                //         });
                //       } else {
                //         myHomeFullName = myPlacesFullName[index];
                //         myHomeId = myPlacesIds[index];
                //         myHomeMainText = myPlacesMainText[index];
                //         myHomeSecondaryText = myPlacesSecondaryText[index];
                //         setState(() {});
                //       }
                //     } else {
                //       myHomeId = "";
                //       myHomeFullName = "";
                //       myHomeSecondaryText = "";
                //       myHomeMainText = "";
                //       setState(() {});
                //     }
                //     _saveHome();
                //     _saveList();
                //   },
                //   title: Text(
                //     (myPlacesIds[index] != myHomeId)
                //         ? "Set as Home"
                //         : "Remove as home",
                //     style: const TextStyle(
                //       fontFamily: 'Proxima',
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Cancel",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Proxima',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    // add close button
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Purchase",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Proxima',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
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
      height: 200,
      color: Colors.blue,
    );
  }
}

class CustomMaterialColor {
  final int r;
  final int g;
  final int b;

  CustomMaterialColor(this.r, this.g, this.b);

  MaterialColor get mdColor {
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }
}
