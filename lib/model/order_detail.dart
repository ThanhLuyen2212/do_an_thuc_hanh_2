import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetail {
  String idOrder;
  String idProduct;
  int number;

  OrderDetail({
    required this.idOrder,
    required this.idProduct,
    required this.number,
  });

  Map<String, dynamic> toJson() => {
        'idOrder': idOrder,
        'idProduct': idProduct,
        'number': number,
      };

  static OrderDetail fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return OrderDetail(
      idOrder: snapshot['idOrder'],
      idProduct: snapshot['idProduct'],
      number: snapshot['number'],
    );
  }
}
