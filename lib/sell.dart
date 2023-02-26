import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  Map<String, bool> values = {
    'Busch Dining Hall': false,
    'Livingston Dining Hall': false,
    'Brower Dining Hall': false,
    'Neilson Dining Hall': false,
    'Cafe West': false,
    'Cook Cafe': false,
    'Douglass Cafe': false,
    'Harvest INFH': false,
    'Kilmer\'s Market': false,
    'College Ave Dining Hall': false,
    'Red Pine Pizza': false,
    'Rock Cafe': false,
    'Sbarro': false,
    'Woody\'s Cafe': false,
  };
  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory, color: Colors.red),
          const Text('Place'),
          ConstrainedBox(
            constraints: BoxConstraints.expand(height: 100),
            child: ListView(
              children: values.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: values[key],
                  onChanged: (bool? value) {
                    setState(() {
                      values[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          LocationDropdown(),
          Icon(Icons.access_time, color: Colors.red),
          Expanded(
            child: const Text('Time'),
          ),
          ListTile(
            title: Text(time.format(context)),
            onTap: () {
              Future<TimeOfDay?> selectedTime = showTimePicker(
                context: context,
                initialTime: time,
              );
              setState(() {
                selectedTime.then((value) => time = value!);
                time = TimeOfDay(hour: 10, minute: 00);
              });
            },
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

const List<String> list = <String>['Brower', 'BDH', 'LDH', 'Neilson', 'Woody\'s'];

class LocationDropdown extends StatefulWidget {
  const LocationDropdown({super.key});

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  String dropdownValue = list.first;

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
