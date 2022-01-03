import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String nrc;
  final String address;
  final String age;
  final String img;
  final num lat;
  final num log;
  final String name;
  final String phone;
  User(
      {required this.nrc,
      required this.address,
      required this.age,
      required this.img,
      required this.lat,
      required this.log,
      required this.name,
      required this.phone});

  Map<String, dynamic> toJson() => {
        "nrc": nrc,
        "address": address,
        "age": age,
        "img": img,
        "lat": lat,
        "log": log,
        "name": name,
        "phone": phone
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);

    return User(
        nrc: snapshot['nrc'],
        address: snapshot['address'],
        age: snapshot['age'],
        img: snapshot['img'],
        lat: snapshot['lat'],
        log: snapshot['log'],
        name: snapshot['name'],
        phone: snapshot['phone']);
  }
}
