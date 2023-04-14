import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/screen/home.dart';
import 'package:do_an_thuc_hanh_2/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/myUser.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen); // call every time listener change (ever)
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
      Get.snackbar('Notification', 'Welcome to loginscreen');
    } else {
      Get.offAll(() => const Home());
      Get.snackbar('Notification', 'Welcome to home screen');
    }
  }

  void registerUser(String name, String email, String password) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        myUser user = myUser(name: name, email: email, uid: cred.user!.uid);

        // push user to firebase auth
        await FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error creating Account', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error creating Account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        Get.to(() => const Home());
      } else {
        Get.snackbar('Error login', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error Login', e.toString());
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
