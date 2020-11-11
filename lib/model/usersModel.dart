import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'users.dart';

class UserModel {
  Future<void> insertUser(User user) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(User user) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUserWithId(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<QuerySnapshot> getAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  Future<DocumentSnapshot> getUser(String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).get();
  }
}
