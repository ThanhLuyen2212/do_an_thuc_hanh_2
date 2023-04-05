import 'package:do_an_thuc_hanh_2/screen/signup_screen.dart';
import 'package:flutter/material.dart';

import '../Controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Food Now',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign in with your email and password \n or continue with social media',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                              prefixIcon: Icon(Icons.mail_outline)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              AuthController.instance.loginUser(
                                  _usernameController.text,
                                  _passwordController.text);
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                                  color: Colors.blue,
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
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an acconut?',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: const Text(
                                ' Sign Up',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
