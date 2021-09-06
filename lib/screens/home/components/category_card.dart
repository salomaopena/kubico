import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/category/category.dart';
import 'package:kubico/screens/product/product_category.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: GestureDetector(
        onTap: () {
          Get.to(() => ProductCategory(category: category));
        },
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(category.image as String),
                    fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:Colors.black.withOpacity(.2)),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    category.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
