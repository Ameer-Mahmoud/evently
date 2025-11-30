import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ColorsManager.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                  strokeWidth: 4,
                ),
                 const SizedBox(height: 20),
                Text(
                  message ?? "Loading...".tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static void showMessageDialog({
    required BuildContext context,
    required String message,
    required String positiveActionTitle,
    required void Function() positiveActionPressed,
    String? negativeActionTitle,
    void Function()? negativeActionPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).cardColor,
        title: Center(
          child: Text(
            "Alert".tr(),
            style: const TextStyle(
              color: ColorsManager.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          if (negativeActionTitle != null)
            TextButton(
              onPressed: negativeActionPressed ?? () => Navigator.pop(context),
              child: Text(
                negativeActionTitle,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: positiveActionPressed,
            child: Text(
              positiveActionTitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }


  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
  static showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
      textColor: Theme.of(context).colorScheme.onPrimary,
      fontSize: 14.0,
    );
  }

}
