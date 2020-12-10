import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class User {
  String id;
  String username;
  String password;
  String description;
  String image;
  String background;
  Timestamp birthday;
  int postsSeen;
  DocumentReference reference;

  User(
      {this.username,
      this.password,
      this.description,
      this.image,
      this.background,
      this.birthday,
      this.postsSeen});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = this.reference.id;
    this.username = map['username'];
    this.password = map['password'];
    this.description = map['description'];
    this.image = map['image'];
    this.background = map['background'];
    this.birthday = map['birthday'];
    this.postsSeen = map['postsSeen'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
      'description': this.description,
      'image': this.image,
      'background': this.background,
      'birthday': this.birthday,
      'postsSeen': this.postsSeen,
    };
  }

  String toString() {
    return '$username $password $description $image $background $birthday $postsSeen';
  }

  String timeToDate() {
    var fullDate =
        DateTime.fromMillisecondsSinceEpoch(this.birthday.seconds * 1000);

    var date = DateFormat.yMMMd().format(fullDate);
    return date;
  }

  Timestamp dateToTime(DateTime date) {
    return Timestamp.fromDate(date);
  }

  void setID(String id) {
    this.id = id;
  }
}
