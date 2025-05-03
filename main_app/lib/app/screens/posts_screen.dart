import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/app/screens/add_products.dart';
import 'package:e_commerce_app/app/services/admin_service.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:e_commerce_app/widgets/single_product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminService adminService = AdminService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  getAllProducts() async {
    products = await adminService.getAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
          body: GridView.builder(
            itemCount: products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final theProduct = products![index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: theProduct.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              theProduct.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showAlertDialog(
                              context,
                              () {
                                deleteProduct(theProduct, index);
                                Navigator.pop(context);
                              },
                              'Delete Product',
                              'Are you sure? to delete this product',
                            );
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.routeName);
            },
            tooltip: 'add product',
            child: const Icon(Icons.add),
          ),
        );
  }
}
