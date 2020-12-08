import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class Post {
  String id;
  String user;
  String title;
  String content;
  String image;
  List comments;
  Timestamp date;
  GeoPoint location;
  int likes;
  int dislikes;

  DocumentReference reference;

  Post(
      {this.user,
      this.title,
      this.content,
      this.image,
      this.comments,
      this.date,
      this.location,
      this.likes,
      this.dislikes});

  Post.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = this.reference.id;
    this.user = map['user'];
    this.title = map['title'];
    this.content = map['content'];
    this.image = map['image'];
    this.comments = map['comments'];
    this.date = map['date'];
    this.location = map['location'];
    this.likes = map['likes'];
    this.dislikes = map['dislikes'];
  }

  Map<String, dynamic> toMap() {
    return {
      'user': this.user,
      'title': this.title,
      'content': this.content,
      'image': this.image,
      'comments': this.comments,
      'date': this.date,
      'location': this.location,
      'likes': this.likes,
      'dislikes': this.dislikes,
    };
  }

  String toString() {
    return '$user $title $content $image $comments $date $location $likes $dislikes';
  }

  int totalLikes() {
    return this.likes - this.dislikes;
  }

  LatLng getLatLng() {
    return LatLng(this.location.latitude, this.location.longitude);
  }

  void setID(String id) {
    this.id = id;
  }
}
