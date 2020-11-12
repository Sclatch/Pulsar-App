import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/pulse.dart';
import '../model/postsModel.dart';
import '../model/posts.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final PostsModel postsModel = PostsModel();
    String searchTerm = 'A New Post';
    return Container(
      child: Column(children: <Widget>[
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
            //PLEASE ADD THE FUNCTION TO RETURN THE VALUE
          ),
        ),
        //LISTVIEW OF THE RETURNED RESULT
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.68,
            child: FutureBuilder(
                //This is how you search for a post
                future: postsModel.searchPost(searchTerm),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List posts = snapshot.data.docs;

                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          //This is just to show the indexed post
                          DocumentSnapshot postDocument = posts[index];

                          //This takes a post from the database and makes it an instance of post
                          final post = Post.fromMap(postDocument.data(),
                              reference: postDocument.reference);

                          print(post);

                          return pulseCard(context, index);
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }))
      ]),
    );
  }
}
