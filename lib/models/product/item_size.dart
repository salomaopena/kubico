class ItemSize {
  String name;
  num price;
  int stock;
  bool get hasStock => stock > 0;

  ItemSize({required this.name, required this.price, required this.stock});

  ItemSize.fromMap(Map<String, dynamic> map)
      : name = map['name'] as String,
        price = map['price'] as num,
        stock = map['stock'] as int;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }


  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}
