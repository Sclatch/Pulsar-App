class UserSettings {
  int id;
  int fontSize;
  bool showImages;

  UserSettings({this.fontSize, this.showImages});

  UserSettings.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fontSize = map['fontSize'];
    this.showImages = intToBool(map['showImages']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fontSize': this.fontSize,
      'showImages': boolToInt(this.showImages),
    };
  }

  int boolToInt(bool val) {
    if (val == true) {
      return 1;
    } else {
      return 0;
    }
  }

  bool intToBool(int val) {
    if (val == 1) {
      return true;
    } else {
      return false;
    }
  }

  String toString() {
    return 'Font Size: $fontSize\nShow Images: $showImages';
  }

  void setID(int id) {
    this.id = id;
  }
}
