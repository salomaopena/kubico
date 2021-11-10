import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BannerItem extends ChangeNotifier {
  String? id;
  String image;
  String? product;

  BannerItem({this.id, required this.image, this.product});

  BannerItem.fromDocument(DocumentSnapshot snapshot):
        id = snapshot.id,
        image = snapshot.get('image') as String,
        product = snapshot.get('product') as String;

  @override
  String toString() {
    return 'BannerItem{id: $id, image: $image, product: $product}';
  }
}
