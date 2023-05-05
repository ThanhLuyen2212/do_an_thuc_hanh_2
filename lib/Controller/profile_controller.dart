import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/myUser.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';
import 'package:do_an_thuc_hanh_2/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:do_an_thuc_hanh_2/model/order.dart' as order;

import 'auth_controller.dart';

class ProfileController extends GetxController {
  late myUser user;

  List<Product> purchaseProducts = [];
  final Rx<List<order.Order>> _productList = Rx<List<order.Order>>([]);
  List<order.Order> get orderList => _productList.value;

  getInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    user = myUser.fromSnap(userDoc);
  }

  updateName(String name) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'name': name});
  }

  updateEmail(String email) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'email': email});
  }

  final String uid = AuthController.instance.user.uid;

  getPurchaseProducts() async {
    List<order.Order> listorders = [];
    List<String> listProducts = [];
    FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((QuerySnapshot query) {
      for (var element in query.docs) {
        if (element['uid'] == uid) {
          listorders.add(order.Order.fromSnap(element));
        }
      }
    });

    for (int i = 0; i < listorders.length; i++) {
      String orderID = listorders[i].idOrder;
      FirebaseFirestore.instance
          .collection('orders')
          .doc(orderID)
          .collection('orderDetails')
          .snapshots()
          .map((QuerySnapshot query) {
        for (var elemnt in query.docs) {
          listProducts.add((elemnt.data() as dynamic)['idProduct']);
        }
      });
    }

    for (int i = 0; i < listProducts.length; i++) {
      var temp = await FirebaseFirestore.instance
          .collection('products')
          .doc(listProducts[i])
          .get();
      purchaseProducts.add(Product.fromSnap(temp));
    }
  }
}
