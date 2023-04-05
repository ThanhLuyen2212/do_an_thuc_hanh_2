import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../Controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_controller = TextEditingController();
  final name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('Register Account',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            height: 1.5)),
                    const Text(
                      'Complete your details or continue \nwith social media',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff4caf50)),
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            nameTextFormField(),
                            const SizedBox(
                              height: 30,
                            ),
                            emailTextFormField(),
                            const SizedBox(
                              height: 30,
                            ),
                            passwordTextFormField(),
                            const SizedBox(
                              height: 30,
                            ),
                            conformTextFormField(),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (password_controller.text !=
                                      confirm_controller.text) {
                                    Get.snackbar('Error',
                                        "Password different comfirm password");
                                  } else {
                                    AuthController.instance.registerUser(
                                        name_controller.text,
                                        email_controller.text,
                                        password_controller.text);
                                  }
                                },
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff5f6f9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.facebook),
                                  ),
                                  Container(
                                      height: 40,
                                      width: 40,
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xfff5f6f9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit: BoxFit.cover)),
                                  Container(
                                      height: 40,
                                      width: 40,
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xfff5f6f9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit: BoxFit.cover)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField nameTextFormField() {
    return TextFormField(
      controller: name_controller,
      //keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      controller: email_controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      controller: password_controller,
      obscureText: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }

  TextFormField conformTextFormField() {
    return TextFormField(
      controller: confirm_controller,
      obscureText: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }
}
