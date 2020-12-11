import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/pulse.dart';

import '../model/postsModel.dart';
import '../model/posts.dart';
import '../model/usersModel.dart';
import '../model/users.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String searchTerm = "";
  @override
  Widget build(BuildContext context) {
    final PostsModel postsModel = PostsModel();
    final UserModel usersModel = UserModel();

    return Container(
      child: Column(
        children: <Widget>[
          //SEARCH BAR
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(25.0))),
                isDense: true,
                hintText: "Search Keyword",
              ),
              style: TextStyle(fontSize: 20.0),
              onChanged: (text) {
                setState(() {
                  searchTerm = text;
                  print(searchTerm);
                });
              },
            ),
          ),
          //LISTVIEW OF THE RETURNED RESULT
          Expanded(
            child: FutureBuilder(
                //This is how you search for a post
                future: postsModel.getAllPosts(),
                builder: (context, snapshot) {
                  print("Rebuilding Search");

                  if (snapshot.hasData) {
                    List posts = snapshot.data.docs;

                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          //This is just to show the indexed post
                          DocumentSnapshot postDocument = posts[index];

                          //This takes a post from the database and makes it an instance of post
                          Post post = Post.fromMap(
                            postDocument.data(),
                            reference: postDocument.reference,
                          );

                          //If there is no search-term, display all posts
                          if (searchTerm == "" || searchTerm == null) {
                            return FutureBuilder(
                                //This is how you search for a post
                                future: usersModel.searchUser(post.user),
                                builder: (context, snapshot) {
                                  print("Building All");
                                  if (snapshot.hasData) {
                                    List users = snapshot.data.docs;

                                    DocumentSnapshot userDocument = users[0];

                                    User user = User.fromMap(
                                      userDocument.data(),
                                      reference: postDocument.reference,
                                    );

                                    return PulseCard(post: post, user: user);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          }
                          //if there /is/ a search-term...
                          else {
                            return FutureBuilder(
                                //This is how you search for a post
                                future: usersModel.searchUser(post.user),
                                builder: (context, snapshot) {
                                  print("Building based on Search Term");
                                  if (snapshot.hasData) {
                                    List users = snapshot.data.docs;

                                    DocumentSnapshot userDocument = users[0];

                                    User user = User.fromMap(
                                      userDocument.data(),
                                      reference: postDocument.reference,
                                    );
                                    //... and the post contains a match to the search term
                                    if (post.content.contains(searchTerm) ||
                                        post.user.contains(searchTerm)) {
                                      return PulseCard(post: post, user: user);
                                    }
                                    //.. or does not match
                                    else {
                                      return Container(
                                        color: Colors.transparent,
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
