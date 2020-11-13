import 'dart:math';

import 'package:flutter/material.dart';
import '../model/posts.dart';
import '../model/postsModel.dart';
import '../model/users.dart';
import '../views/profilePage.dart';

Widget pulseCard(BuildContext context, int index, Post post, User user) {
  bool _isDislike = false;
  bool _isLike = false;
  PostsModel model = new PostsModel();
  return Container(
      padding: const EdgeInsets.all(5),
      child: Column(children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                        radius: 35, backgroundColor: Colors.blueGrey),
                    //ADD NAVIGATE HERE
                    onTap: () {
                      print("GO TO THAT USER PROFILE");

                    Navigator.push(context, PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return Center(child: ProfilePage(title: 'Profile', user: user));
                      },
                      transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(1.5, 0.0),
                          ).animate(CurvedAnimation(
                            parent: AnimationController(
                              duration: const Duration(seconds: 2),
                              vsync: this,
                            )..repeat(reverse: true);,
                            curve: Curves.elasticIn,
                          );,
                          child: child
                        );
                      }
                    ));
                    },
                  ),
                  SizedBox(width: 10),
                  //PROFILE HEADER & PULSE
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          //USERNAME
                          InkWell(child:
                            Text(post.user,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onTap: () {
                              print("GO TO THAT USER PROFILE");
                              Navigator.pushNamed(context, '/profilePage');
                            },
                          ),
                            SizedBox(height: 7),
                            //CONTENT OF PULSE
                            Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  post.content,
                                  style: TextStyle(fontSize: 17),
                                )),
                                                  ]),
                  )
                ]),
              ),
              Column(
                children: [
                  //DROPDOWN
                  PopupMenuButton(
                    icon: Icon(Icons.expand_more),
                    itemBuilder: (context) => [
                      //DELETE BUTTON
                      PopupMenuItem(
                        value: "delete",
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              SizedBox(width: 5),
                              Text("Delete")
                            ],
                          ),
                        )
                      ),
                      //JUST INCASE WE NEED SOMETHING MORE
                    ],
                    onCanceled: () {
                      //YOU CAN IGNORE THIS
                      print("You decided it's not worth your time");
                    },
                    onSelected: (value) {
                      //THIS IS FOR DELETE POST FUNCTION
                      print("DELETE $value");
                    },
                  ),
                  //NUMBER OF LIKES/DISLIKES
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[700],
                          borderRadius:
                              BorderRadius.all(const Radius.circular(15))),
                      //NUMBER
                      child: Text(
                        post.likes.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        //SHOWS PICTURE OR MEDIA
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.all(const Radius.circular(10))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(image: NetworkImage(post.image), fit: BoxFit.fitWidth,),
          )
          //Image(image: AssetImage(post.image),),
        ),
        //THIS IS PULSE BOTTOM FEED (LIKE/COMMENT/DISLIKE)
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //LIKE
                IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: (_isLike) ? Colors.lightBlue : Colors.white,
                    ),
                    splashRadius: 20,
                    onPressed: () {
                      /*setState(() {
                  });*/
                      if (_isLike = false) {
                        //adjust likes
                        if (_isDislike = true) {
                          post.likes += 2;
                        } else {
                          post.likes++;
                        }
                        //set like state
                        _isDislike = false;
                        _isLike = true;
                      } else {
                        //adjust likes and like state
                        post.likes--;
                        _isLike = false;
                      }
                      model.updatePost(post);
                    }),
                //COMMENT
                GestureDetector(
                  child: Container(
                      child: Row(children: <Widget>[
                    Icon(Icons.comment),
                    SizedBox(width: 3),
                    Text("150"),
                  ])),
                  onTap: () {
                    print("Write a Reply pop up");
                  },
                ),
                //DISLIKE
                IconButton(
                  icon: Icon(Icons.thumb_down,
                      color: (_isDislike) ? Colors.pink : Colors.white),
                  splashRadius: 20,
                  splashColor: Colors.purple,
                  onPressed: () {
                    /*setState(() {
                  });*/
                    if (_isDislike = false) {
                      //adjust likes
                      if (_isLike = true) {
                        post.likes -= 2;
                      } else {
                        post.likes--;
                      }
                      //set like state
                      _isLike = false;
                      _isDislike = true;
                    } else {
                      //adjust likes and like state
                      post.likes++;
                      _isDislike = false;
                    }
                    model.updatePost(post);
                  },
                )
              ]),
        )
      ]));
}
