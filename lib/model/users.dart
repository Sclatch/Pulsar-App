import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String password;
  String description;
  DocumentReference reference;

  User({this.username, this.password, this.description});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = this.reference.id;
    this.username = map['username'];
    this.password = map['password'];
    this.description = map['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
      'description': this.description,
    };
  }

  String toString() {
    return '$username $password $description';
  }

  void setID(String id) {
    this.id = id;
  }
}
