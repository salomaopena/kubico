import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kubico/screens/login/login_screen.dart';
import 'package:kubico/utils/theme.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
                color: AppColors.pink,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Faça login para ter acesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  enableFeedback: true,
                  onSurface: Colors.grey[600],
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  backgroundColor: AppColors.pink,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: const Text("LOGIN"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
