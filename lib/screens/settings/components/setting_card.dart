import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/screens/account/account_screen.dart';
import 'package:kubico/screens/notification/notification_screen.dart';
import 'package:kubico/screens/privacy/privacy_screen.dart';
import 'package:kubico/screens/chat/chat_screen.dart';
import 'package:kubico/screens/terms_conditions/terms_conditions.dart';
import 'package:kubico/utils/theme.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(left: 16.0, right: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              onTap: () {
                Get.to(() => AccountScreen());
              },
              title: Text(
                'Minha conta',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.account_circle,
                size: 24,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              title: Text(
                'Notificações',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.notifications,
                size: 24,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => PrivacyScreen());
              },
              title: Text(
                'Política de Privacidade',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.privacy_tip_outlined,
                size: 24,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => TermsConditionsScreen());
              },
              title: Text(
                'Termos e condições',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.description,
                size: 24,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => ChatScreen());
              },
              title: Text(
                'Chat',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.message,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
