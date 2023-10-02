import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/provider/component/DropDownButtonValueProvider.dart';
import 'package:free_workout_apps/provider/global/AuthentificationProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomTextInput.dart';
import 'package:provider/provider.dart';

class Register1PageView extends StatelessWidget {
  final TextEditingController etFullName;
  final TextEditingController etHeight;
  final TextEditingController etWeight;

  const Register1PageView(
      {super.key, required this.etFullName, required this.etHeight, required this.etWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background/bgRegist1.png"),
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
              "Profile",
              textScaleFactor: 1,
              style: TextStyle(color: primarycolor, fontSize: 44, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 18,
            ),
            CustomTextInput(
                onChanged: (p0) {
                  AuthentificationProvider.read(context).permNextPage(
                      Name: etFullName.text,
                      Height: etHeight.text,
                      Weight: etWeight.text,
                      CPassword: "",
                      Password: "",
                      Username: "");
                },
                textEditingController: etFullName,
                hintText: "Insert Your Full Name",
                textInputType: TextInputType.name,
                title: "Full Name"),
            SizedBox(
              height: 18,
            ),
            CustomTextInput(
                onChanged: (p0) {
                  AuthentificationProvider.read(context).permNextPage(
                      Name: etFullName.text,
                      Height: etHeight.text,
                      Weight: etWeight.text,
                      CPassword: "",
                      Password: "",
                      Username: "");
                },
                textEditingController: etHeight,
                hintText: "Insert Your Height",
                textInputType: TextInputType.number,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: Text(
                    "CM",
                    style: TextStyle(
                        color: primarycolor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                title: "Height"),
            SizedBox(
              height: 18,
            ),
            CustomTextInput(
                onChanged: (p0) {
                  AuthentificationProvider.read(context).permNextPage(
                      Name: etFullName.text,
                      Height: etHeight.text,
                      Weight: etWeight.text,
                      CPassword: "",
                      Password: "",
                      Username: "");
                },
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 14, left: 4),
                  child: Text(
                    "KG",
                    style: TextStyle(
                        color: primarycolor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                textEditingController: etWeight,
                hintText: "Insert Your Weight",
                textInputType: TextInputType.number,
                title: "Weight"),
            SizedBox(
              height: 18,
            ),
            Text(
              "Gender",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: primarycolor.withOpacity(0.8)),
            ),
            SizedBox(
              height: 16,
            ),
            ChangeNotifierProvider(
              create: (context) => DropDownButtonValueProvider(),
              builder: (context, child) => DropdownButtonHideUnderline(
                child: DropdownButton2(
                  items: context
                      .read<DropDownButtonValueProvider>()
                      .items
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: primarycolor,
                              fontSize: 18,
                            ),
                          )))
                      .toList(),
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: blackcolor,
                      border: Border.all(color: primarycolor.withOpacity(0.6), width: 1)),
                  onChanged: (value) {
                    context.read<DropDownButtonValueProvider>().selectedValue = value as String;
                    
                    AuthentificationProvider.read(context).gender = value as String;
                    // controller.buttonPermissionEP();
                  },
                  buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: blackcolor,
                      border: Border.all(color: primarycolor.withOpacity(0.6), width: 1)),
                  value: context.watch<DropDownButtonValueProvider>().selectedValue,
                  selectedItemBuilder: ((context) {
                    return context
                        .watch<DropDownButtonValueProvider>()
                        .items
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: primarycolor, fontSize: 18, fontWeight: FontWeight.w700),
                            )))
                        .toList();
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
