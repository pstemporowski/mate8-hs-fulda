import 'package:cloud_firestore/cloud_firestore.dart';

class DBProfile {
  String? firstname;
  String? lastname;
  int? age;
  String? description;
  String? degree;
  String? imageLink;

  DBProfile(
      {this.firstname,
      this.lastname,
      this.age,
      this.description,
      this.degree,
      this.imageLink});

  factory DBProfile.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DBProfile(
      firstname: data?['firstname'],
      lastname: data?['lastname'],
      age: data?['age'],
      description: data?['description'],
      degree: data?['degree'],
      imageLink: data?['imageLink'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstname != null) "lastname": firstname,
      if (lastname != null) "lastname": lastname,
      if (age != null) "age": age,
      if (description != null) "description": description,
      if (degree != null) "degree": degree,
      if (imageLink != null) "imageLink": imageLink,
    };
  }
}
