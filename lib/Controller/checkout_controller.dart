import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/order_detail.dart';
import 'package:do_an_thuc_hanh_2/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/cart.dart';
import '../model/order.dart' as od;

class CheckoutController extends GetxController {
  List<inforCart> cart = Cart().getCart();

  uploadOrder(String address) async {
    var allDocs = await FirebaseFirestore.instance.collection('orders').get();
    var len = allDocs.docs.length;

    // add information of order
    od.Order order = od.Order(
        idOrder: 'order $len',
        uid: FirebaseAuth.instance.currentUser!.uid,
        address: address,
        createOnDate: DateTime.now(),
        total: Cart.sumNumber(),
        money: Cart.sumMoney(),
        status: 'cap nhat');

    allDocs = await FirebaseFirestore.instance.collection('orders').get();
    len = allDocs.docs.length;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc('order $len')
        .set(order.toJson());

    //add information of cart => products

    for (int i = 0; i < cart.length; i++) {
      OrderDetail orderDetail = OrderDetail(
          idOrder: 'order $len',
          idProduct: cart[i].product!.idProduct.toString(),
          number: cart[i].number);
      await FirebaseFirestore.instance
          .collection('orders')
          .doc('order $len')
          .collection('orderDetails')
          .doc('orderDetail $i')
          .set(orderDetail.toJson());
    }
    Get.snackbar('Congratulation', 'Congratulation you have place your order');
    Get.to(() => const Home());
  }
}
