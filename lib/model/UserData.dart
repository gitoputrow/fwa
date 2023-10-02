class UserData {
  List<ChallangeData>? _challangeData;
  String? _gender;
  String? _height;
  String? _name;
  String? _pass;
  String? _photoprofile;
  String? _username;
  String? _weight;

  UserData(
      {List<ChallangeData>? challangeData,
      String? gender,
      String? height,
      String? name,
      String? pass,
      String? photoprofile,
      String? username,
      String? weight}) {
    if (challangeData != null) {
      this._challangeData = challangeData;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (height != null) {
      this._height = height;
    }
    if (name != null) {
      this._name = name;
    }
    if (pass != null) {
      this._pass = pass;
    }
    if (photoprofile != null) {
      this._photoprofile = photoprofile;
    }
    if (username != null) {
      this._username = username;
    }
    if (weight != null) {
      this._weight = weight;
    }
  }

  List<ChallangeData>? get challangeData => _challangeData;
  set challangeData(List<ChallangeData>? challangeData) =>
      _challangeData = challangeData;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get height => _height;
  set height(String? height) => _height = height;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get pass => _pass;
  set pass(String? pass) => _pass = pass;
  String? get photoprofile => _photoprofile;
  set photoprofile(String? photoprofile) => _photoprofile = photoprofile;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get weight => _weight;
  set weight(String? weight) => _weight = weight;

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['challangeData'] != null) {
      _challangeData = <ChallangeData>[];
      json['challangeData'].forEach((v) {
        _challangeData!.add(new ChallangeData.fromJson(v));
      });
    }
    _gender = json['gender'];
    _height = json['height'];
    _name = json['name'];
    _pass = json['pass'];
    _photoprofile = json['photoprofile'];
    _username = json['username'];
    _weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._challangeData != null) {
      data['challangeData'] =
          this._challangeData!.map((v) => v.toJson()).toList();
    }
    data['gender'] = this._gender;
    data['height'] = this._height;
    data['name'] = this._name;
    data['pass'] = this._pass;
    data['photoprofile'] = this._photoprofile;
    data['username'] = this._username;
    data['weight'] = this._weight;
    return data;
  }
}

class ChallangeData {
  int? _easy;
  int? _hard;
  String? _title;

  ChallangeData({int? easy, int? hard, String? title}) {
    if (easy != null) {
      this._easy = easy;
    }
    if (hard != null) {
      this._hard = hard;
    }
    if (title != null) {
      this._title = title;
    }
  }

  int? get easy => _easy;
  set easy(int? easy) => _easy = easy;
  int? get hard => _hard;
  set hard(int? hard) => _hard = hard;
  String? get title => _title;
  set title(String? title) => _title = title;

  ChallangeData.fromJson(Map<String, dynamic> json) {
    _easy = json['easy'];
    _hard = json['hard'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['easy'] = this._easy;
    data['hard'] = this._hard;
    data['title'] = this._title;
    return data;
  }
}
