import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class OrderDetailController extends GetxController {
  late Rx<List<Product>> _listProduct = Rx<List<Product>>([]);

  List<Product> get listProduct => _listProduct.value;
  List<String> idproduct = [];

  final String uid = AuthController.instance.user.uid;

  getListIdProduct(String idOrder) async {
    var orderLIstIdProduct = await FirebaseFirestore.instance
        .collection('orders')
        .doc(idOrder)
        .collection('orderDetails')
        .get();

    for (int i = 0; i < orderLIstIdProduct.docs.length; i++) {
      idproduct
          .add((orderLIstIdProduct.docs[i].data() as dynamic)['idProduct']);
    }
  }

  getListProduct(String idOrder) async {
    await getListIdProduct(idOrder);
    _listProduct.bindStream(FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retValue = [];
      for (var elemnt in query.docs) {
        if (idproduct.contains(elemnt['idProduct'])) {
          retValue.add(Product.fromSnap(elemnt));
        }
      }
      return retValue;
    }));
  }
}
