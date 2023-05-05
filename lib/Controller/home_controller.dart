import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/Controller/auth_controller.dart';
import 'package:get/get.dart';
import '../model/category.dart';
import '../model/product.dart';

class HomeController extends GetxController {
  late Rx<List<Category>> _categories = Rx<List<Category>>([]);
  List<Category> get categories => _categories.value;

  late Rx<List<Product>> _products = Rx<List<Product>>([]);
  List<Product> get products => _products.value;

  getCategories() async {
    try {
      _categories.bindStream(FirebaseFirestore.instance
          .collection('categories')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Category> retValue = [];
        for (var element in query.docs) {
          retValue.add(Category.fromSnap(element));
        }
        return retValue;
      }));
    } catch (e) {
      Get.snackbar("Error while get product", e.toString());
    }
  }

  getProducts() async {
    try {
      _products.bindStream(FirebaseFirestore.instance
          .collection('products')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Product> retValue = [];
        for (var element in query.docs) {
          retValue.add(Product.fromSnap(element));
        }
        return retValue;
      }));
    } catch (e) {
      Get.snackbar("Error while get product", e.toString());
    }
  }

  likeProduct(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('products').doc(id).get();
    var uid = AuthController.instance.user.uid;
    if (((doc.data()! as dynamic)['likes'] as List).contains(uid)) {
      await FirebaseFirestore.instance.collection('products').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance.collection('products').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
