import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String email;
  List<String>? favoristProducts;

  myUser({required this.name, required this.email, this.favoristProducts});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'favoristProducts': favoristProducts,
      };

  // firebase - app (user)
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUser(
        name: snapshot['name'],
        email: snapshot['email'],
        favoristProducts: snapshot['favoristProducts']);
  }
}
