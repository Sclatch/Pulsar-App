//import 'dart:math';

import 'package:flutter/material.dart';
import '../model/posts.dart';
import '../model/postsModel.dart';
import '../model/users.dart';
import '../views/profilePage.dart';
import '../views/statsPost.dart';
import '../views/mapPage.dart';
import '../views/commentPage.dart';

class PulseCard extends StatefulWidget {
  PulseCard({Key key, this.post, this.user}) : super(key: key);
  final User user;
  final Post post;

  @override
  _PulseCardState createState() => _PulseCardState(post: post, user: user);
}


class _PulseCardState extends State<PulseCard> {
  final Post post;
  final User user;
  bool _isDislike = false;
  bool _isLike = false;

  _PulseCardState ({this.post, this.user});

  @override
  Widget build(BuildContext context) {
  PostsModel model = new PostsModel();
  NetworkImage pfp;
  DateTime time = post.toDate();

  if(user.image != null) {
    pfp = NetworkImage(user.image);
  }

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
                      radius: 35,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: pfp,
                    ),
                    //CLICK PFP TO GO TO THE USER PROFILE
                    onTap: () {
                    Navigator.push(context, PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return Center(child: ProfilePage(title: 'Profile', user: user, fromDrawer:false));
                      },
                      transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                        return child;
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

                          Navigator.push(context, PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return Center(child: ProfilePage(title: 'Profile', user: user));
                            },
                            transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                              return child;
                            }
                          ));
                          },
                        ),
                        SizedBox(height: 7),
                        //CONTENT OF PULSE
                        Container(
                          width: MediaQuery.of(context).size.width * 0.62,
                          child: Text(
                            post.content,
                            style: TextStyle(fontSize: 18),
                          )
                        ),
                      ]
                    ),
                  )
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //DROPDOWN
                  Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: PopupMenuButton(
                      icon: Icon(Icons.expand_more),
                      itemBuilder: (context) => [
                        //LOCATION
                        PopupMenuItem(
                          value: "loc",
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.place),
                                SizedBox(width: 5),
                                Text("Location")
                              ],
                            ),
                          )
                        ),

                        //ANALYTIC
                        PopupMenuItem(
                          value: "stats",
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.insert_chart),
                                SizedBox(width: 5),
                                Text("Analytic")
                              ],
                            ),
                          )
                        ),

                        /*//DELETE BUTTON
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
                        ),*/
                        
                        //JUST INCASE WE NEED SOMETHING MORE
                      ],
                      onCanceled: () {
                        //YOU CAN IGNORE THIS
                        print("You decided it's not worth your time");
                      },
                      onSelected: (value) {
                        //THIS IS FOR POST FUNCTION
                        //SEE ANALYTICS
                        print("$value");
                        if (value == 'stats') {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => PostStatPage(post: post))
                          );
                        }

                        //SEE LOCATION
                        if (value == 'loc'){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MapPage(post: post))
                          );
                        }
                      },
                    )
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
                      "${post.likes - post.dislikes}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 3,
                    top: 2,
                    bottom: 2,
                    right: 10
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    borderRadius: BorderRadius.all(const Radius.circular(10))
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.place),
                      Text(
                        " ${post.address}",
                        style: TextStyle(
                          fontSize: 16
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  //TAP TO GO TO THE LOCATION OF WHERE IT GOT POSTED
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MapPage(post: post))
                  );
                },
              ),
              Text(
                "${time.year} / ${time.month} / ${time.day}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                )
              )
            ],
          )
        ),
        //SHOWS PICTURE OR MEDIA
        Container(
          width: MediaQuery.of(context).size.width * 0.97,
          height: 225,
          decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.all(const Radius.circular(15))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(image: NetworkImage(post.image), fit: BoxFit.cover,),
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
                  if (!_isLike) {
                    post.likes++;
                    if(_isDislike) {
                      post.dislikes--;
                    }
                    _isLike=true;
                  }
                  else if(_isLike) {
                    post.likes--;
                    _isLike=false;
                  }
                  _isDislike = false;
                  
                  setState(() {
                    model.updatePost(post);
                  });
                  
                }),
                //COMMENT
                GestureDetector(
                  child: Container(
                      child: Row(children: <Widget>[
                    Icon(Icons.comment),
                    SizedBox(width: 5),
                    Text(
                      "${post.comments.length}",
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),
                  ])),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(post: post)
                      )
                    );
                  },
                ),
                //DISLIKE
                IconButton(
                  icon: Icon(Icons.thumb_down,
                      color: (_isDislike) ? Colors.purple : Colors.white),
                  splashRadius: 20,
                  splashColor: Colors.purple,
                  onPressed: () {
                    /*setState(() {
                  });*/
                    if (!_isDislike) {
                      post.dislikes++;
                      if(_isLike) {
                        post.likes--;
                      }
                      _isDislike=true;
                    }
                    else if(_isDislike) {
                      post.dislikes--;
                      _isDislike=false;
                    }
                    _isLike = false;

                    setState(() {
                      model.updatePost(post);
                    });
                  },
                )
              ]),
        )
      ]));
  }
}
