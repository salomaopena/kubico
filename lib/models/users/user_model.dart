// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String password;
  String password2;

  UserModel({this.email, this.phone, this.password, this.name, this.id});

  UserModel.fromDocument(DocumentSnapshot doc) {
    if (doc != null) {
      id = doc.id;
      name = doc.get('name') as String;
      email = doc.get('email') as String;
     /* if (doc.get('address') != null) {
        address = Address.fromMap(doc.get('address') as Map<String, dynamic>);
      }*/
    }
  }
  /*UserModel.fromDocument(DocumentSnapshot doc)
      : assert(doc != null),
        id = doc.id,
        nome = doc.get('name') as String,
        email = doc.get('email') as String;*/

  /*factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      id: doc.id,
      nome: doc.data()!['name'] as String,
      email: doc.data()!['email'] as String
    );
  }*/

  //Address address;
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc("users/$id");

  CollectionReference get cartReference => firestoreRef.collection("cart");

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone':phone
      //if (address != null) 'address': address.toMap(),
    };
  }

  /*void setAddress(Address address) {
    this.address = address;
    saveData();
  }*/

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}