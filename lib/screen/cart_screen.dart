import 'package:do_an_thuc_hanh_2/screen/checkout_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/home.dart';
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
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Cart Details'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.to(() => const Home());
              },
              icon: const Icon(Icons.home))
        ],
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
  int tongsoluong = Cart.sumNumber();
  int tongtien = Cart.sumMoney();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      Cart.addProductToCart(widget.product!, 1);
    }
    tongsoluong = Cart.sumNumber();
    tongtien = Cart.sumMoney();
  }

  void updatetien(int tien) {
    setState(() {
      tongtien += tien;
    });
  }

  void updatesoluong(int soluong) {
    setState(() {
      tongsoluong += soluong;
    });
  }

  // void updatett(bool tt) {
  //   if (tt) {
  //     setState(() {
  //       tongtien = Cart.sumMoney();
  //       tongsoluong = Cart.sumNumber();
  //     });
  //   }
  // }

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
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartdetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      color: Colors.black12,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  child: CartItem(
                                      product: cartdetails[index].product,
                                      index: index,
                                      tttien: updatetien,
                                      ttsoluong: updatesoluong),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    Cart.removeProduct(
                                        cartdetails[index].product!);
                                    tongsoluong = Cart.sumNumber();
                                    tongtien = Cart.sumMoney();
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tổng số lượng     ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        tongsoluong.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Tổng tiền           ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        tongtien.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CheckOutButton(),
          ],
        ),
      );
    }
  }
}

class CartItem extends StatefulWidget {
  // final ValueChanged<bool, Product> update;
  ValueChanged<int> tttien;
  ValueChanged<int> ttsoluong;
  Product? product;
  int index;
  CartItem(
      {super.key,
      this.product,
      required this.index,
      required this.tttien,
      required this.ttsoluong});

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
    List<inforCart> cart = Cart().getCart();
    soluong = cart[widget.index].number;

    Product? product = widget.product;
    giatien = product!.price;
    tongtien = product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.network(widget.product!.image),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          widget.product!.title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
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
                      widget.ttsoluong(1);
                      widget.tttien(giatien);
                      soluong++;
                      tongtien = soluong * giatien;
                      Cart.cart[widget.index].number = soluong;
                    });
                  }),
                  child: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  soluong.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: (() {
                    setState(() {
                      if (soluong > 1) {
                        widget.ttsoluong(-1);
                        widget.tttien(-giatien);
                        soluong--;
                        tongtien = soluong * giatien;
                        Cart.cart[widget.index].number = soluong;
                      }
                    });
                  }),
                  child: const Icon(
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
              style: const TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        )),
      ]),
    );
  }
}

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(23),
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
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ),
        )
      ],
    );
  }
}
