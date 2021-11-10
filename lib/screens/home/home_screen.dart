import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/category/category_manager.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/home/components/banner.dart';
import 'package:kubico/screens/home/components/category_card.dart';
import 'package:kubico/screens/home/components/section_title.dart';
import 'package:kubico/screens/product/components/search_dialog.dart';
import 'package:kubico/screens/product_details/product_detail_screen.dart';
import 'package:kubico/utils/config.dart';
import 'package:kubico/utils/icon_badge.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class HomeScrenn extends StatelessWidget {
  HomeScrenn({Key? key}) : super(key: key);

  DateTime backpressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final MQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(backpressed);
        final cantExit = timegap >= Duration(seconds: 2);

        backpressed = DateTime.now();

        if (cantExit) {
          Flushbar(
            icon: Icon(
              FontAwesomeIcons.lock,
              color: AppColors.red,
            ),
            title: 'Sair da aplicação',
            titleColor: AppColors.red,
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.primaryColor,
            messageColor: AppColors.black,
            messageText: Text(
              'Pressione novamente para sair...',
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            flushbarPosition: FlushbarPosition.TOP,
            isDismissible: true,
          ).show(context);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title:
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return Text(
                  'Kubico de Beleza',
                  style: GoogleFonts.roboto(
                      color: Colors.pink,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
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
                    child: SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          productManager.search,
                          style: GoogleFonts.roboto(
                            color: Colors.pink,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                  icon: const Icon(
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
                  icon: const Icon(
                    Icons.close,
                    color: Colors.pink,
                  ),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            }),
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
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      HomeBanner(),
                      const SizedBox(height: 4),
                      SectionTitle(
                        title: "Nossos produtos",
                        press: () {},
                        subtitle: '',
                      ),
                      const SizedBox(height: 8),
                      Consumer<CategoryManager>(
                          builder: (_, categoryManager, __) {
                        return SizedBox(
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
                    subtitle: 'Mais procurados',
                  ),
                ),
              ),
            ];
          },
          body: Consumer<ProductManager>(builder: (_, productManager, __) {
            final filteredProducts = productManager.filteredProducts;
            if (filteredProducts.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                  backgroundColor: Colors.transparent,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: filteredProducts.length,
                itemBuilder: (_, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      if (product != null) {
                        final productFound = productManager
                            .findProductById(product.id as String);
                        if (productFound != null) {
                          Get.to(
                              () => ProductDetailScreen(product: productFound));
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                  child: CachedNetworkImage(
                                    imageUrl: product.images.first,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.medium,
                                    progressIndicatorBuilder: (_,
                                        __,
                                        DownloadProgress
                                        downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              valueColor:
                                              const AlwaysStoppedAnimation(
                                                  Colors.pink),
                                            )),
                                    errorWidget: (_, __, ___) => Image.asset(
                                      'images/logo.png',
                                      filterQuality: FilterQuality.high,
                                      isAntiAlias: true,
                                      fit: BoxFit.fill,
                                    ),
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
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'A partir de',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
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
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) =>
                    new StaggeredTile.count(2, index.isEven ? 2.5 : 1.7),
                //new StaggeredTile.count(1, index.isEven ? 1.7 : 1.3),
              ),
            );
          }),
        ),
      ),
    );
  }
}
