import 'package:flutter/material.dart';
import '../model/postsModel.dart';
import '../model/posts.dart';

Widget pulseCard(BuildContext context, int index) {
  bool _isDislike = false;
  bool _isLike = false;
  PostsModel postModel = new PostsModel();
  return Container(
    padding: const EdgeInsets.all(5),
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blueGrey
                      ),
                      //ADD NAVIGATE HERE
                      onTap: (){
                        print("GO TO THAT USER PROFILE");
                        Navigator.pushNamed(context, '/userProfile');
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
                          Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 7),
                          //CONTENT OF PULSE
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Text(
                              "Lorem Ipsum Pulse Post Text Content",
                              style: TextStyle(
                                fontSize: 17
                              ),
                            )
                          )
                        ]
                      ),
                    )
                  ]
                ),
              ),
              Column(
                children: [
                  //DROPDOWN
                  IconButton(
                    icon: Icon(Icons.expand_more),
                    splashRadius: 1,
                    onPressed: () {
                      //DROPDOWN FUNCTION
                      print("idk dropdown or something lol");
                    }
                  ),
                  //NUMBER OF LIKES/DISLIKES
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[700],
                      borderRadius: BorderRadius.all(
                        const Radius.circular(15)
                      )
                    ),
                    //NUMBER
                    child: Text(
                      "237",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
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
            borderRadius: BorderRadius.all(
              const Radius.circular(10)
            )
          ),
        ),
        //THIS IS PULSE BOTTOM FEED (LIKE/COMMENT/DISLIKE)
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //LIKE
              IconButton(
                icon: Icon(Icons.thumb_up, color: (_isLike) ? 
                          Colors.lightBlue : Colors.white,),
                splashRadius: 20,
                onPressed: () {
                  /*setState(() {
                  });*/
                  Post post = postModel.postFromSnapshot(index.toString());
                  if(_isLike = false) {
                    //adjust likes
                    if(_isDislike = true) {
                      post.likes+=2;
                    }
                    else {
                      post.likes++;
                    }
                    //set like state
                    _isDislike = false;
                    _isLike = true;
                  }
                  else {
                    //adjust likes and like state
                    post.likes--;
                    _isLike = false;
                  }
                  postModel.updatePost(post);
                }
              ),
              //COMMENT
              GestureDetector(
                child: Container(
                  child: Row(
                    children: <Widget> [
                      Icon(Icons.comment),
                      SizedBox(width: 3),
                      Text("150"),
                    ]
                  )
                ),
                onTap: () {print("Write a Reply pop up");},
              ),
              //DISLIKE
              IconButton(
                icon: Icon(Icons.thumb_down, color:(_isDislike) ?
                          Colors.pink : Colors.white),
                splashRadius: 20,
                splashColor: Colors.purple,
                onPressed: () {
                  /*setState(() {
                  });*/
                  Post post = postModel.postFromSnapshot(index.toString());
                  if(_isDislike = false) {
                    //adjust likes
                    if(_isLike = true) {
                      post.likes-=2;
                    }
                    else {
                      post.likes--;
                    }
                    //set like state
                    _isLike = false;
                    _isDislike = true;
                  }
                  else {
                    //adjust likes and like state
                    post.likes++;
                    _isDislike = false;
                  }
                  postModel.updatePost(post);
                },
              )
            ]
          ),
        )
      ]
    )
    
  );
}