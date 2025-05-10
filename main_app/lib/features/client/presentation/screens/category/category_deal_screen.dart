import 'package:e_commerce_app/core/models/product.dart';
import 'package:e_commerce_app/core/services/home_service.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/core/widgets/loader.dart';
import 'package:flutter/material.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({super.key, required this.category});

  static const String routeName = "/category-deal";
  final String category;

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.getCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Declarations.appBarGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body:
          productList == null
              ? const Loader()
              : GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  // final product = productList![index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
