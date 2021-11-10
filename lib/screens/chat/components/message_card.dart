import 'package:flutter/material.dart';
import 'package:kubico/models/chat/chat.dart';
import 'package:kubico/models/users/user_model.dart';
import 'package:kubico/utils/theme.dart';

class MessageCard extends StatelessWidget {
  MessageCard({required this.message, required this.isMe, required this.user});
  final Chat message;
  final bool isMe;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        !isMe
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.zero,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(200),
                            spreadRadius: 0.1,
                            blurRadius: 0.1),
                      ],
                    ),
                    child: Text(
                      message.message as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(200),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColor,
                              child: Text(user.name.substring(0,1)),
                          )),
                      SizedBox(width: 10),
                      Text(message.dateText),
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.topRight,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.zero,
                        bottomLeft: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(200),
                            spreadRadius: 0.1,
                            blurRadius: 0.1),
                      ],
                    ),
                    child: Text(
                      message.message as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(message.dateText),
                      SizedBox(width: 10),
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(200),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.backgroundLight,
                            child: Text(user.name.substring(0,1)),
                          )),
                    ],
                  )
                ],
              ),
      ],
    );
  }
}
