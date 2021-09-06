
import 'package:flutter/material.dart';
import 'package:kubico/utils/theme.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({this.title, this.icon});

  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80.0,
            color: AppColors.pink,
          ),
          Text(
            title as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: AppColors.pink
            ),
          )
        ],
      ),
    );
  }
}
