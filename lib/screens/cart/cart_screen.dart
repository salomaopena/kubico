import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/screens/address/address_screen.dart';
import 'package:kubico/screens/cart/components/cart_tile.dart';
import 'package:kubico/screens/login/components/login_card.dart';
import 'package:provider/provider.dart';

import 'components/empty_card.dart';
import 'components/price_card.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carinho de compras',
            style: TextStyle(
              fontSize: 20,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
        ),
          centerTitle: true,
          actionsIconTheme: IconThemeData.fallback()
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {

          if(cartManager.user==null){
            return const LoginCard();
          }

          if(cartManager.items.isEmpty){
            return const EmptyCard(
              icon: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho',
            );
          }
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct: cartProduct))
                    .toList(),
              ),
              PriceCard(
                textButton: 'Continuar para a entrega',
                onPressed: cartManager.isCartValid? (){
                  Get.to(()=> AddressScreen());
                }:null,
              ),
            ],
          );
        },
      ),
    );
  }
}