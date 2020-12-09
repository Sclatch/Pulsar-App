import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../model/posts.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title, this.post}) : super(key: key);

  final Post post;
  final String title;

  @override
  _MapPageState createState() => _MapPageState(post: post);
}

class _MapPageState extends State<MapPage> {

  final Post post;
  _MapPageState({this.post});

  LatLng centre;

  @override 
  void initState() {
    super.initState();

    centre = post.getLatLng();
    print(centre);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Location"),
      ),
      body: FlutterMap(
        options: MapOptions(
          maxZoom: 18.0,
          center: centre
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/sclatch/ckhv2ys2u00g719p6igel83x8/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2NsYXRjaCIsImEiOiJja2h2MjFzZHYwemJ4MnpvbGl3dGFuZHVxIn0.Um4qxkHCobF3UV04FAjqXQ",
            additionalOptions: {
              'accessToken': 'pk.eyJ1Ijoic2NsYXRjaCIsImEiOiJja2h2Mjg0Y28wN2lpMnptb2NzMmhnZjk2In0.3CMov6VTdJ0w6iUE3AAUZQ',
              'id' : 'mapbox.mapbox-streets-v8',
            }
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: centre,
                anchorPos: AnchorPos.exactly(Anchor(15,5)),
                builder: (context) => Container(
                  child: Icon(
                    Icons.place,
                    color: Colors.blue
                  )
                )
              )
            ]
          )
        ],
      )
    );
  }
}
