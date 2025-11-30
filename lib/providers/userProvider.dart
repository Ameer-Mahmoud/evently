import 'package:evently_c16/core/source/remote/fireStoremanager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../core/models/user.dart' as MyUser;
import '../core/resources/image_helper.dart';

class UserProvider extends ChangeNotifier {
  MyUser.User ? user;
  getUser()async{
    user = await FireStoreManager.getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }
  Future<void> updateProfileImage() async {
    String? base64 = await ImageHelper.pickImageAsBase64();
    if (base64 == null) return;

    await FireStoreManager.updateUserImage(base64);

    user?.image = base64;
    notifyListeners();
  }

}