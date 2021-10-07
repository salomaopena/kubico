import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/product/components/product_list_tile.dart';
import 'package:kubico/screens/product/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text(
                'Produtos',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.pink,
                  fontWeight: FontWeight.w700,
                ),
              );
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )),
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.pink,
                ),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.pink,
                ),
                onPressed: () async {
                  productManager.search = '';
                },
              );
            }
          }),
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(product: filteredProducts[index]);
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink,
        onPressed: () {
          Get.to(() => CartScreen());
        },
        child: const Icon(
          Icons.shopping_cart,
          size: 32,
        ),
      ),
    );
  }
}
