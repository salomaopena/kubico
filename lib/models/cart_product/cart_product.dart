import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/product/item_size.dart';
import 'package:kubico/models/product/product.dart';

class CartProduct extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? id;
  late String productId;
  late int quantity;
  late String size;
  late Product product;

  CartProduct.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    productId = snapshot.get('product') as String;
    quantity = snapshot.get('quantity') as int;
    size = snapshot.get('size') as String;

     firestore.doc('product/$productId').get().then((document)  {
      product = Product.fromDocument(document);
      notifyListeners();
    });
  }

  CartProduct.fromProduct(this.product) {
    if (product != null) {
      productId = product.id as String;
      quantity = 1;
      size = product.selectedSize.name;
    }
  }

  ItemSize get itemSize {
    //if (product == null) {
    // return null;
    //} else {
    return product.findSize(size);
    //}
  }

  num get unityPrice {
    if (product == null) return 0;
    return itemSize.price;
  }

  num get totalPrice => unityPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'product': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }

  @override
  String toString() {
    return 'CartProduct{id: $id, productId: $productId, quantity: $quantity, size: $size}';
  }
}
