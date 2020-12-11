import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/comments.dart';

class CommentsModel {
  Future<DocumentReference> insertComment(Comment comment) async {
    DocumentReference reference;
    await FirebaseFirestore.instance
        .collection('comments')
        .add(comment.toMap())
        .then((value) => reference = value)
        .catchError((error) => print("Failed to add comment: $error"));

    return reference;
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

  Stream<DocumentSnapshot> streamPostComments(String id) {
    return FirebaseFirestore.instance.collection('posts').doc(id).snapshots();
  }

  Future<DocumentSnapshot> getComment(String id) async {
    return await FirebaseFirestore.instance
        .collection('comments')
        .doc(id)
        .get();
  }
}
