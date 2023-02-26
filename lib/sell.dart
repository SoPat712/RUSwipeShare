// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ruswipeshare/auth_gate.dart';
import 'package:intl/intl.dart';
import 'package:ruswipeshare/buy.dart';
import 'package:ruswipeshare/meetings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

Map<String, bool> values = {
  'Brower Dining Hall': false,
  'Cafe West': false,
  'Livingston Dining Hall': false,
  'Kilmer\'s Market': false,
  'Sbarro\'s': false,
  'Neilson Dining Hall': false,
  'Cook Cafe': false,
  'Douglass Cafe': false,
  'Harvest INFH': false,
  'Red Pine Pizza': false,
};

class _SellScreenState extends State<SellScreen> {
  DateFormat dateFormat = DateFormat("HH:mm a");
  String startTime = '??:??';
  DateTime startTimeTime = DateTime.now();
  String endTime = '??:??';
  DateTime endTimeTime = DateTime.now();
  bool? is24HoursFormat;
  double price = 0;
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    dateFormat = is24HoursFormat ? DateFormat("HH:mm a") : DateFormat("HH:mm");
    return Scaffold(
      body: Column(children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.store_mall_directory,
                color: Colors.red,
                size: 40,
              ),
              const Text(
                'Place',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: values.length,
            itemBuilder: (context, index) => CheckboxListTile(
              visualDensity: VisualDensity.compact,
              title: Text(
                values.keys.elementAt(index),
                style: TextStyle(fontSize: 18),
              ),
              value: values.values.elementAt(index),
              onChanged: (bool? value) {
                setState(() {
                  values[values.keys.elementAt(index)] = value!;
                });
              },
            ),
          ),
          // )
        ),
        Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.red,
                  size: 40,
                ),
                const Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                setState(() {
                                  endTimeTime = date;
                                  endTime = dateFormat.format(date);
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2,
                                      color: CustomMaterialColor(240, 240, 240)
                                          .mdColor)),
                              child: Text(
                                endTime,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            " - ",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                setState(() {
                                  startTimeTime = date;
                                  startTime = dateFormat.format(date);
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2,
                                      color: CustomMaterialColor(240, 240, 240)
                                          .mdColor)),
                              child: Text(
                                startTime,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.attach_money,
                color: Colors.red,
                size: 40,
              ),
              const Text(
                'Money',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 2,
                                  color: CustomMaterialColor(240, 240, 240)
                                      .mdColor)),
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                              controller: priceController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Price',
                                hintStyle: TextStyle(
                                    color: Colors.white24, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  List<String> locations = [];
                  User? user = auth.currentUser;
                  values.forEach((key, value) {
                    if (value == true) locations.add(key);
                  });
                  if (user != null) {
                    Seller seller = Seller(
                        user.displayName,
                        user.uid,
                        locations,
                        TimeRange(Timestamp.fromDate(startTimeTime),
                            Timestamp.fromDate(endTimeTime)),
                        double.parse(priceController.text));
                    addSeller(seller);
                  }
                },
                child: const Text('Submit Sell Request'),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class LocationDropdown extends StatefulWidget {
  const LocationDropdown({super.key});

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

const List<String> list = <String>[
  'Busch',
  'College Ave',
  'Cook/Doug',
  'Livingston',
];

class _LocationDropdownState extends State<LocationDropdown> {
  String dropdownValue = 'Busch';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        // This is called when the user selects an item.

        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
