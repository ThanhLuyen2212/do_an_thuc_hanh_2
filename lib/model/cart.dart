import 'package:do_an_thuc_hanh_2/model/product.dart';

class inforCart {
  late Product product;
  late int number;

  inforCart(Product product, int number) {
    this.product = product;
    this.number = number;
  }
}

class Cart {
  static List<inforCart> cart = [];

  static void addProductToCart(Product product, int number) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].product == product) {
        cart[i].number++;
        return;
      }
    }
    cart.add(inforCart(product, number));
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
      temp += cart[i].number * cart[i].product.price;
    }
    return temp;
  }
}
