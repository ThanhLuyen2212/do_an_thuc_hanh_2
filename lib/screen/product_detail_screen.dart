import 'package:do_an_thuc_hanh_2/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  Product product;
  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
              //Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text("Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(product.image),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  'Description: ${product.description}',
                  style: TextStyle(color: Colors.black),
                ),
                flex: 1,
              ),
              _AddProductToCart(
                product: product,
              ),
            ],
          ),
        ));
  }
}

class _AddProductToCart extends StatelessWidget {
  Product product;
  _AddProductToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => CartScreen(
                product: this.product,
              ));
        },
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text(
          'Add to cart',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
