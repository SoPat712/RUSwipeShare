import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class TimeRange {
  late DateTime startTime;
  late DateTime endTime;

  TimeRange(this.startTime, this.endTime);
}

class Seller {
  String name = "";
  String uid = "";
  String location = "";
  TimeRange availableTime;
  Int64 price;

  Seller(this.name, this.uid, this.location, this.availableTime, this.price);
}

class Filter {
  String? location;
  Int64? price;
  TimeRange? meetingTime;

  Filter(this.location, this.price, this.meetingTime);
}

Future<List<Seller>> getSellers(Filter filter) async {
  CollectionReference users = FirebaseFirestore.instance.collection('sellers');
  List<Seller> sellers = List.empty();

  final Query query = users
      .where('location', isEqualTo: filter.location)
      .where('price', isEqualTo: filter.price)
      .where('start-time',
          isGreaterThanOrEqualTo: filter.meetingTime?.startTime)
      .where('end-time', isLessThanOrEqualTo: filter.meetingTime?.endTime);

  final QuerySnapshot snapshot = await query.get();
  for (var doc in snapshot.docs) {
    sellers.add(Seller(doc["name"], doc["uid"], doc["location"],
        TimeRange(doc["start-time"], doc["end-time"]), doc["price"]));
  }
  return sellers;
}
