import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay _time = TimeOfDay.now();
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
          ListTile(
            title: Text(_time.format(context)),
            onTap: () {
              Future<TimeOfDay?> selectedTime = showTimePicker(
                context: context,
                initialTime: _time,
              );
              setState(() {
                selectedTime.then((value) => _time = value!);
                _time = TimeOfDay(hour: 10, minute: 00);
              });
            },
          ),
          LocationDropdown(),
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

const List<String> list = <String>[
  'Brower',
  'BDH',
  'LDH',
  'Neilson',
  'Woody\'s'
];

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
