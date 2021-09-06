import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/home/banner_item.dart';

class HomeManager extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BannerItem> allItems = []..length;

  HomeManager(){
    _loadAllItems();
  }

  Future<void> _loadAllItems() async {
     await firestore.collection('banner').snapshots().listen((snapshot) {
      allItems.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        allItems.add(BannerItem.fromDocument(document));
      }
      notifyListeners();
    });
  }
}