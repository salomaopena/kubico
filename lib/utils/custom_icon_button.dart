// @dart=2.9
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {@required this.icon,
      @required this.color,
      this.size,
      @required this.onTap});
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: onTap != null ? color : Colors.grey[500],
              size: size ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
