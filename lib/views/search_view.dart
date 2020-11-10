import 'package:flutter/material.dart';

import '../widgets/pulse.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //SEARCH BAR
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(25.0)
                  )
                ),
                isDense: true,
                hintText: "Search Keyword",
              ),
              style: TextStyle(fontSize: 20.0),
              //PLEASE ADD THE FUNCTION TO RETURN THE VALUE
            ),
          ),
          //LISTVIEW OF THE RETURNED RESULT
          Container(
            width: MediaQuery.of(context).size.width,
            height: 550,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return pulseCard(context, index);
              }
            ),
          )
        ]
      ),
    );
  }
}