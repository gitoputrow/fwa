import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/DashboardPageView.dart';
import 'package:free_workout_apps/page/HomeScreenPageView.dart';
import 'package:free_workout_apps/page/SplashScreenPageView.dart';
import 'package:free_workout_apps/page/authentificationpage/LoginPageView.dart';
import 'package:free_workout_apps/provider/global/AuthentificationProvider.dart';
import 'package:free_workout_apps/provider/global/DashboardProvider.dart';
import 'package:free_workout_apps/provider/global/MyBodyProvider.dart';
import 'package:free_workout_apps/provider/global/WorkoutProvider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DashboardProvider(),),
      ChangeNotifierProvider(create: (context) => WorkoutProvider(),),
      ChangeNotifierProvider(create: (context) => AuthentificationProvider(),),
      ChangeNotifierProvider(create: (context) => MyBodyProvider(),)
    ],
    child: MyApp())
   
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          maxWidth: 1600,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 1.5),
            //ResponsiveBreakpoint.resize(1200, name: DESKTOP, scaleFactor: 2),
          ],
        );
      },
      home: SplashScreenPageView()
    );
  }
}
