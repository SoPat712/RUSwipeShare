import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class TimeRange {
  late DateTime startTime;
  late DateTime endTime;

  TimeRange(this.startTime, this.endTime);
}

class PriceRange {
  int low = 0;
  int high = 0;

  PriceRange(this.low, this.high);
}

class Seller {
  String name = "";
  String uid = "";
  List<String> location;
  TimeRange availableTime;
  int price;

  Seller(this.name, this.uid, this.location, this.availableTime, this.price);
}

class Filter {
  List<String>? locations;
  PriceRange? price;
  TimeRange? meetingTime;

  Filter(this.locations, this.price, this.meetingTime);
}

Future<List<Seller>> getSellers(Filter filter) async {
  CollectionReference users = FirebaseFirestore.instance.collection('sellers');
  List<Seller> sellers = List.empty();

  final Query query = users
      .where('location', arrayContainsAny: filter.locations)
      .where('price',
          isGreaterThanOrEqualTo: filter.price?.low,
          isLessThanOrEqualTo: filter.price?.high)
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
