import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/cart.dart';

class Order {
  String idOrder;
  String uid;
  String address;
  DateTime createOnDate;
  int total;
  int money;
  String status;

  Order(
      {required this.idOrder,
      required this.uid,
      required this.address,
      required this.createOnDate,
      required this.total,
      required this.money,
      required this.status});

  Map<String, dynamic> toJson() => {
        'idOrder': idOrder,
        'uid': uid,
        'address': address,
        'createOnDate': createOnDate,
        'total': total,
        'status': status
      };

  static Order fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Order(
        idOrder: snapshot['idOrder'],
        uid: snapshot['uid'],
        address: snapshot['address'],
        createOnDate: snapshot['createOnDate'],
        total: snapshot['total'],
        money: snapshot['money'],
        status: snapshot['status']);
  }
}
