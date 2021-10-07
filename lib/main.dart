//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/category/category_manager.dart';
import 'package:kubico/models/home/home_manager.dart';
import 'package:kubico/models/orders/orders_manager.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/models/stores/stores_manager.dart';
import 'package:kubico/screens/base/base_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

import 'models/users/user_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager,OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_,userManager, ordersManager)=>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
      ],
      child: GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.fade,
        debugShowCheckedModeBanner: false,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: Get.defaultDialogTransitionDuration,
        title: 'Kubico de Beleza',
        theme: EcommerceTheme.of(context),
        home: BaseScreen(),
      ),
    );
  }
}
