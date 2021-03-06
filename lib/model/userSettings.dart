class UserSettings {
  int id;
  int fontSize;
  bool showImages;
  String login;
  String language;

  UserSettings({this.fontSize, this.showImages, this.login, this.language});

  UserSettings.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fontSize = map['fontSize'];
    this.showImages = intToBool(map['showImages']);
    this.login = map['login'];
    this.language = map['language'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fontSize': this.fontSize,
      'showImages': boolToInt(this.showImages),
      'login': this.login,
      'language': this.language,
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
    return 'Font Size:$fontSize\nShow Images: $showImages\nLogin: $login';
  }

  void setID(int id) {
    this.id = id;
  }
}
