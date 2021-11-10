import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/cart_product/checkout_manager.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:kubico/screens/base/base_screen.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/cart/components/price_card.dart';
import 'package:kubico/screens/checkout/components/payment_card.dart';
import 'package:kubico/screens/confirmation/confirmation_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      lazy: false,
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager as CheckoutManager
            ..updateCart(cartManager as CartManager),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pagamento',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actionsIconTheme: const IconThemeData.fallback(),
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __) {
            if (checkoutManager.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pink),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'A procesar pagamento...',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PaymentCard(),
                PriceCard(
                  textButton: 'Finalizar pedido',
                  onPressed: checkoutManager.isPaymentValid? () {
                    checkoutManager.checkout(onStockFail: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Informação: $e"),
                        backgroundColor: AppColors.red,
                      ));
                      Get.off(() => CartScreen());
                    }, onSuccess: (Order order) {
                      Get.offAll(() => BaseScreen());
                      Get.to(() => ConfirmationScreen(order: order));
                    });
                  }:null,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
