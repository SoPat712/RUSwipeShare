import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class TimeRange {
  late Timestamp startTime;
  late Timestamp endTime;

  TimeRange(this.startTime, this.endTime);
}

class PriceRange {
  double low = 0;
  double high = 0;

  PriceRange(this.low, this.high);
}

class Seller implements Comparable<Seller> {
  String name = "";
  String uid = "";
  List<dynamic> location;
  TimeRange availableTime;
  int price;

  Seller(this.name, this.uid, this.location, this.availableTime, this.price);

  @override
  String toString() {
    return "Name: $name, Price: $price";
  }

  @override
  int compareTo(Seller other) {
    return name.compareTo(other.name);
  }
}

class Filter {
  List<String>? locations;
  PriceRange? price;
  TimeRange? meetingTime;

  Filter(this.locations, this.price, this.meetingTime);
}

Future<List<Seller>> getSellers(Filter filter) async {
  CollectionReference users = FirebaseFirestore.instance.collection('sellers');
  List<Seller> sellers = List.empty(growable: true);

  final Query query = users
      .where('location', arrayContainsAny: filter.locations)
      .where('price',
          isGreaterThanOrEqualTo: filter.price?.low,
          isLessThanOrEqualTo: filter.price?.high);

  final QuerySnapshot snapshot = await query.get();
  for (var doc in snapshot.docs) {
    sellers.add(Seller(doc["name"], doc["uid"], doc["location"],
        TimeRange(doc["start-time"], doc["end-time"]), doc["price"]));
  }
  return sellers;
}
