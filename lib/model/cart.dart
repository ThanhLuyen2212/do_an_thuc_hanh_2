import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';

class inforCart {
  String? idOrder;
  Product? product;
  int number;
  String? idProduct;

  inforCart(
      {this.idOrder,
      required this.product,
      required this.number,
      this.idProduct});

  // inforCart(Product product, int number) {
  //   this.product = product;
  //   this.number = number;
  // }

  static inforCart fromSnap(DocumentSnapshot snap, Product product) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return inforCart(
        idOrder: snapshot['idOrder'],
        product: product,
        number: snapshot['number'],
        idProduct: snapshot['idProduct']);
  }
}

class Cart {
  static List<inforCart> cart = [];

  static void addProductToCart(Product product, int number) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].product!.idProduct == product.idProduct) {
        cart[i].number++;
        return;
      }
    }
    cart.add(inforCart(product: product, number: number));
  }

  List<inforCart> getCart() {
    return cart;
  }

  static void removeProduct(Product product) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].product == product) {
        cart.remove(cart[i]);
      }
    }
  }

  static int sumNumber() {
    int temp = 0;
    for (int i = 0; i < cart.length; i++) {
      temp += cart[i].number;
    }
    return temp;
  }

  static int sumMoney() {
    int temp = 0;
    for (int i = 0; i < cart.length; i++) {
      temp += cart[i].number * cart[i].product!.price;
    }
    return temp;
  }
}
