import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String user;
  String text;
  DocumentReference reference;

  Comment({this.user, this.text});

  Comment.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = this.reference.id;
    this.user = map['user'];
    this.text = map['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'user': this.user,
      'text': this.text,
    };
  }

  String toString() {
    return '$user $text';
  }

  void setID(String id) {
    this.id = id;
  }
}
