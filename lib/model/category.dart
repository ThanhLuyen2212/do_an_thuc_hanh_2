import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String title;
  String image;

  Category({required this.title, required this.image});

  Map<String, dynamic> toJon() => {
        'title': title,
        'image': image,
      };

  static Category fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Category(
      title: snapshot['title'],
      image: snapshot['image'],
    );
  }
}
