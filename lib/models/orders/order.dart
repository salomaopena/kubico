import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/cart_product/cart_product.dart';
import 'package:kubico/models/users/user_address.dart';

enum Payment { money, tpa, transfer }

class Order {
  late String orderId;
  List<CartProduct> items = []..length;
  late num price;
  late num delivery;
  late String userId;
  late String name;
  late UserAddress address;
  Timestamp? date;
  String status = 'Em preparação';
  String? payment;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    delivery = cartManager.deliveryPrice;
    userId = cartManager.user.id;
    name = cartManager.user.name;
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
    name = doc.get('name') as String;
    address = UserAddress.fromMap(doc.get('address') as Map<String, dynamic>);
    status = doc.get('status') as String;
    date = doc.get('date') as Timestamp;
    payment = doc.get('payment') as String;
  }

  Future<void> save() async {
    firestore.collection('orders').doc(orderId).set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'delivery': delivery,
      'userId': userId,
      'name': name,
      'address': address.toMap(),
      'date': Timestamp.now(),
      'status': status,
      'payment': payment,
    });
  }

  String get formattedId => '#${orderId.padLeft(6, '0')}';
  String get statusText => status;
  String get dateText => getTimeAgoSinceDate(date!.toDate().toString());


  static String getPaymentText(int position) {
    switch (Payment.values[position].index) {
      case 0:
        return 'Dinheiro';
      case 1:
        return 'TPA';
      case 2:
        return 'Transferência';
      default:
        return '';
    }
  }

  static String getTimeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} meses atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} semanas atrás';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semana atrás' : 'última semana';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 dia atrás' : 'ontem';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hora atrás' : 'Uma hora atrás';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minuto atrás' : 'Um minuto atrás';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} segundos atrás';
    } else {
      return 'Agora';
    }
  }


  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, userId: $userId, address: $address, date: $date}';
  }
}
