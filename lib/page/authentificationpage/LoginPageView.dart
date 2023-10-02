import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/authentificationpage/RegisterPageView.dart';
import 'package:free_workout_apps/provider/component/PasswordPeekerProvider.dart';
import 'package:free_workout_apps/provider/global/AuthentificationProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:free_workout_apps/widget/CustomTextInput.dart';
import 'package:provider/provider.dart';

class LoginPageView extends StatelessWidget {
  final TextEditingController _etUsername = TextEditingController();
  final TextEditingController _etPasword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkcolor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                MediaQuery.of(context).viewPadding.bottom,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background/bgLogin.png"),
                    fit: BoxFit.cover,
                    opacity: 0.8)),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: greycolor,
                    size: 28,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "WELCOME",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: primarycolor.withOpacity(0.7)),
                ),
                SizedBox(height: 4),
                Text(
                  "BACK",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: primarycolor.withOpacity(0.7)),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Login With Your Account",
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: primarycolor.withOpacity(0.5),
                  thickness: 1,
                ),
                SizedBox(
                  height: 36,
                ),
                Consumer<AuthentificationProvider>(
                  builder: (context, controller, child) => CustomTextInput(
                      title: "Username",
                      textEditingController: _etUsername,
                      hintText: "Insert Your Username",
                      textInputType: TextInputType.text),
                ),
                SizedBox(
                  height: 36,
                ),
                ChangeNotifierProvider(
                  create: (context) => PasswordPeekerProvider(),
                  builder: (context, child) => CustomTextInput(
                      title: "Password",
                      textEditingController: _etPasword,
                      obscureText: context.watch<PasswordPeekerProvider>().isInvisible,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => context.read<PasswordPeekerProvider>().onClick(),
                          child: Icon(
                            !context.watch<PasswordPeekerProvider>().isInvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primarycolor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      hintText: "Insert Your Password",
                      textInputType: TextInputType.text),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Don't Have Account?",
                      style:
                          TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPageView(),
                          )),
                      child: Text(
                        "Join Us",
                        style: TextStyle(
                            color: primarycolor, fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomButton(
                          color: primarycolor,
                          onPress: () async {
                            await AuthentificationProvider.read(context)
                                .login(context, _etUsername.text, _etPasword.text);
                          },
                          text: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Let's Workout",
                              style: TextStyle(
                                  fontSize: 18, color: darkcolor, fontWeight: FontWeight.w700),
                            ),
                          )),
                      SizedBox(
                        height: 32,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
