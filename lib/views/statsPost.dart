import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../model/posts.dart';

class PostStatPage extends StatefulWidget {
  PostStatPage({Key key, this.title, this.post}) : super(key: key);

  final Post post;
  final String title;

  @override
  _PostStatPageState createState() => _PostStatPageState(post: post);
}

class _PostStatPageState extends State<PostStatPage> {

  final Post post;
  List<charts.Series> seriesList;
  _PostStatPageState({this.post});

  @override
  Widget build(BuildContext context) {
    final seriesList = _createStats(post);
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Analytics"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: new charts.PieChart(
                seriesList,
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 40,
                  startAngle: 4/5 * 3.14,
                  arcLength: 7/5 * 3.14,
                  arcRendererDecorators: [
                    new charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside,
                      insideLabelStyleSpec: charts.TextStyleSpec(
                        fontSize: 20,
                        color: charts.Color.white
                      )
                    )
                  ]
                )
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.blue
                        ),
                        Text(
                          " Likes",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ],
                    )
                  ),
                  
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.red
                        ),
                        Text(
                          " Dislikes",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ],
                    )
                  ),

                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.purple
                        ),
                        Text(
                          " Comments",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ],
                    )
                  ),
                ]
              )
            )
          ],
        )
      )
    );
  }

  //THIS IS JUST FOR VISUAL TEST
  static List<charts.Series<PostTest, String>> _createStats(Post post) {

    final data = [
      PostTest("Likes", post.likes, charts.MaterialPalette.blue.shadeDefault),
      PostTest("Dislikes", post.dislikes, charts.MaterialPalette.red.shadeDefault),
      PostTest("Comments", post.comments.length, charts.MaterialPalette.purple.shadeDefault)
    ];

    return [
      new charts.Series<PostTest, String>(
        id: 'Post',
        domainFn: (PostTest test, _) => test.name,
        measureFn: (PostTest test, _) => test.value,
        colorFn: (PostTest test, _) => test.color,
        labelAccessorFn: (PostTest test, _) => '${test.value}',
        data: data,
      )
    ];
  }
}

class PostTest {
  final String name;
  final int value;
  final charts.Color color;

  PostTest(this.name, this.value, this.color);
}
