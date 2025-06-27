import 'package:elsirat/core/functions/dialogs.dart';
import 'package:elsirat/core/functions/email_validate.dart';
import 'package:elsirat/core/functions/navigation.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_cubit.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_state.dart';
import 'package:elsirat/fearture/auth/presentaion/pages/register_screnn.dart';
import 'package:elsirat/screens/navigationBar_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameControllar = TextEditingController();
  final TextEditingController emailControllar = TextEditingController();
  final TextEditingController passwordControllar = TextEditingController();

  bool ispaa = true;
  bool isnew = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        end: 1,
                        start: 1,
                        bottom: -7,
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            "assets/images/ChatGPT Image May 25, 2025, 08_51_24 PM.png",
                            color: AppColors.white,
                            width: 300.w,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "El-Sirat",
                            style: getHeadlineTextStyle(fontSize: 50),
                          ),
                          Text(
                            "Asalamu Alaikum !!!",
                            style: getbodyStyle(
                                fontSize: 25.sp,
                                color: AppColors.color2,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  "Sign in",
                                  style: getSmallStyle(
                                      color: AppColors.color2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextFormField(
                                controller: emailControllar,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: AppColors.contanierCoror,
                                  filled: true,
                                  hintText: "Email",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل الايميل';
                                  } else if (!emailValidate(value)) {
                                    return 'من فضلك ادخل الايميل صحيحا';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Gap(10),
                              TextFormField(
                                controller: passwordControllar,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: '********',
                                  fillColor: AppColors.contanierCoror,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'من فضلك ادخل كلمة السر';
                                  return null;
                                },
                              ),
                              Gap(20),
                              Row(
                                children: [
                                  Spacer(),
                                  CustomButton(
                                    color: AppColors.contanierCoror,
                                    text: "Sign in",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                            emailAddress: emailControllar.text,
                                            password: passwordControllar.text);
                                      }
                                    },
                                    width: 100.w,
                                  ),
                                  Spacer()
                                ],
                              ),
                              Gap(30),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "Or",
                                    style: getSmallStyle(),
                                  ),
                                  Spacer()
                                ],
                              ),
                              Gap(20),
                              Row(
                                children: [
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<AuthCubit>()
                                          .signInWithGoogle();
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/google_ic.svg",
                                      color: AppColors.color1,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      "assets/icons/facebook_ic.svg",
                                      color: AppColors.color1,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      "assets/icons/cib_apple.svg",
                                      color: AppColors.color1,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                              Gap(90),
                              Row(
                                children: [
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyle(color: AppColors.color1),
                                      children: [
                                        TextSpan(
                                          text: 'Register Now',
                                          style: TextStyle(
                                              color: AppColors.color2,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              push(context, RegisterScrenn());
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer()
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthLogLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthLogErorrState) {
            Navigator.pop(context);
            showErrorDialog(context, state.erorr); // ✅
            showErrorDialog(context, "Something Went Wrong");
          } else if (state is AuthLogSccsesState || state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              pushAndRemoveUntil(context, NavigationbarScreen());
            });
          } else if (state is AuthFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorDialog(context, state.error);
            });
          }
        },
      ),
    );
  }
}
