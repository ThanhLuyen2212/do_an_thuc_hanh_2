import 'package:do_an_thuc_hanh_2/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/auth_controller.dart';
import '../Controller/home_controller.dart';
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Description: ${product.description}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    flex: 1,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Likeproduct(product: product),
                  ),
                ],
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
                product: product,
              ));
        },
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: const Text(
          'Add to cart',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class Likeproduct extends StatefulWidget {
  Product product;

  Likeproduct({super.key, required this.product});

  @override
  State<Likeproduct> createState() => _LikeproductState();
}

class _LikeproductState extends State<Likeproduct> {
  HomeController productController = Get.put(HomeController());
  late bool like =
      widget.product.likes.contains(AuthController.instance.user.uid);
  void setlike() {
    productController.likeProduct(widget.product.idProduct);
    setState(() {
      like = !like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setlike();
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Icon(
          like ? Icons.favorite : Icons.heart_broken,
          size: 40,
          color: like ? Colors.red : Colors.blue,
        ),
      ),
    );
  }
}
