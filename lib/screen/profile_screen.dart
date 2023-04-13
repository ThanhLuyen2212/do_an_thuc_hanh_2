import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return Expanded(
        child: Container(
      color: Colors.white,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://i.pinimg.com/originals/46/cd/d8/46cdd82cb16aa9a964717f4099a7bbf2.jpg',
                height: 100,
                width: 100,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 140,
          height: 47,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: Center(
              child: InkWell(
            onTap: () {
              Get.offAll(() => LoginScreen());
            },
            child: Text(
              'Sign out',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )),
        ),
      ]),
    ));
  }
}
