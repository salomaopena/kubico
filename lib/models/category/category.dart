import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Category extends ChangeNotifier {
  String id;
  String name;
  String? image;

  Category({required this.id, required this.name, this.image});

  Category.fromDocument(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.get('name') as String,
        image = doc.get('image') as String;

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image}';
  }
}
