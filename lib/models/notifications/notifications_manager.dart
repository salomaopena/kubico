import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/notifications/notifications.dart';
import 'package:kubico/models/users/user_model.dart';

class NotificationsManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Notifications> notifications = []..length;
  UserModel user = UserModel();
  StreamSubscription? _subscription;

  bool _loading = false;
  bool get loading => _loading;

  void updateUser(UserModel user) {
    this.user = UserModel();
    notifications.clear();
    _subscription?.cancel();
    _loadANotifications();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _loadANotifications() {
    _subscription = firestore
        .collection('notifications')
        .where('user', isEqualTo: user.id)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      notifications.clear();
      for (final doc in event.docs) {
        notifications.add(Notifications.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  Future<void> deleteNotifications({String? id}) async {
    loading = true;
    await firestore.doc('notifications/$id').delete().whenComplete(() {
      notifyListeners();
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
