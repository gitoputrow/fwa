import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/DashboardPageView.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:provider/provider.dart';
import '../../StorageProvider.dart';
import '../../widget/BasicLoader.dart';
import '../../widget/ToastMessageCustom.dart';

class AuthentificationProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseReference database = FirebaseDatabase().ref();

  PageController _pageControllerAuth = PageController();
  PageController get pageControllerAuth => _pageControllerAuth;
  set pageControllerAuth(PageController pageControllerAuth) {
    _pageControllerAuth = pageControllerAuth;
    notifyListeners();
  }

  late BuildContext _context;

  String _fullName = "";
  String _height = "";
  String _weight = "";
  String gender = "Male";
  String _username = "";
  String _password = "";
  String _cpassword = "";
  String _idToken = "";

  bool _usernameExist = false;
  bool get usernameExist => _usernameExist;
  set usernameExist(bool usernameExist) {
    _usernameExist = usernameExist;
    notifyListeners();
  }

  bool _passCheck = false;
  bool get passCheck => _passCheck;
  set passCheck(bool passCheck) {
    _passCheck = passCheck;
    notifyListeners();
  }

  bool _nextPagePerm = false;
  bool get nextPagePerm => _nextPagePerm;
  set nextPagePerm(bool nextPagePerm) {
    _nextPagePerm = nextPagePerm;
    notifyListeners();
  }

  int _indexRegist = 0;
  int get indexRegist => _indexRegist;
  set indexRegist(int indexRegist) {
    _indexRegist = indexRegist;
    notifyListeners();
  }

  Future checkUsername() async {
    final data = await database.get();
    if (data.child("userDatabase").exists) {
      for (var children in data.child("userDatabase").children) {
        if (_username == children.child("username").value.toString()) {
          usernameExist = true;
          break;
        }
      }
      usernameExist = false;
    } else {
      usernameExist = false;
    }
  }

  Future Regist(context) async {
    showDialog(
      context: context,
      builder: (context) => BasicLoader(),
    );
    Map<String, dynamic> dataUser = {
      "name": _fullName,
      "weight": _weight,
      "height": _height,
      "pass": _password,
      "username": _username,
      "gender": gender,
      "photoprofile": "null"
    };
    await checkUsername();
    if (usernameExist == true) {
      Navigator.pop(context);
      ToastMessageCustom.ToastMessage(
          "Username already taken", blackcolor.withOpacity(0.8), context,
          borderColor: primarycolor);
    } else {
      if (_password == _cpassword) {
        String id = database.push().key.toString();
        try {
          await database.child("userDatabase").child("$id").set(dataUser).whenComplete(
              () => database.child("userDatabase").child("$id").child("challangeData").set([
                    {
                      "title": "Full Body",
                      "easy": 0,
                      "hard": 0,
                    },
                    {
                      "title": "Pull",
                      "easy": 0,
                      "hard": 0,
                    },
                    {
                      "title": "Push",
                      "easy": 0,
                      "hard": 0,
                    },
                    {
                      "title": "Abs",
                      "easy": 0,
                      "hard": 0,
                    },
                    {
                      "title": "Leg",
                      "easy": 0,
                      "hard": 0,
                    },
                    {
                      "title": "Cardio",
                      "easy": 0,
                      "hard": 0,
                    }
                  ]));
          await StorageProvider.setUserToken(id);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPageView(),
              ),
              (route) => false);
        } catch (e) {
          Navigator.pop(context);
          print(e);
          ToastMessageCustom.ToastMessage(e.toString(), blackcolor.withOpacity(0.8), context,
              borderColor: primarycolor);
        }
      } else {
        ToastMessageCustom.ToastMessage(
            "Password Doesn't Match", blackcolor.withOpacity(0.8), context,
            borderColor: primarycolor);
      }
    }
  }

  Future checkUsernameandPass(String username, password) async {
    final data = await database.child("userDatabase").get();
    for (var children in data.children) {
      if (username == children.child("username").value.toString()) {
        usernameExist = true;
        if (password == children.child("pass").value.toString()) {
          passCheck = true;
          _idToken = children.key.toString();
        }
        break;
      }
      usernameExist = false;
      passCheck = false;
    }
  }

  Future login(context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ToastMessageCustom.ToastMessage(
          "Fill Username or Password", blackcolor.withOpacity(0.8), context,
          borderColor: primarycolor);
    } else {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      ;
      await checkUsernameandPass(username, password);
      if (usernameExist == true) {
        if (passCheck == true) {
          await StorageProvider.setUserToken(_idToken);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPageView(),
              ),
              (route) => false);
        } else {
          Navigator.pop(context);
          ToastMessageCustom.ToastMessage("Wrong Password", blackcolor.withOpacity(0.8), context,
              borderColor: primarycolor);
        }
      } else {
        Navigator.pop(context);
        ToastMessageCustom.ToastMessage("Username Not Found", blackcolor.withOpacity(0.8), context,
            borderColor: primarycolor);
      }
    }
  }

  void permNextPage({
    String Name = "",
    String Height = "",
    String Weight = "",
    String Username = "",
    String Password = "",
    String CPassword = "",
  }) {
    if (indexRegist == 0) {
      if (Name.isEmpty || Height.isEmpty || Weight.isEmpty) {
        nextPagePerm = false;
      } else {
        nextPagePerm = true;
        _fullName = Name;
        _height = Height;
        _weight = Weight;
      }
    } else if (indexRegist == 1) {
      if (Username.isEmpty || Password.isEmpty || CPassword.isEmpty) {
        nextPagePerm = false;
      } else {
        nextPagePerm = true;
        _username = Username;
        _password = Password;
        _cpassword = CPassword;
      }
    }
  }

  void nextPage(context, List Pages) async {
    if (nextPagePerm == true) {
      if (indexRegist != Pages.length - 1) {
        pageControllerAuth.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
        indexRegist += 1;
        permNextPage();
      } else {
        await Regist(context);
      }
    }
  }

  void previousPage(context) {
    if (indexRegist == 0) {
      Navigator.pop(context);
    } else {
      pageControllerAuth.previousPage(
          duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
      indexRegist -= 1;
      permNextPage();
    }
  }

  static AuthentificationProvider of(BuildContext context) => context.read().._context = context;
  static AuthentificationProvider read(BuildContext context) => context.read().._context = context;
  static AuthentificationProvider watch(BuildContext context) =>
      context.watch().._context = context;
}
