import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/screens/cart/components/price_card.dart';
import 'package:kubico/screens/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereço de entrega',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actionsIconTheme: IconThemeData.fallback(),
      ),
      body: ListView(
        children: [
          const AddressCard(),
          Consumer<CartManager>(builder: (_, cartManager, __) {
            return PriceCard(
              textButton: 'Continuar para o pagamento',
              onPressed: cartManager.isAddressValid ? () {
                Get.to(()=>CheckoutScreen());
              } : null,
            );
          })
        ],
      ),
    );
  }
}
