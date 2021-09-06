import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/category/category_manager.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/product/product_category.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categoria de produto',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Consumer<CategoryManager>(
        builder: (_, categoryManager, __) {
          return AlphabetListScrollView(
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: (){
                    Get.to(()=>ProductCategory(category:categoryManager.categories[index]));
                  },
                  child: Card(
                    margin: EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4 ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    color: AppColors.white,
                    child: ListTile(
                        leading: AspectRatio(
                           aspectRatio: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Image.network(
                               categoryManager.categories[index].image as String,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            categoryManager.categories[index].name,
                            style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),

                  ),
                );
              },
              keyboardUsage: true,
              strList: categoryManager.names,
              indexedHeight: (index) => 90,
              showPreview: true,
              highlightTextStyle: const TextStyle(
                color: AppColors.black,
                fontSize: 24,
              ),
          
          );
        },
      ),
    );
  }
}
