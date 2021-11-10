import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/notifications/notifications_manager.dart';
import 'package:kubico/utils/custom_icon_button.dart';
import 'package:kubico/utils/icon_badge.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Notificações',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Consumer<NotificationsManager>(
                builder: (_, notificationsManager, __) {
              final notifications = notificationsManager.notifications;
              return IconBadge(
                icon: Icon(Icons.notifications, color: Colors.pink),
                itemCount: notifications.length,
                hideZero: true,
                onTap: () {},
              );
            })
          ]),
      body: Consumer<NotificationsManager>(
        builder: (_, notificationsManager, __) {
          final notificationsList = notificationsManager.notifications;
          if (notificationsList.isEmpty) {
            return Center(
              child: Text(
                'Sem notificações',
                style: GoogleFonts.roboto(color: AppColors.black, fontSize: 15),
              ),
            );
          }
          return ListView.separated(
            itemCount: notificationsList.length,
            itemBuilder: (_, index) => Card(
              elevation: 0,
              color: index.isEven ? Colors.white : AppColors.backgroundLight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                    title: Text(
                      notificationsList[index].title as String,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.pink),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          notificationsList[index].body as String,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notificationsList[index].dateText,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    trailing: CustomIconButton(
                      color: Colors.red,
                      icon: Icons.remove,
                      onTap: () => notificationsManager.deleteNotifications(
                          id: notificationsList[index].id),
                    )),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(
                height:
                    1) /*Divider(
              height: 8,
              indent: 16,
              endIndent: 16,
            )*/
            ,
          );
        },
      ),
    );
  }
}
