import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/resources/RoutesManager.dart';
import 'onboardingWidget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(AssetsManager.logoBar,
          height: 50,
          fit: BoxFit.fitHeight,),
      ),

      body:
      Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 16),
        child: IntroductionScreen(
          pages: [
            OnboardingPage(
              title: "onboard1T".tr(),
              body: "onboard1D".tr(),
              imagePath: AssetsManager.onboarding1,
            ).build(context),
            OnboardingPage(
              title: "onboard2T".tr(),
              body: "onboard2D".tr(),
              imagePath: AssetsManager.onboarding2,
            ).build(context),
            OnboardingPage(
              title: "onboard3T".tr(),
              body: "onboard3D".tr(),
              imagePath: AssetsManager.onboarding3,
            ).build(context),

          ],
          onDone: () {
            Navigator.pushReplacementNamed(
                context,RoutesManager.login);
          },
          onSkip: () {
            Navigator.pushReplacementNamed(context, RoutesManager.login);
          },
          showSkipButton: true,
          skip:  Text("Skip".tr(),style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,

          ),),
          next: const Icon(Icons.arrow_forward,size:22 ,),
          done:  Text("Done".tr(), style: const TextStyle(
            fontSize: 18,
              fontWeight: FontWeight.w700)),
          dotsDecorator: const DotsDecorator(
            size: Size(8.0, 8.0),
            color: Colors.grey,
            activeSize: Size(20.0, 8.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            activeColor: ColorsManager.primaryColor,
          ),
        ),
      ),
    );
  }
}
