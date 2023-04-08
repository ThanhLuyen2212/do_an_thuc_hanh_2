import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String idProduct;
  String title;
  String description;
  String image;
  int price;
  List likes;

  Product(
      {required this.idProduct,
      required this.title,
      required this.description,
      required this.likes,
      required this.image,
      required this.price});

  Map<String, dynamic> toJon() => {
        'idProduct': idProduct,
        'title': title,
        'description': description,
        'image': image,
        'price': price,
        'likes': likes
      };

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Product(
        idProduct: snapshot['idProduct'],
        title: snapshot['title'],
        likes: snapshot['likes'],
        description: snapshot['description'],
        image: snapshot['image'],
        price: snapshot['price']);
  }
}
