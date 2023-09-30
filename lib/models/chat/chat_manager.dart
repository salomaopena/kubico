import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/chat/chat.dart';
import 'package:kubico/models/users/user_model.dart';

class ChatManager extends ChangeNotifier {
  UserModel user = UserModel();
  Chat chat = Chat();
  List<Chat> messages = []..length;
  StreamSubscription? _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  updateUser(UserModel user) {
    this.user = user;
    messages.clear();
    _subscription?.cancel();
    _listenToChat();
  }

  void _listenToChat() {
    _subscription = firestore
        .collection('chat')
        .doc(user.id)
        .collection('messages')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (final doc in event.docs) {
        messages.add(Chat.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  Future<void> sendMessage(UserModel userModel) async {
    user = userModel;
    await chat.send(user);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
