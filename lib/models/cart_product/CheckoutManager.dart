import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:kubico/models/product/product.dart';

class CheckoutManager extends ChangeNotifier {
  late CartManager cartManager;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateCart(CartManager cartManager) async {
    this.cartManager = cartManager;
  }

  Future<void> checkout(
      {required Function onStockFail, required Function onSuccess}) async {
    loading = true;
    try {
      await _descrementSock();
    } catch (e) {
      onStockFail(e);
      debugPrint(e.toString());
      loading = false;
      return;
    }
    //TODO: PROCESSAR PAGAMENTO
    final orderId = await _getOrderId();
    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    await order.save();

    cartManager.clear();

    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderId() async {
    final ref = firestore.doc('config/ordercounter');
    try {
      final result = await firestore.runTransaction((ts) async {
        final doc = await ts.get(ref);
        final orderId = doc.get('current') as int;
        await ts.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número');
    }
  }

  Future<void> _descrementSock() async {
    return firestore.runTransaction((ts) async {
      final List<Product> productsToUpdate = []..length;
      final List<Product> productsWithoutStock = []..length;

      for (final cartProduct in cartManager.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc =
              await ts.get(firestore.doc('product/${cartProduct.productId}'));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);

        if (size.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produto(s) sem estoque.');
      }

      for (final product in productsToUpdate) {
        ts.update(firestore.doc('product/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
