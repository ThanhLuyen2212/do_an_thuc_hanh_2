import 'package:do_an_thuc_hanh_2/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  var addressController = TextEditingController();

  CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
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
                            height: 30,
                          ),
                          addressTextFormField(),
                          const SizedBox(
                            height: 30,
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
                          const SizedBox(
                            height: 30,
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

  TextFormField addressTextFormField() {
    return TextFormField(
      controller: addressController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
    );
  }
}
