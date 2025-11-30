import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialogutils.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String selectedLanguage = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomField(
                    hint: "email".tr(),
                    prefix: AssetsManager.email,
                    controller: emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email shouldn't be empty";
                      }
                      var regex = RegExp(emailRegex);
                      if (!regex.hasMatch(value)) {
                        return "Email isn't valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomField(
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password shouldn't be empty";
                      }
                      if (value.length < 8) {
                        return "Password shouldn't be less than 8";
                      }
                      return null;
                    },
                    hint: "pass".tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesManager.reset);

                        },
                        child: Text(
                          "forgotPass".tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      title: "login".tr(),
                      onPress: () {
                        if (formKey.currentState?.validate() ?? false) {
                          signin();
                        }
                      }),
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("dontHaveAccount".tr(),style: Theme.of(context).textTheme.bodyMedium,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManager.register);
                        },
                        child: Text("createAcc".tr(),style:Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500
                        ) ,),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),
                 Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or".tr(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      signInWithGoogle(context);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorsManager.primaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/google.svg",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                           Text(
                            "Login With Google".tr(),
                            style: const TextStyle(
                              color: ColorsManager.primaryColor,
                              fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  CustomSwitch(
                      selected: selectedLanguage,
                      icon2: AssetsManager.eg,
                      icon1: AssetsManager.us,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value;
                        });
                        if(selectedLanguage=="ar"){
                          context.setLocale(const Locale("ar"));
                        }else{
                          context.setLocale(const Locale("en"));
                        }
                      },
                      values: ["en","ar"]
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signin() async {
    try {
      DialogUtils.showLoadingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
      print(credential.user!.uid);
      Navigator.pushReplacementNamed(context, RoutesManager.home);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (e.code == 'user-not-found') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'No user found for that email.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'Wrong password provided for that user.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == 'invalid-email') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'The email address is invalid.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == 'user-disabled') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'This user account has been disabled.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == 'too-many-requests') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'Too many attempts. Try again later.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == 'operation-not-allowed') {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'Email/Password sign-in is not enabled.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        } else {
          DialogUtils.showMessageDialog(
            context: context,
            message: 'Something went wrong. Please try again.',
            positiveActionTitle: 'OK',
            positiveActionPressed: () {
              Navigator.pop(context);
            },
          );
        }
      });
    }
  }
  Future<UserCredential?> signInWithGoogle(BuildContext context) async{
    try {
      DialogUtils.showLoadingDialog(context);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Navigator.pop(context);
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, RoutesManager.home);

      return userCredential;
    } catch (e) {
      Navigator.pop(context);
      print("Google Sign-In error: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogUtils.showMessageDialog(
          context: context,
          message: 'Google Sign-In failed. Please try again.',
          positiveActionTitle: 'OK',
          positiveActionPressed: () {
            Navigator.pop(context);
          },
        );
      });
      return null;
    }
  }


}
