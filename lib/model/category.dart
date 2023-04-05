import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String title;
  String image;

  Categories({required this.title, required this.image});

  Map<String, dynamic> toJon() => {
        'title': title,
        'image': image,
      };

  static Categories fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Categories(
      title: snapshot['title'],
      image: snapshot['image'],
    );
  }
}
