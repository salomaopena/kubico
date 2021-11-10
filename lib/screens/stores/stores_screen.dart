import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/stores/stores_manager.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/stores/components/store_card.dart';
import 'package:provider/provider.dart';

class StoresSreen extends StatelessWidget {
  const StoresSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            'Lojas',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actionsIconTheme: const IconThemeData.fallback(),
        ),
        body: Consumer<StoresManager>(
          builder: (_, storesManager, __) {
            if (storesManager.stores.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pink),
                  backgroundColor: Colors.transparent,
                ),
              );
            }
            return ListView.separated(
                itemCount: storesManager.stores.length,
                itemBuilder: (_, index) {
                  return StoreCard(stores: storesManager.stores[index]);
                },
                separatorBuilder: (_, index) => const SizedBox(height: 8));
          },
        ),
      ),
    );
  }
}
