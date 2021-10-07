import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/category/category.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/cart/components/empty_card.dart';
import 'package:kubico/screens/product/components/product_list_tile.dart';
import 'package:kubico/screens/product/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return Text(
                  category.name,
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
          actionsIconTheme: IconThemeData.fallback(),
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
          final filteredProducts =
              productManager.filteredProductsByCategory(category.id);
          if (filteredProducts.length == 0) {
            return EmptyCard(
                icon: Icons.hourglass_empty,
                title:
                    'Nenhum produto cadastrado para a categoria de ${category.name}');
          }
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
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
