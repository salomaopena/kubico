import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_size.dart';

class Product extends ChangeNotifier {
  String? id;
  String name;
  String description;
  String category;
  List<String> images;
  List<ItemSize> sizes;
  bool deleted;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.images,
      required this.sizes,
      this.deleted = false}) {
    images = []..length;
    sizes = []..length;
  }

  ItemSize? _selectedSize;
  ItemSize get selectedSize => _selectedSize as ItemSize;

  set selectedSize(ItemSize? value) {
    _selectedSize = value as ItemSize;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Product.fromDocument(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot.get("name") as String,
        description = snapshot.get("description") as String,
        category = snapshot.get('category') as String,
        images = List<String>.from(snapshot.get("images") as List<dynamic>),
        deleted = (snapshot.get('deleted') ?? false) as bool,
        sizes = (snapshot.get("sizes") as List<dynamic>)
            .map((size) => ItemSize.fromMap(size as Map<String, dynamic>))
            .toList();

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest) {
        lowest = size.price;
      }
    }
    return lowest;
  }


  bool get hasStock {
    return totalStock > 0 && !deleted;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((size) => size.name == name);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

/*Product.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get("name") as String;
    description = snapshot.get("description") as String;
    images = List<String>.from(snapshot.get("images") as List<dynamic>);
    sizes = (snapshot.get("sizes") as List<dynamic>)
        .map((size) => ItemSize.fromMap(size as Map<String, dynamic>))
        .toList();
  }*/
}
