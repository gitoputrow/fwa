import 'package:flutter/material.dart';
import 'package:free_workout_apps/provider/component/PasswordPeekerProvider.dart';
import 'package:free_workout_apps/provider/global/AuthentificationProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomTextInput.dart';
import 'package:provider/provider.dart';

class Register2PageView extends StatelessWidget {
  final TextEditingController etUsername;
  final TextEditingController etPassword;
  final TextEditingController etCPassword;

  const Register2PageView(
      {super.key, required this.etUsername, required this.etPassword, required this.etCPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background/bgRegist2.png"),
              fit: BoxFit.cover,
              opacity: 0.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Text(
              "Create Your",
              textScaleFactor: 1,
              style: TextStyle(color: primarycolor, fontSize: 44, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Account",
              textScaleFactor: 1,
              style: TextStyle(color: primarycolor, fontSize: 44, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 18,
            ),
            CustomTextInput(
                onChanged: (p0) {
                  AuthentificationProvider.read(context).permNextPage(
                      CPassword: etCPassword.text,
                      Password: etPassword.text,
                      Username: etUsername.text);
                },
                textEditingController: etUsername,
                hintText: "Insert Your username",
                textInputType: TextInputType.text,
                title: "Username"),
            SizedBox(
              height: 18,
            ),
            ChangeNotifierProvider(
              create: (context) => PasswordPeekerProvider(),
              builder: (context, child) => CustomTextInput(
                  onChanged: (p0) {
                    AuthentificationProvider.read(context).permNextPage(
                        CPassword: etCPassword.text,
                        Password: etPassword.text,
                        Username: etUsername.text);
                  },
                  textEditingController: etPassword,
                  hintText: "Insert Your Password",
                  textInputType: TextInputType.text,
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
                  title: "Password"),
            ),
            SizedBox(
              height: 18,
            ),
            ChangeNotifierProvider(
              create: (context) => PasswordPeekerProvider(),
              builder: (context, child) => CustomTextInput(
                  onChanged: (p0) {
                    AuthentificationProvider.read(context).permNextPage(
                        CPassword: etCPassword.text,
                        Password: etPassword.text,
                        Username: etUsername.text);
                  },
                  textEditingController: etCPassword,
                  hintText: "Confirm Your Password",
                  textInputType: TextInputType.text,
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
                  title: "Confirm Password"),
            ),
          ],
        ),
      ),
    );
  }
}
