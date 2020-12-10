import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'posts.dart';

class PostsModel {
  Future<void> insertPost(Post post) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  Future<void> updatePost(Post post) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update(post.toMap())
        .then((value) => print("Post Updated"))
        .catchError((error) => print("Failed to update post: $error"));
  }

  Future<void> deletePostWithId(String id) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .delete()
        .then((value) => print("Post Deleted"))
        .catchError((error) => print("Failed to delete post: $error"));
  }

  Future<QuerySnapshot> getAllPosts() async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .get();
  }

  Stream<QuerySnapshot> streamAllPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getPost(String id) async {
    return await FirebaseFirestore.instance.collection('posts').doc(id).get();
  }

  Future<QuerySnapshot> searchPost(String term) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .where('content', isGreaterThanOrEqualTo: term)
        //.where('content', isEqualTo: term)
        //.orderBy('date')
        .get();
  }

  Future<QuerySnapshot> searchPostUser(String name) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .where('user', isEqualTo: name)
        //.orderBy('date')
        .get();
  }
}
