import 'package:flutter/material.dart';
import 'package:kubico/models/orders/orders_manager.dart';
import 'package:kubico/screens/cart/components/empty_card.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/login/components/login_card.dart';
import 'package:kubico/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Meus pedidos',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actionsIconTheme: const IconThemeData.fallback(),
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return LoginCard();
          }

          if (ordersManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhum pedido efectuado!',
              icon: Icons.hourglass_empty,
            );
          }

          return ListView.separated(
            itemCount: ordersManager.orders.length,
            separatorBuilder: (_, index) => const SizedBox(height: 8),
            itemBuilder: (_, index) {
              return OrderTile(order: ordersManager.orders.reversed.toList()[index]);
            },
          );
        },
      ),
    );
  }
}
