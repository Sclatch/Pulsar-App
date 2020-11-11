import 'package:flutter/material.dart';

Widget pulseCard(BuildContext context, int index) {
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
                      onTap: (){print("GO TO THAT USER PROFILE");},
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
                              "Longagagagagagagagagagagagagagagagagagagagagagagagagagagagagagagagaga",
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
                icon: Icon(Icons.thumb_up),
                splashRadius: 20,
                onPressed: () {print("KEEP ON KEEPING ON");}
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
                icon: Icon(Icons.thumb_down),
                splashRadius: 20,
                splashColor: Colors.purple,
                onPressed: () {print("MEH");},
              )
            ]
          ),
        )
      ]
    )
    
  );
}