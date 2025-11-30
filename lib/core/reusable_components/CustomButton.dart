import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function() onPress;
  CustomButton({required this.title ,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 56),
            backgroundColor: ColorsManager.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            )
          ),
          child: Text(title,style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),)),
    );
  }
}
