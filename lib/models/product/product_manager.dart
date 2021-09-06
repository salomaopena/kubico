import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/product/product.dart';

class ProductManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = []..length;

  String _search = '';
  String get search => _search;

  ProductManager() {
    _loadAllProducts();
  }
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot querySnapshotProducts =
        await firestore.collection("product").get();
    allProducts = querySnapshotProducts.docs
        .map((doc) => Product.fromDocument(doc))
        .toList();
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = []..length;
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((produto) =>
          produto.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  List<Product> filteredProductsByCategory(String category) {
    final List<Product> filteredProducts = []..length;
    if (search.isEmpty) {
      filteredProducts
          .addAll(allProducts.where((pr) => pr.category == category));
    } else {
      filteredProducts.addAll(allProducts.where((produto) =>
          produto.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Product? findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (error) {
      debugPrint('$error');
      return null;
    }
  }

}
