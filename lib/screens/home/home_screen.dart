import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/category/category_manager.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/home/components/banner.dart';
import 'package:kubico/screens/home/components/category_card.dart';
import 'package:kubico/screens/home/components/section_title.dart';
import 'package:kubico/screens/product_details/product_detail_screen.dart';
import 'package:kubico/utils/config.dart';
import 'package:kubico/utils/icon_badge.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScrenn extends StatelessWidget {
  const HomeScrenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MQuery = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Kubico de Beleza',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<CartManager>(builder: (_, cartManager, __) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconBadge(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.pink,
                ),
                itemCount: cartManager.itemCartSize,
                badgeColor: AppColors.red,
                itemColor: Colors.white,
                hideZero: true,
                onTap: () {
                  Get.to(() => CartScreen());
                },
              ),
            );
          }),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: [
                    HomeBanner(),
                    const SizedBox(height: 8),
                    SectionTitle(
                      title: "Nossos produtos",
                      press: () {},
                      subtitle: '',
                    ),
                    const SizedBox(height: 8),
                    Consumer<CategoryManager>(
                        builder: (_, categoryManager, __) {
                      return Container(
                        height: MQuery.height * 0.1,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryManager.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              category: categoryManager.categories[index],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 10),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                );
              }, childCount: 1),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: ContestTabHeader(
                SectionTitle(
                  title: "Oferta exclusiva",
                  press: () {},
                  subtitle: 'Nossos produtos',
                ),
              ),
            ),
          ];
        },
        body: Consumer<ProductManager>(builder: (_, productManager, __) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemCount: productManager.filteredProducts.length,
              itemBuilder: (_, index) {
                final product = productManager.filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    if (product != null) {
                      final productFound =
                          productManager.findProductById(product.id as String);
                      if (productFound != null) {
                        Get.to(
                            () => ProductDetailScreen(product: productFound));
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: product.images.first,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'A partir de',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'AOA ${product.basePrice.toStringAsFixed(2)}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.pink,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) =>
                  new StaggeredTile.count(2, index.isEven ? 2.5 : 1.5),
              //new StaggeredTile.count(1, index.isEven ? 1.7 : 1.3),
            ),
          );
        }),
      ),
    );
  }
}
