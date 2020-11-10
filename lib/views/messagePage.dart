import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 3), 
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.blueGrey,
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 50,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              //USERNAME TEXT HERE
                              "Username",
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            //MESSAGE TEXT HERE
                            Text("Message")
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          //PUT HOW LONG THE MESSAGE WAS LAST SENT HERE
                          "6h",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey
                          )
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[700],
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15)
                            )
                          ),
                          child: Text(
                            //NOTIFICATIONS ON HOW MANY MESSAGES UNREAD
                            "150",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          )
                        )
                      ],
                    )
                  )
                ],
              )
            ),
            //FUNCTION TO EXPAND CHAT MESSAGE. NAVIGATE PUSH
            onTap: () {print("Navigate to message page");},
          );
        },
      )
    );
  }
}