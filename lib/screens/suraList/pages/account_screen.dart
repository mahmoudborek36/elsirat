import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:elsirat/screens/suraList/widgets/arroe_back_widgeta.dart';
import 'package:elsirat/screens/suraList/widgets/showDailog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _Getuser() async {
    user = _auth.currentUser;
  }

  List labelName = [
    "email",
    "name",
    "gender",
    " location",
  ];
  List value = [
    "email",
    "name",
    "gender",
    " location",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _Getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        backgroundColor: AppColors.back,
        automaticallyImplyLeading: false,
        leading: arroeBackWidgeta(),
        title: Text(
          "Account",
          style: getHeadlineTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(22),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var userData = snapshot.data;

              return Column(
                children: [
                  Gap(15),
                  GestureDetector(
                    onTap: () {
                      showDialogData(context, userData, "name", "name", "name");
                    },
                    child: updateDataWidget(
                      userData: userData,
                      text: "name",
                    ),
                  ),
                  Gap(15),
                  GestureDetector(
                    onTap: () {
                      showDialogData(
                          context, userData, "gender", "gender", "gender");
                    },
                    child: updateDataWidget(
                      userData: userData,
                      text: "gender",
                    ),
                  ),
                  Gap(15),
                  GestureDetector(
                    onTap: () {
                      showDialogData(context, userData, "location", "location",
                          'location');
                    },
                    child: updateDataWidget(
                      userData: userData,
                      text: "location",
                    ),
                  ),
                  Gap(20),
                  updateDataWidget(userData: userData, text: "email"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDialogData(
      BuildContext context,
      DocumentSnapshot<Map<String, dynamic>>? userData,
      String name,
      String text,
      String update) {
    return showDialog(
      context: context,
      builder: (context) {
        var con = TextEditingController(
            text: userData?[name] == '' || userData?[name] == null
                ? 'لم تضاف'
                : userData?[name]);
        var form = GlobalKey<FormState>();
        return SimpleDialog(
          alignment: Alignment.center,
          contentPadding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          children: [
            Form(
              key: form,
              child: Column(
                children: [
                  Text(
                    ' Enter Your $text',
                    style: getbodyStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: con,
                    decoration: const InputDecoration(
                        filled: true, fillColor: AppColors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your $text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: ' Save',
                    onPressed: () {
                      if (form.currentState!.validate()) {
                        updateData(update, con.text);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  updateData(String key, value) async {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      key: value,
    });
    if (key == "name") {
      await user?.updateDisplayName(value);
    }
    Navigator.pop(context);
  }
}

class updateDataWidget extends StatelessWidget {
  const updateDataWidget({
    super.key,
    required this.userData,
    this.text,
  });

  final String? text;

  final DocumentSnapshot<Map<String, dynamic>>? userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.color1, borderRadius: BorderRadius.circular(22.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text ?? '',
            style: getbodyStyle(color: AppColors.white),
          ),
          Text(
            userData?[text ?? ''] == "" || userData?[text ?? ''] == null
                ? "no added"
                : userData?[text ?? ''],
            style: getbodyStyle(color: AppColors.white),
          )
        ],
      ),
    );
  }
}
