import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';

class UpdateUserSettingsWidget extends StatefulWidget {
  UpdateUserSettingsWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UpdateUserSettingsWidgetState createState() =>
      _UpdateUserSettingsWidgetState();
}

class _UpdateUserSettingsWidgetState extends State<UpdateUserSettingsWidget> {
  final _formKey = GlobalKey<FormState>();

  double _fontSize = 14;
  bool _showImages = true;

  @override
  Widget build(BuildContext context) {
    final UserSettingsModel userSettingsModel =
        Provider.of<UserSettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Font Size:",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  alignment: Alignment.center,
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 20,
                    divisions: 5,
                    label: _fontSize.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Show Images:",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  alignment: Alignment.center,
                  child: Checkbox(
                    value: _showImages,
                    onChanged: (bool value) => setState(() {
                      _showImages = value;
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserSettings updatedUserSettings = UserSettings(
            fontSize: _fontSize.round(),
            showImages: _showImages,
          );
          Navigator.of(context).pop(updatedUserSettings);
        },
        tooltip: 'Save Changes',
        child: Icon(Icons.save),
      ),
    );
  }
}
