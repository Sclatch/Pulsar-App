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
  //String searchTerm = 'Reposting';
  //TextEditingController searchController = TextEditingController(text: "Reposting");

  @override
  Widget build(BuildContext context) {
    //TextEditingController searchController;
    final PostsModel postsModel = PostsModel();
    final UserModel usersModel = UserModel();
    String searchTerm;

    return Container(
      child: Column(children: <Widget>[
        //SEARCH BAR
        Container(
          padding: const EdgeInsets.all(15),
          child: TextField(
            //controller: searchController,
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
            onChanged: (text) {
              setState(() {
                //searchTerm=searchController.text;
                searchTerm = text;
                print(searchTerm);
              });
            },
          ),
        ),
        //LISTVIEW OF THE RETURNED RESULT
        Expanded(
            //padding: const EdgeInsets.symmetric(horizontal: 10),
            //width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height * 0.68,
            child: FutureBuilder(
                //This is how you search for a post
                future: postsModel.searchPost(searchTerm),
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
                          Post post = Post.fromMap(postDocument.data(),
                              reference: postDocument.reference);

                          return FutureBuilder(
                              //This is how you search for a post
                              future: usersModel.searchUser(post.user),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List users = snapshot.data.docs;

                                  DocumentSnapshot userDocument = users[0];

                                  User user = User.fromMap(userDocument.data(),
                                      reference: postDocument.reference);

                                  return PulseCard(post: post, user: user);
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
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
