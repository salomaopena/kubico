import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/cart_product/cart_product.dart';
import 'package:kubico/models/users/user_address.dart';

class Order {
  late String orderId;
  List<CartProduct> items = []..length;
  late num price;
  late num delivery;
  late String userId;
  late UserAddress address;
  Timestamp? date;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    delivery = cartManager.deliveryPrice;
    userId = cartManager.user.id;
    address = cartManager.address as UserAddress;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.id;
    items = (doc.get('items') as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = doc.get('price') as num;
    delivery = doc.get('delivery') as num;
    userId = doc.get('userId') as String;
    address = UserAddress.fromMap(doc.get('address') as Map<String, dynamic>);
    //TODO: Descomentar: Rever a questão da data
    //date = doc.get('date') as Timestamp;
  }

  Future<void> save() async {
    firestore.collection('orders').doc(orderId).set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'delivery': delivery,
      'userId': userId,
      'address': address.toMap(),
    });
  }

  String get formattedId => '#${orderId.padLeft(6,'0')}';

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, userId: $userId, address: $address, date: $date}';
  }
}
