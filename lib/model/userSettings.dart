class UserSettings {
  int id;
  int fontSize;
  bool showImages;
  String login;
  int postCount;

  UserSettings({this.fontSize, this.showImages, this.login, this.postCount});

  UserSettings.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fontSize = map['fontSize'];
    this.showImages = intToBool(map['showImages']);
    this.login = map['login'];
    this.postCount = map['postCount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fontSize': this.fontSize,
      'showImages': boolToInt(this.showImages),
      'login': this.login,
      'postCount': this.postCount,
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
    return 'Font Size:$fontSize\nShow Images: $showImages\nLogin: $login\nPost Count: $postCount';
  }

  void setID(int id) {
    this.id = id;
  }
}
