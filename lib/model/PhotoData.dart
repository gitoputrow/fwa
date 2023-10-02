class PhotoData {
  String? _date;
  String? _day;
  String? _photoUrl;
  String? _time;
  String? _id;

  PhotoData(
      {String? date, String? day, String? photoUrl, String? time, String? id}) {
    if (date != null) {
      this._date = date;
    }
    if (day != null) {
      this._day = day;
    }
    if (photoUrl != null) {
      this._photoUrl = photoUrl;
    }
    if (time != null) {
      this._time = time;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get day => _day;
  set day(String? day) => _day = day;
  String? get photoUrl => _photoUrl;
  set photoUrl(String? photoUrl) => _photoUrl = photoUrl;
  String? get time => _time;
  set time(String? time) => _time = time;
  String? get id => _id;
  set id(String? id) => _id = id;

  PhotoData.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _day = json['day'];
    _photoUrl = json['photo_url'];
    _time = json['time'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this._date;
    data['day'] = this._day;
    data['photo_url'] = this._photoUrl;
    data['time'] = this._time;
    data['id'] = this._id;
    return data;
  }
}
