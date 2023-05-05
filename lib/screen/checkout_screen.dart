import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/Controller/auth_controller.dart';
import 'package:do_an_thuc_hanh_2/model/cart.dart';
import 'package:do_an_thuc_hanh_2/model/myUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  var addressController = TextEditingController();

  CheckoutController checkoutController = Get.put(CheckoutController());

  myUser? _myInfo;
  launch() async {
    _myInfo = myUser(name: '', email: '', uid: '');
    DocumentSnapshot snap1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthController.instance.user.uid)
        .get();
    _myInfo = myUser.fromSnap(snap1);
  }

  @override
  Widget build(BuildContext context) {
    launch();
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
        title: Text(
          "Address your adress",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: context.height,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          addressTextFormField(),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Số lượng sản phẩm: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Text(
                                Cart.sumNumber().toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Tổng tiền: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Text(
                                Cart.sumMoney().toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Thông tin cá nhân',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Tên khách hàng: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                _myInfo!.name.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Email ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                _myInfo!.email.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                checkoutController
                                    .uploadOrder(addressController.text);
                              },
                              child: const Text(
                                "Order",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
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
    );
  }

  TextField addressTextFormField() {
    // return TextFormField(
    //   controller: addressController,
    //   cursorColor: Colors.black,
    //   decoration: const InputDecoration(
    //       fillColor: Colors.black,
    //       focusColor: Colors.black,
    //       border: OutlineInputBorder(),
    //       hoverColor: Colors.black,
    //       hintText: "Enter your address",
    //       hintStyle: TextStyle(color: Colors.black),
    //       floatingLabelBehavior: FloatingLabelBehavior.always,
    //       suffixIcon: Icon(
    //         Icons.map,
    //         color: Colors.black,
    //       )),
    // );

    return TextField(
      controller: addressController,
      decoration: InputDecoration(
        hintText: 'Enter your address',
        hintStyle: const TextStyle(color: Colors.black),
        labelText: 'Enter your address',
        prefixIcon: const Icon(Icons.map),
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
        iconColor: Colors.black,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black87,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
      ),
    );
  }
}
