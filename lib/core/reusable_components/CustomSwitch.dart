import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/AssetsManager.dart';
import '../resources/ColorsManager.dart';

class CustomSwitch extends StatelessWidget {
  String selected;
  List<String> values;
  Function(String) onChanged;
  String icon1;
  String icon2;
  bool isColored;
  CustomSwitch(
      {required this.selected,
      required this.icon2,
      required this.icon1,
      required this.onChanged,
      required this.values,
      this.isColored = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: AnimatedToggleSwitch<String>.rolling(
        current: selected,
        values: values,
        onChanged: onChanged,
        indicatorSize: Size(40, 40),
        spacing: 16,
        iconOpacity: 1,
        style: ToggleStyle(
          backgroundColor: Colors.transparent,
            indicatorColor: ColorsManager.primaryColor,
            borderColor: ColorsManager.primaryColor,
            indicatorBorderRadius: BorderRadius.circular(20)),
        iconList: [
          SvgPicture.asset(
            icon1,
            height: 30,
            width: 30,
            colorFilter: isColored
                ?ColorFilter.mode(selected=="light"
                ?Colors.white:ColorsManager.primaryColor, BlendMode.srcIn)
                :null,
          ),
          SvgPicture.asset(
            icon2,
            height: 30,
            width: 30,
            colorFilter: isColored
                ?ColorFilter.mode(selected=="dark"
                ?Colors.white:ColorsManager.primaryColor, BlendMode.srcIn)
                :null,
          ),
        ],
      ),
    );
  }
}
