import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:kubico/models/users/user_model.dart';

class OrdersManager extends ChangeNotifier {
  UserModel user = UserModel();
  List<Order> orders = []..length;
  StreamSubscription? _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserModel user) {
    this.user = user;
    orders.clear();
    _subscription?.cancel();
    if (user != null) {
      _listenToOrders();
    }
  }



  void _listenToOrders() {
    _subscription = firestore
        .collection('orders')
        .where('userId', isEqualTo: user.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }
      notifyListeners();
    });
  }



  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
