import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kubico/models/cart_product/cart_product.dart';
import 'package:kubico/models/product/product.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/models/users/user_model.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = []..length;
  late UserModel user;
  //Address address;

  num productsPrice = 0.0;
  num deliveryPrice = 0.0;

  num get totalPrice => productsPrice + deliveryPrice;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int get itemCartSize {
    return items.length;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    productsPrice = 0.0;
    items.clear();
    //removeAddress();
    if (user != null) {
      _loadCartItems();
      // _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.get();
    items = cartSnap.docs
        .map(
            (doc) => CartProduct.fromDocument(doc)..addListener(_onItemUpdated))
        .toList();
  }

  /* Future<void> _loadUserAddress() async {
    if (user.address != null &&
        await calculateDelivey(user.address.latitude, user.address.longitude)) {
      address = user.address;
      notifyListeners();
    }
  }*/

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (error) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id)
          .whenComplete(() {
        debugPrint("${cartProduct.product.name} Adicionado ao carrinho!");
      });
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        _removeFromCart(cartProduct);
        i--;
        continue;
      } else {
        productsPrice += cartProduct.totalPrice;
        _updateCartProduct(cartProduct: cartProduct);
      }
    }
    notifyListeners();
  }

  void _removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.doc(cartProduct.id).delete().whenComplete(() {
      debugPrint('${cartProduct.product.name} Removido do carrinho');
    });
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  Future<void> _updateCartProduct({required CartProduct cartProduct}) async {
    if (cartProduct.id != null) {
      await user.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap())
          .whenComplete(
              () => debugPrint('${cartProduct.product.name} actualizado'))
          .catchError((error) => debugPrint('Erro ao actualizar $error'));
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) {
        return false;
      }
    }
    return true;
  }

  //bool get isAddressValid => address != null && deliveryPrice > 0.0;

  /* Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CEPAbertoService();
    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      if (cepAbertoAddress != null) {
        address = Address(
          street: cepAbertoAddress.logradouro,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.cidade.nome,
          states: cepAbertoAddress.estado.sigla,
          latitude: cepAbertoAddress.longitude,
          longitude: cepAbertoAddress.longitude,
        );
      }
      loading = false;
    } catch (error) {
      loading = false;
      debugPrint(error.toString());
      return Future.error('CEP inválido!!!!');
    }
  }*/

  /*Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    if (await calculateDelivey(address.latitude, address.longitude)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }*/

  /*void removeAddress() {
    address = null;
    deliveryPrice = 0.0;
    notifyListeners();
  }*/

  Future<bool> calculateDelivey(double latitude, double longitude) async {
    final DocumentSnapshot documentSnapshot =
        await firestore.doc('config/delivery').get();
    final latStore = documentSnapshot.get('latitude') as double;
    final longStore = documentSnapshot.get('longitude') as double;
    final maxKm = documentSnapshot.get('distance') as num;
    final basePrice = documentSnapshot.get('baseprice') as num;
    final priceByKm = documentSnapshot.get('km') as num;

    double distance = await Geolocator.distanceBetween(
        latStore, longStore, latitude, longitude);

    distance /= 1000.0;

    if (distance > maxKm) {
      return false;
    }
    deliveryPrice = basePrice + distance * priceByKm;
    return true;
  }
}
