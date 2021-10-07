import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kubico/utils/theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.press,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 70,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: GestureDetector(
                onTap: press,
                child: Text(
                  subtitle,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
