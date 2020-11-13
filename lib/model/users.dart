import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String password;
  String description;
  Timestamp birthday;
  String image;
  DocumentReference reference;

  User(
      {this.username,
      this.password,
      this.description,
      this.image,
      this.birthday});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = this.reference.id;
    this.username = map['username'];
    this.password = map['password'];
    this.description = map['description'];
    this.image = map['image'];
    this.birthday = map['birthday'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
      'description': this.description,
      'image': this.image,
      'birthday': this.birthday,
    };
  }

  String toString() {
    return '$username $password $description $image $birthday';
  }

  void setID(String id) {
    this.id = id;
  }
}
