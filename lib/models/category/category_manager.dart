import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kubico/models/category/category.dart';

class CategoryManager extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Category> categories = []..length;


  CategoryManager() {
    _loadAllCategories();
  }

  Future<void> _loadAllCategories() async {
    final QuerySnapshot querySnapshotProducts =
    await firestore.collection("category").orderBy('name').get();
    categories = querySnapshotProducts.docs
        .map((doc) => Category.fromDocument(doc))
        .toList();
    notifyListeners();
  }

  List<String> get names => categories.map((e) => e.name).toList();

}