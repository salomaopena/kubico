// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubico/models/users/user_address.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String password;
  String password2;
  UserAddress address;

  UserModel(
      {this.address,
      this.email,
      this.phone,
      this.password,
      this.name,
      this.id});

  UserModel.fromDocument(DocumentSnapshot doc) {
    if (doc != null) {
      id = doc.id;
      name = doc.get('name') as String;
      email = doc.get('email') as String;
      address = UserAddress.fromMap(doc.get('address') as Map<String, dynamic>);
    }
  }

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
      'phone': phone,
      'address': address.toMap(),
    };
  }

  void setAddress(UserAddress address) {
    this.address = address;
    saveData();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
