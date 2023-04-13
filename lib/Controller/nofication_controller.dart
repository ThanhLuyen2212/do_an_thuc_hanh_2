import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/Controller/auth_controller.dart';
import 'package:do_an_thuc_hanh_2/model/order.dart' as order;
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final Rx<List<order.Order>> _orderList = Rx<List<order.Order>>([]);

  List<order.Order> get orderList => _orderList.value;
  final String uid = AuthController.instance.user.uid;

  getOrderList() async {
    try {
      _orderList.bindStream(FirebaseFirestore.instance
          .collection('orders')
          .snapshots()
          .map((QuerySnapshot query) {
        List<order.Order> retValue = [];
        for (var element in query.docs) {
          if (element['uid'] == uid) {
            retValue.add(order.Order.fromSnap(element));
          }
        }
        return retValue;
      }));
    } catch (e) {
      Get.snackbar('Error while get order list', e.toString());
    }
  }
}
