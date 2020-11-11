import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'comments.dart';

class CommentsModel {
  Future<void> insertComment(Comment comment) async {
    return await FirebaseFirestore.instance
        .collection('comments')
        .add(comment.toMap())
        .then((value) => print("Comment Added"))
        .catchError((error) => print("Failed to add comment: $error"));
  }

  Future<void> updateComment(Comment comment) {
    return FirebaseFirestore.instance
        .collection('comments')
        .doc(comment.id)
        .update(comment.toMap())
        .then((value) => print("Comment Updated"))
        .catchError((error) => print("Failed to update comment: $error"));
  }

  Future<void> deleteCommentWithId(String id) {
    return FirebaseFirestore.instance
        .collection('comments')
        .doc(id)
        .delete()
        .then((value) => print("Comment Deleted"))
        .catchError((error) => print("Failed to delete comment: $error"));
  }

  Future<QuerySnapshot> getAllComments() async {
    return await FirebaseFirestore.instance.collection('comments').get();
  }

  Stream<QuerySnapshot> streamAllComments() {
    return FirebaseFirestore.instance.collection('comments').snapshots();
  }

  Future<DocumentSnapshot> getComment(String id) async {
    return await FirebaseFirestore.instance
        .collection('comments')
        .doc(id)
        .get();
  }
}
