// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ruswipeshare/auth_gate.dart';
import 'package:intl/intl.dart';
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
  String startTime = 'Start Time';
  DateTime startTimeTime = DateTime.now();
  String endTime = 'End Time';
  DateTime endTimeTime = DateTime.now();
  bool? is24HoursFormat;
  double price = 0;
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.store_mall_directory, color: Colors.red),
              Text('Place'),
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 250),
            child: ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Text(values.keys.elementAt(index)),
                value: values.values.elementAt(index),
                onChanged: (bool? value) {
                  setState(() {
                    values[values.keys.elementAt(index)] = value!;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.access_time, color: Colors.red),
              Text('Time'),
            ],
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  startTime,
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  "to",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  endTime,
                  style: TextStyle(fontSize: 35),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  DatePicker.showDateTimePicker(context, showTitleActions: true, minTime: DateTime.now(), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      startTimeTime = date;
                      startTime = dateFormat.format(date);
                      print('confirm $date');
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  // final TimeOfDay? picked = await showTimePicker(
                  //   context: context,
                  //   initialTime: TimeOfDay.fromDateTime(startTimeTime),
                  // );
                  // if (picked != null && picked != TimeOfDay.fromDateTime(startTimeTime)) {
                  //   setState(() {
                  //     startTimeTime = DateTime.fromMicrosecondsSinceEpoch(picked.hour * 60 * 60 * 1000000 + picked.minute * 60 * 1000000, isUtc: true);
                  //     startTime = startTimeTime.hour.toString() + ":" + startTimeTime.minute.toString() + ((is24HoursFormat) ? "" : ((startTimeTime.hour > 12) ? "PM" : "AM"));
                  //   });
                  // }
                },
                child: const Text('Select Start Time'),
              ),
              ElevatedButton(
                onPressed: () async {
                  DatePicker.showDateTimePicker(context, showTitleActions: true, minTime: DateTime.now(), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      endTimeTime = date;
                      endTime = dateFormat.format(date);
                      print('confirm $date');
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  // final TimeOfDay? picked = await showTimePicker(
                  //   context: context,
                  //   initialTime: TimeOfDay.fromDateTime(endTimeTime),
                  // );
                  // if (picked != null && picked != TimeOfDay.fromDateTime(endTimeTime)) {
                  //   setState(() {
                  //     endTimeTime = DateTime.fromMicrosecondsSinceEpoch(picked.hour * 60 * 60 * 1000000 + picked.minute * 60 * 1000000, isUtc: true);
                  //     endTime = endTimeTime.hour.toString() + ":" + endTimeTime.minute.toString() + ((is24HoursFormat) ? "" : ((endTimeTime.hour > 12) ? "PM" : "AM"));
                  //   });
                  // }
                },
                child: const Text('Select End Time'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.attach_money, color: Colors.red),
              Text('Cost'),
            ],
          ),
          SizedBox(
            width: 150,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Price',
                hintStyle: TextStyle(color: Colors.white24, fontSize: 30),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<String> locations = [];
              User? user = auth.currentUser;
              values.forEach((key, value) {
                if (value == true) locations.add(key);
              });
              if (user != null) {
                Seller seller = Seller("", user.uid, locations, TimeRange(Timestamp.fromDate(startTimeTime), Timestamp.fromDate(endTimeTime)), double.parse(priceController.text));
                print("SIFSIFISFHJIS");
                print(seller);
                addSeller(seller);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
            ),
            child: const Text('Submit Sell Request'),
          ),
        ]),
      ),
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
