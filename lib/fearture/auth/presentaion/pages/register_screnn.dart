import 'package:elsirat/core/functions/dialogs.dart';
import 'package:elsirat/core/functions/email_validate.dart';
import 'package:elsirat/core/functions/navigation.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_cubit.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_state.dart';
import 'package:elsirat/fearture/auth/presentaion/pages/Login_screen.dart';
import 'package:elsirat/screens/navigationBar_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RegisterScrenn extends StatefulWidget {
  const RegisterScrenn({super.key});

  @override
  State<RegisterScrenn> createState() => _RegisterScrennState();
}

class _RegisterScrennState extends State<RegisterScrenn> {
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
                            width: 300,
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
                                fontSize: 25,
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
                                  "Register Now",
                                  style: getSmallStyle(
                                      color: AppColors.color2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextFormField(
                                controller: nameControllar,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  fillColor: AppColors.contanierCoror,
                                  filled: true,
                                  hintText: "Name",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'please Enter Your Name ';
                                  return null;
                                },
                              ),
                              Gap(10),
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
                                //   style: const TextStyle(color: AppColors.black),
                                // obscureText: isVisible,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: '********',
                                  fillColor: AppColors.contanierCoror,
                                  filled: true,
                                  // suffixIcon: IconButton(
                                  //     onPressed: () {
                                  //       setState(() {
                                  //         isVisible = !isVisible;
                                  //       });
                                  //     },
                                  //     icon: Icon((isVisible)
                                  //         ? Icons.remove_red_eye
                                  //         : Icons.visibility_off_rounded)),
                                  // prefixIcon: const Icon(Icons.lock),
                                ),
                                // controller: _passwordController,
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
                                    color: AppColors.back,
                                    text: "Register",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().register(
                                            displayName: nameControllar.text,
                                            emailAddress: emailControllar.text,
                                            password: passwordControllar.text);
                                      }
                                    },
                                    width: 100,
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
                              Gap(20),
                              Row(
                                children: [
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(
                                      text: 'You have an account? ',
                                      style: TextStyle(color: AppColors.color1),
                                      children: [
                                        TextSpan(
                                          text: 'Sign In',
                                          style: TextStyle(
                                              color: AppColors.color2,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              push(context, LogInScreen());
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
          if (state is AuthRegLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthLogErorrState) {
            Navigator.pop(context);
            showErrorDialog(context, "SomeThing Went Wrong");
          } else if (state is AuthRegSccsesState) {
            pushReplacement(context, LogInScreen());
          } else if (state is AuthSuccess) {
            pushAndRemoveUntil(context, NavigationbarScreen());
          } else if (state is AuthFailure) {
            showErrorDialog(context, state.error);
          }
        },
      ),
    );
  }
}
