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
  String? name = "Unknown Seller";
  String uid = "";
  List<dynamic> location;
  TimeRange availableTime;
  double price;

  Seller(this.name, this.uid, this.location, this.availableTime, this.price);

  @override
  String toString() {
    return "Name: $name, Price: $price";
  }

  @override
  int compareTo(Seller other) {
    return price.compareTo(other.price);
  }
}

class Filter {
  List<String>? locations;
  PriceRange? price;
  TimeRange? meetingTime;

  Filter(this.locations, this.price, this.meetingTime);
}

List<Seller> fetchNSellers(int n) {
  List<Seller> sellers = List.empty(growable: true);
  CollectionReference users = FirebaseFirestore.instance.collection('sellers');
  users.get().then((value) => () {
        for (var doc in value.docs) {
          sellers.add(Seller(doc["name"], doc["uid"], doc["location"],
              TimeRange(doc["start-time"], doc["end-time"]), doc["price"]));
        }
      });
  return sellers;
}

void addSeller(Seller seller) async {
  final CollectionReference sellers =
      FirebaseFirestore.instance.collection('sellers');
  return await sellers
      .add({
        'name': seller.name,
        'uid': seller.uid,
        'price': seller.price,
        'start-time': seller.availableTime.startTime,
        'end-time': seller.availableTime.endTime,
        'location': seller.location,
      })
      .then((value) => print(""))
      .catchError((error) => print("ERROR ADDING DATA: $error"));
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
  final startTime = filter.meetingTime?.endTime;
  final endTime = filter.meetingTime?.startTime;

  if (startTime != null && endTime != null) {
    var docs = snapshot.docs
        .where((element) =>
            startTime.compareTo(element["start-time"]) > 0 ||
            element["start-time"] == (startTime))
        .where((element) =>
            endTime.compareTo(element["end-time"]) < 0 ||
            element["end-time"] == (endTime));
    for (var doc in docs) {
      sellers.add(Seller(doc["name"], doc["uid"], doc["location"],
          TimeRange(doc["start-time"], doc["end-time"]), doc["price"]));
    }
  } else {
    for (var doc in snapshot.docs) {
      sellers.add(Seller(doc["name"], doc["uid"], doc["location"],
          TimeRange(doc["start-time"], doc["end-time"]), doc["price"]));
    }
  }
  return sellers;
}
