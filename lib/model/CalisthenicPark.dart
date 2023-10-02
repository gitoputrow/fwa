class CalisthenicPark {
  String? _displayAddress;
  double? _distance;
  String? _fullAddress;
  double? _latitude;
  String? _linkMaps;
  double? _longitude;
  String? _name;
  String? _picture;
  List<Tools>? _tools;

  CalisthenicPark(
      {String? displayAddress,
      double? distance,
      String? fullAddress,
      double? latitude,
      String? linkMaps,
      double? longitude,
      String? name,
      String? picture,
      List<Tools>? tools}) {
    if (displayAddress != null) {
      this._displayAddress = displayAddress;
    }
    if (distance != null) {
      this._distance = distance;
    }
    if (fullAddress != null) {
      this._fullAddress = fullAddress;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (linkMaps != null) {
      this._linkMaps = linkMaps;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (name != null) {
      this._name = name;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (tools != null) {
      this._tools = tools;
    }
  }

  String? get displayAddress => _displayAddress;
  set displayAddress(String? displayAddress) =>
      _displayAddress = displayAddress;
  double? get distance => _distance;
  set distance(double? distance) => _distance = distance;
  String? get fullAddress => _fullAddress;
  set fullAddress(String? fullAddress) => _fullAddress = fullAddress;
  double? get latitude => _latitude;
  set latitude(double? latitude) => _latitude = latitude;
  String? get linkMaps => _linkMaps;
  set linkMaps(String? linkMaps) => _linkMaps = linkMaps;
  double? get longitude => _longitude;
  set longitude(double? longitude) => _longitude = longitude;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  List<Tools>? get tools => _tools;
  set tools(List<Tools>? tools) => _tools = tools;

  CalisthenicPark.fromJson(Map<String, dynamic> json) {
    _displayAddress = json['display_address'];
    _distance = json['distance'];
    _fullAddress = json['full_address'];
    _latitude = json['latitude'];
    _linkMaps = json['link_maps'];
    _longitude = json['longitude'];
    _name = json['name'];
    _picture = json['picture'];
    if (json['tools'] != null) {
      _tools = <Tools>[];
      json['tools'].forEach((v) {
        _tools!.add(new Tools.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_address'] = this._displayAddress;
    data['distance'] = this._distance;
    data['full_address'] = this._fullAddress;
    data['latitude'] = this._latitude;
    data['link_maps'] = this._linkMaps;
    data['longitude'] = this._longitude;
    data['name'] = this._name;
    data['picture'] = this._picture;
    if (this._tools != null) {
      data['tools'] = this._tools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tools {
  String? _name;
  String? _picture;

  Tools({String? name, String? picture}) {
    if (name != null) {
      this._name = name;
    }
    if (picture != null) {
      this._picture = picture;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;

  Tools.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['picture'] = this._picture;
    return data;
  }
}
