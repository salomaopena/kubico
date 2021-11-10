// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/page_manager/page_manager.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/about/about_screen.dart';
import 'package:kubico/screens/category/category_screen.dart';
import 'package:kubico/screens/home/home_screen.dart';
import 'package:kubico/screens/orders/orders_screen.dart';
import 'package:kubico/screens/product/product_screen.dart';
import 'package:kubico/screens/settings/setting_screen.dart';
import 'package:kubico/screens/stores/stores_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    configFCM();
    super.initState();
  }

  void configFCM() {
    final fcm = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      fcm.requestPermission(
          alert: true,
          badge: true,
          provisional: true,
          sound: true,
          announcement: true,
          carPlay: true,
          criticalAlert: true);
    }
    fcm.setForegroundNotificationPresentationOptions(
        sound: true, badge: true, alert: true);

    //Old onLaunch and onResume
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      return showNotification(message.notification!.title as String,
          message.notification!.body as String);
    });

    FirebaseMessaging.onMessage.listen((message) {
      return showNotification(message.notification!.title as String,
          message.notification!.body as String);
    });
  }

  void showNotification(String title, String body) {
    Flushbar(
      title: title,
      titleColor: Colors.pink,
      messageText: Text(body,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: Colors.pink,
            fontSize: 14,
          )),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 5),
      icon: const Icon(Icons.shopping_basket, color: Colors.pink),
    ).show(context);
  }


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
              SettingsScreen(),
              AboutScreen(),
            ],
          );
        },
      ),
    );
  }
}
