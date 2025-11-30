import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppStyle.dart';
import 'package:evently_c16/core/resources/AssetsManager.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/providers/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../core/resources/RoutesManager.dart';
import '../../../../core/resources/dialogutils.dart';
import '../../../../core/source/local/PrefsManager.dart';
import '../../../../providers/ThemeProvider.dart';

class Usertab extends StatefulWidget {
  const Usertab({super.key});

  @override
  State<Usertab> createState() => _UsertabState();
}

class _UsertabState extends State<Usertab> {
  String selectedLanguage = "en";
  String selectedTheme = "dark";
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,

          borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(64))

      ),
      child: SafeArea(
        child: Row(
         // spacing: ,
          children: [
            GestureDetector(
              onTap: () async {
                DialogUtils.showLoadingDialog(context);
                await provider.updateProfileImage();
                Navigator.pop(context);

                DialogUtils.showToast(context, "Profile image updated");
              },
              child: Container(

                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsManager.lightBackgroundColor,width: 2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                    topLeft: Radius.circular(100),
                  ),
                  color: Colors.white,
                  image: provider.user?.image != null &&
                      provider.user!.image!.isNotEmpty
                      ? DecorationImage(
                    image: MemoryImage(
                      base64Decode(provider.user!.image!),
                    ),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: provider.user?.image == null ||
                    provider.user!.image!.isEmpty
                    ? const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 124,
                )
                    : null,
              ),
            ),

            const SizedBox(width: 10,),
            provider.user==null?
    const Center( child: CircularProgressIndicator(),)
    :Expanded(
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.user!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),),
                  const SizedBox(height: 10,),
                  Text(provider.user!.email!,
                    style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),),


                ],
              ),
    )
          ],
        ),
      ),
    ),
        const SizedBox(height: 24,),
         Expanded(
           child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Language".tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),),
                const SizedBox(height: 16,),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  value: selectedLanguage,
                  hint: const Text('Choose Language'),
                  style: const TextStyle(
                      color: ColorsManager.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                      context.setLocale(Locale(selectedLanguage));
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  ],
                ),
                const SizedBox(height: 16,),
                Text("Theme".tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                    ),
                const SizedBox(height: 16,),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  value: selectedTheme,
                  hint: const Text('Choose Theme'),
                  style: const TextStyle(
                    color: ColorsManager.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                      final themeMode = selectedTheme == "light" ? ThemeMode.dark : ThemeMode.light;
                      themeProvider.changeTheme(themeMode);
                      PrefsManager.setTheme(themeMode);
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'light', child: Text('Dark Mood')),
                    DropdownMenuItem(value: 'dark', child: Text('Light Mood')),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, RoutesManager.login, (route) => false,
                      );
                    },
                    child:  Row(
                      children: [
                        const Icon(Icons.logout,
                        color: Colors.white,
                        size: 25,),
                        const Spacer(),
                        Text(
                          'Logout'.tr(),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),

                ),
                const SizedBox(height: 20,)



              ],
            ),
                   ),
         )

      ],
    );
  }
}
