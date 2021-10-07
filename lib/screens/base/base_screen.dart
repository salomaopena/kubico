import 'package:flutter/material.dart';
import 'package:kubico/models/page_manager/page_manager.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/about/about_screen.dart';
import 'package:kubico/screens/category/category_screen.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/home/home_screen.dart';
import 'package:kubico/screens/orders/orders_screen.dart';
import 'package:kubico/screens/product/product_screen.dart';
import 'package:kubico/screens/stores/stores_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScrenn(),
              CategoryScreen(),
              ProductScreen(),
              OrdersScreen(),
              StoresSreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Definições'),
                ),
              ),
              AboutScreen(),
            ],
          );
        },
      ),
    );
  }
}