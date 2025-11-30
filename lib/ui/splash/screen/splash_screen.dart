import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AssetsManager.logo,
          width: 180,
        )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
            .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 900.ms,
          curve: Curves.easeOutBack,
        )
            .then(delay: 200.ms)
            .slideY(
          begin: 0.2,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        )
            .then(delay: 500.ms)
            .fadeOut(
          duration: 700.ms,
          curve: Curves.easeIn,
        )
            .callback(
          callback: (_) {
            if (FirebaseAuth.instance.currentUser != null) {
              Navigator.pushReplacementNamed(context, RoutesManager.home);
            } else {
              Navigator.pushReplacementNamed(context, RoutesManager.start);
            }
          },
        ),
      ),
    );
  }
}
