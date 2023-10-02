class WorkoutProgram {
  String? _name;
  String? _type;
  String? _targetedMuscle;
  List<Level>? _level;

  WorkoutProgram(
      {String? name,
      String? type,
      String? targetedMuscle,
      List<Level>? level}) {
    if (name != null) {
      this._name = name;
    }
    if (type != null) {
      this._type = type;
    }
    if (targetedMuscle != null) {
      this._targetedMuscle = targetedMuscle;
    }
    if (level != null) {
      this._level = level;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get targetedMuscle => _targetedMuscle;
  set targetedMuscle(String? targetedMuscle) =>
      _targetedMuscle = targetedMuscle;
  List<Level>? get level => _level;
  set level(List<Level>? level) => _level = level;

  WorkoutProgram.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _type = json['type'];
    _targetedMuscle = json['targeted_muscle'];
    if (json['level'] != null) {
      _level = <Level>[];
      json['level'].forEach((v) {
        _level!.add(new Level.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['type'] = this._type;
    data['targeted_muscle'] = this._targetedMuscle;
    if (this._level != null) {
      data['level'] = this._level!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Level {
  int? _reps;
  String? _title;
  List<WorkoutData>? _workoutData;

  Level({int? reps, String? title, List<WorkoutData>? workoutData}) {
    if (reps != null) {
      this._reps = reps;
    }
    if (title != null) {
      this._title = title;
    }
    if (workoutData != null) {
      this._workoutData = workoutData;
    }
  }

  int? get reps => _reps;
  set reps(int? reps) => _reps = reps;
  String? get title => _title;
  set title(String? title) => _title = title;
  List<WorkoutData>? get workoutData => _workoutData;
  set workoutData(List<WorkoutData>? workoutData) => _workoutData = workoutData;

  Level.fromJson(Map<String, dynamic> json) {
    _reps = json['reps'];
    _title = json['title'];
    if (json['workout_data'] != null) {
      _workoutData = <WorkoutData>[];
      json['workout_data'].forEach((v) {
        _workoutData!.add(new WorkoutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reps'] = this._reps;
    data['title'] = this._title;
    if (this._workoutData != null) {
      data['workout_data'] = this._workoutData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkoutData {
  String? _title;
  String? _workoutPreview;
  String? _workoutExample;
  int? _reps;

  WorkoutData(
      {String? title,
      String? workoutPreview,
      String? workoutExample,
      int? reps}) {
    if (title != null) {
      this._title = title;
    }
    if (workoutPreview != null) {
      this._workoutPreview = workoutPreview;
    }
    if (workoutExample != null) {
      this._workoutExample = workoutExample;
    }
    if (reps != null) {
      this._reps = reps;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get workoutPreview => _workoutPreview;
  set workoutPreview(String? workoutPreview) =>
      _workoutPreview = workoutPreview;
  String? get workoutExample => _workoutExample;
  set workoutExample(String? workoutExample) =>
      _workoutExample = workoutExample;
  int? get reps => _reps;
  set reps(int? reps) => _reps = reps;

  WorkoutData.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _workoutPreview = json['workout_preview'];
    _workoutExample = json['workout_example'];
    _reps = json['reps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['workout_preview'] = this._workoutPreview;
    data['workout_example'] = this._workoutExample;
    data['reps'] = this._reps;
    return data;
  }
}
