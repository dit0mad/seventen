import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  Address? address;

  User({this.name, this.email, this.password, this.address, this.id});

  User.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    address = Address.fromJson(documentSnapshot['address']);
  }
}

class Address {
  String? street;
  String? addressLine2;
  String? country;
  String? state;
  String? city;
  int? postalCode;
  int? phoneNumber;

  Address(
      {this.street,
      this.addressLine2,
      this.city,
      this.country,
      this.phoneNumber,
      this.postalCode,
      this.state});

  Address.fromJson(Map doc) {
    street = doc['street'];
    addressLine2 = doc['addressLine2'];
    city = doc['city'];
    country = doc['country'];
    phoneNumber = doc['phoneNumber'];
    postalCode = doc['postalCode'];
    state = doc['state'];
  }

  Map<String, dynamic> toJson() => {
        'street': street,
        'addressLine2': addressLine2,
        'city': city,
        'country': country,
        'phoneNumber': phoneNumber,
        'postalCode': postalCode,
        'state': state,
      };
}
