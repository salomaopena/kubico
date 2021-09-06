import 'package:flutter/material.dart';
import 'package:kubico/models/page_manager/page_manager.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.page})
      : super(key: key);

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int currentPage = context.watch<PageManager>().page;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page ? Colors.pink : AppColors.black,
              ),
            )),
            Flexible(
                child: Text(
              title,
              style: TextStyle(
                  color: currentPage == page ? Colors.pink: AppColors.black,
                  fontSize: 16),
            ))
          ],
        ),
      ),
    );
  }
}
