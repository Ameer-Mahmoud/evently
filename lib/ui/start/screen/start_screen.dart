import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/StringsManager.dart';
import 'package:evently_c16/core/reusable_components/CustomSwitch.dart';
import 'package:evently_c16/core/source/local/PrefsManager.dart';
import 'package:evently_c16/main.dart';
import 'package:evently_c16/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/ColorsManager.dart';
import '../../../core/reusable_components/CustomButton.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String selectedLanguage = "en";
  String selectedTheme = "light";
  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    if(provider.mode==ThemeMode.dark){
      selectedTheme = "dark";
    }else{
      selectedTheme = "light";
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(AssetsManager.logoBar,
          height: 50,
          fit: BoxFit.fitHeight,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetsManager.startLight),
              const SizedBox(height: 28,),
              Text("startTitle".tr(),style: const TextStyle (
                color:ColorsManager.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),),
              const SizedBox(height: 28,),
              Text("startDesc".tr(),style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 28,),
              Row(
                children: [
                  Text("l".tr(),style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primaryColor
                  ),),
                  const Spacer(),
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
                      values: const ["en","ar"]
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: [
                  Text("theme".tr(),style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor
                  ),),
                  const Spacer(),
                  CustomSwitch(
                      isColored: true,
                      selected: selectedTheme,
                      icon2: AssetsManager.moon,
                      icon1: AssetsManager.sun,
                      onChanged: (value) {
                        setState(() {
                          selectedTheme = value;
                          if(selectedTheme == "dark"){
                            provider.changeTheme(ThemeMode.dark);
                            PrefsManager.setTheme(ThemeMode.dark);
                          }else{
                            provider.changeTheme(ThemeMode.light);
                            PrefsManager.setTheme(ThemeMode.light);
                          }
                        });
                      },
                      values: const ["light","dark"]
                  )
                ],
              ),
              const SizedBox(height: 16,),
              CustomButton(
                title: "letsStart".tr(),
                onPress: (){
                  Navigator.pushReplacementNamed(context, RoutesManager.onboarding);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
