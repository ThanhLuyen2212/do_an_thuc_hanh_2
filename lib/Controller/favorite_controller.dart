import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final Rx<List<Product>> _listLikeProducts = Rx<List<Product>>([]);
  List<Product> get listLikeProducts => _listLikeProducts.value;

  init(String uid) {
    getProducts(uid);
  }

  getProducts(String uid) async {
    try {
      _listLikeProducts.bindStream(FirebaseFirestore.instance
          .collection('products')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Product> retValue = [];
        for (var element in query.docs) {
          if ((element['likes'] as List).contains(uid.toString())) {
            retValue.add(Product.fromSnap(element));
          }
        }
        return retValue;
      }));
    } catch (e) {
      Get.snackbar("Error while get product", e.toString());
    }
  }
}
