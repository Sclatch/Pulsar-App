import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

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

  final model = UserSettingsModel();
  UserSettings userSettings;

  @override
  void initState() {
    super.initState();
    //LOADING THE USER's SETTINGS
    loadSettings();
  }

  Future<void> loadSettings() async {
    var _temp = await model.getAllUserSettings();

    setState(() {
      userSettings = _temp[0];
      if (userSettings.fontSize == null) {
        userSettings.fontSize = 14;
      }
      if (userSettings.showImages == null) {
        userSettings.showImages = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final UserSettingsModel userSettingsModel =
    //    Provider.of<UserSettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
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
                    value: userSettings.fontSize.toDouble(),
                    min: 10,
                    max: 20,
                    divisions: 5,
                    label: userSettings.fontSize.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        userSettings.fontSize = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
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
                  alignment: Alignment.centerRight,
                  child: Checkbox(
                    value: userSettings.showImages,
                    onChanged: (bool value) => setState(() {
                      userSettings.showImages = value;
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
            fontSize: userSettings.fontSize.round(),
            showImages: userSettings.showImages,
          );
          Navigator.of(context).pop(updatedUserSettings);
        },
        tooltip: 'Save Changes',
        child: Icon(Icons.save),
      ),
    );
  }
}
