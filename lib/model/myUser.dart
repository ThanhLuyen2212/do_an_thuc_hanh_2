import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String email;
  String uid;
  List<String>? favoristProducts;

  myUser(
      {required this.name,
      required this.uid,
      required this.email,
      this.favoristProducts});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'favoristProducts': favoristProducts,
      };

  // firebase - app (user)
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUser(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
        favoristProducts: snapshot['favoristProducts']);
  }
}
