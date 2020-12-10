import 'package:Pulsar/model/userSettingsModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import '../model/notifications.dart';
import '../model/postsModel.dart';
import '../model/userSettings.dart';
import '../model/usersModel.dart';
import '../model/users.dart';
import '../model/posts.dart';

class SendPulse extends StatefulWidget {
  SendPulse({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendPulseState createState() => _SendPulseState();
}

class _SendPulseState extends State<SendPulse> {
  String pulse = "";
  var _geolocator = Geolocator();
  LatLng centre;
  String address = "Loading...";
  String username;
  User user;
  Color sendButtonColor = Colors.grey;
  NetworkImage pfp;

  GeoPoint location;
  TextEditingController pulseTextController = TextEditingController();
  TextEditingController pulseImageURLController = TextEditingController();

  final _notifications = Notifications();

  @override
  void initState() {
    super.initState();
    _notifications.init();

    GPSEnabled(_geolocator).then((status) {
      if(status == true) {
        _geolocator
            .checkGeolocationPermissionStatus()
            .then((GeolocationStatus status) {
          print('Geolocation Status: $status');
        });
        
        _geolocator
            .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        )
            .then((Position userLocation) {
          centre = LatLng(userLocation.latitude, userLocation.longitude);

          _geolocator
              .placemarkFromCoordinates(
                  userLocation.latitude, userLocation.longitude)
              .then((List<Placemark> place) {
            setState(() {
              address = place[0].subThoroughfare + " " + place[0].thoroughfare;
              location = GeoPoint(place[0].position.latitude, place[0].position.longitude);
              sendButtonColor = Colors.blue;
            });
          });
        });
      }
      else {
        sendButtonColor = Colors.blue;
        address="Location Disabled";
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final UserModel usersModel = UserModel();
    final PostsModel postsModel = PostsModel();
    //CHECK IF USER IS LOGGED IN OR NOT
    return FutureBuilder(
        future: checkUserSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserSettings userSettings = snapshot.data;

            return FutureBuilder(
                future: usersModel.searchUser(userSettings.login),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User user;
                    if (snapshot.data.docs.isEmpty) {
                      username = null;
                      sendButtonColor = Colors.grey;
                    } else {
                      DocumentSnapshot userDocument = snapshot.data.docs[0];

                      user = User.fromMap(userDocument.data(),
                          reference: userDocument.reference);
                      username = user.username;
                      if(user.image != null){
                        pfp = NetworkImage(user.image);
                      }
                    }
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Colors.blueGrey,
                              backgroundImage: pfp,
                            ),
                          SizedBox(height: 10),
                          Text("Send a Pulse", textScaleFactor: 1.5),
                          SizedBox(height: 15),
                          TextField(
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                            controller: pulseTextController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.75),
                              ),
                              hintText: "What's on your mind?",
                              isDense: true,
                            ),
                            maxLines: 4,
                            //PLEASE WRITE THE FUNCTION HERE TO RETURN THE VALUE
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 0.5),
                          TextField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            controller: pulseImageURLController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.10),
                              ),
                              hintText: "Link to your Image",
                              isDense: true,
                            ),
                            maxLines: 1,
                            //PLEASE WRITE THE FUNCTION HERE FOR IMAGE
                            onChanged: (value) {},
                          ),
                          //GPS Location
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.place),
                                  SizedBox(width: 5),
                                  Text(
                                    "$address",
                                    textScaleFactor: 1.25,
                                  )
                                ]),
                          ),
                          //SEND BUTTON
                          Container(
                              padding: const EdgeInsets.only(top: 5),
                              width: 325,
                              child: RaisedButton(
                                color: sendButtonColor, //button color
                                child: Text(
                                  "Send",
                                  style: TextStyle(fontSize: 20,),
                                ),
                                onPressed: () {
                                  //if the location data has been obtained
                                  if (address != "Loading..." && username != null) {
                                    print("Send something");


                                    postsModel.insertPost(
                                      Post(
                                        user: username,
                                        content: pulseTextController.text,
                                        image: pulseImageURLController.text,
                                        comments: List(),
                                        date:
                                            Timestamp.fromDate(DateTime.now()),
                                        location: location,
                                        address: address,
                                        likes: 0,
                                        dislikes: 0,
                                      ),
                                    );
                                    pulseTextController.text="";
                                    pulseImageURLController.text="";
                                    _notifications.sendNotificationNow(
                                        "Post Sent", "", "");
                                    final snackBar = SnackBar(
                                      content: Text(
                                        "Pulse Sent!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17),
                                      ),
                                      backgroundColor: Colors.grey[900],
                                    );

                                    Scaffold.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                              )),
                          ],
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Future<UserSettings> checkUserSettings() async {
  final userSettingsModel = UserSettingsModel();
  UserSettings userSettings;

  var _temp = await userSettingsModel.getUserSettingsWithId(1);

  if (_temp == null) {
    userSettings = UserSettings(fontSize: 14, showImages: true, login: null);
  } else {
    userSettings = _temp;
  }

  userSettings.setID(1);

  userSettingsModel.updateUserSettings(userSettings);

  return userSettings;
}

Future<bool> GPSEnabled(geolocator) async {
  return (await geolocator.isLocationServiceEnabled());
}