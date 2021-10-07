import 'package:flutter/material.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer_header.dart';
import 'package:kubico/screens/custom_drawer/drawer_tile.dart';
import 'package:kubico/utils/theme.dart';

@immutable
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
            AppColors.primaryColor,
            AppColors.backgroundLight,
          ], begin: Alignment.topCenter, end: Alignment.bottomRight))),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(
                indent: 32,
              ),
              const DrawerTile(
                iconData: Icons.home,
                title: "Início",
                page: 0,
              ),
              const DrawerTile(
                iconData: Icons.category,
                title: "Categorias",
                page: 1,
              ),
              const DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 2,
              ),
              const DrawerTile(
                iconData: Icons.playlist_add_check_rounded,
                title: "Meus Pedidos",
                page: 3,
              ),
              const DrawerTile(
                iconData: Icons.location_on_outlined,
                title: "Lojas",
                page: 4,
              ),
              const Divider(
                indent: 32,
              ),
              const DrawerTile(
                iconData: Icons.settings,
                title: "Definições",
                page: 5,
              ),
              const DrawerTile(
                iconData: Icons.description,
                title: "Sobre..",
                page: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
