import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/resources/ColorsManager.dart';

class OnboardingPage {
  final String title;
  final String body;
  final String imagePath;

  OnboardingPage({
    required this.title,
    required this.body,
    required this.imagePath,
  });

  PageViewModel build(BuildContext context) {
    return PageViewModel(
      titleWidget: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: ColorsManager.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),

      bodyWidget: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          body,
          textAlign: TextAlign.start,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? ColorsManager.darkTextColor
                : ColorsManager.blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      image: SvgPicture.asset(
        imagePath,
        fit: BoxFit.contain,
      ),

      decoration: const PageDecoration(
        imageFlex:3 ,
        bodyFlex: 2,
        titlePadding: EdgeInsets.only(bottom: 20),
      ),
    );
  }
}
