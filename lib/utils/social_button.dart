import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {required this.background,
      required this.icon,
      required this.color,
      required this.onPressed,
      required this.text});
  final Color background;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 36.0,
      elevation: 0,
      color: background,
      padding: const EdgeInsets.all(13),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(width: 16),
          Text(text,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),)
        ],
      ),
    );
  }
}
