import 'package:do_an_thuc_hanh_2/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/cart.dart';
import '../model/product.dart';

class CartScreen extends StatelessWidget {
  Product? product;
  CartScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Cart Details'),
      ),
      body: BodyCart(
        product: product,
      ),
    );
  }
}

class BodyCart extends StatefulWidget {
  Product? product;
  BodyCart({super.key, this.product});
  @override
  State<BodyCart> createState() => _BodyCartState();
}

class _BodyCartState extends State<BodyCart> {
  List<inforCart> cartdetails = Cart().getCart();
  late int sumMoney;
  late int sumNumber;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      Cart.addProductToCart(widget.product!, 1);
    }
    sumMoney = Cart.sumMoney();
    sumNumber = Cart.sumNumber();
  }

  @override
  Widget build(BuildContext context) {
    if (cartdetails.isEmpty) {
      return const Center(
        child: Text(
          'Không có sản phẩm náo trong giỏ hàng',
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartdetails.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          child: CartItem(
                            product: cartdetails[index].product,
                          ),
                          onTap: () {
                            setState(() {
                              // cartdetails.removeAt(index);
                              Cart.removeProduct(cartdetails[index].product!);

                              // giá sản phẩm
                              sumMoney = Cart.sumMoney();
                              sumNumber = Cart.sumNumber();
                            });
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  }),
            ),
            CheckOutButton(sumNumber: sumNumber, sumMoney: sumMoney)
          ],
        ),
      );
    }
  }
}

class CartItem extends StatefulWidget {
  Product? product;
  CartItem({super.key, this.product});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int soluong = 1;
  int tongtien = 0;
  int giatien = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soluong = 1;

    Product? product = widget.product;
    giatien = product!.price;
    tongtien = product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      color: Colors.black12,
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.network(widget.product!.image),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          widget.product!.title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        )),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (() {
                    setState(() {
                      soluong++;
                      tongtien = soluong * giatien;
                    });
                  }),
                  child: Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  soluong.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: (() {
                    setState(() {
                      if (soluong > 1) {
                        soluong--;
                        tongtien = soluong * giatien;
                      }
                    });
                  }),
                  child: Icon(
                    Icons.remove,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              // widget.product!.price.toString(),
              tongtien.toString(),
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        )),
        Icon(
          Icons.delete_outline,
          color: Colors.black,
        ),
      ]),
    );
  }
}

class CheckOutButton extends StatelessWidget {
  int sumMoney;
  int sumNumber;
  CheckOutButton({required this.sumNumber, required this.sumMoney});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen, padding: const EdgeInsets.all(10)),
            onPressed: () {},
            child: Text(
              "Sum:${sumMoney},   \n Money:${sumNumber}",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(23),
              primary: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(color: Colors.green)),
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Get.to(() => CheckoutScreen());
            },
            child: Text("Check out".toUpperCase(),
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        )
      ],
    );
  }
}
