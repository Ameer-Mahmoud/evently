import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/dialogutils.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/resources/AppConstants.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Forget Password".tr(),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(AssetsManager.forgetPass),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              CustomButton(
                title: "Reset Password".tr(),
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailController.text);

                      DialogUtils.showMessageDialog(
                        context: context,
                        message: 'Password reset link has been sent to your email.',
                        positiveActionTitle: 'OK',
                        positiveActionPressed: () {
                          Navigator.pop(context);
                        },
                      );

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        DialogUtils.showMessageDialog(
                          context: context,
                          message: 'No user found for that email.',
                          positiveActionTitle: 'OK',
                          positiveActionPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    }
                  }
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
