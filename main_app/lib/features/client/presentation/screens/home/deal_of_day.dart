import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/core/models/product.dart';
import 'package:e_commerce_app/features/client/presentation/screens/product/product_details_screen.dart';
import 'package:e_commerce_app/core/services/home_service.dart';
import 'package:e_commerce_app/my_premium_collection/premium_refresh_indicator.dart';
import 'package:e_commerce_app/core/widgets/loader.dart';
import 'package:e_commerce_app/features/shared/widgets/product/product_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? productList;
  final homeService = getIt<HomeService>();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.dealOfProducts(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _refreshData() async {
    await fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment:
              AppLocalizations.of(context)!.localeName == 'ar'
                  ? Alignment.topRight
                  : Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Text(
            AppLocalizations.of(context)!.dealOfTheDay,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple, // Use elegant color like deep purple
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(
          height: 500,
          width: double.infinity,
          child:
              productList == null
                  ? const Loader()
                  : PremiumRefreshIndicator(
                    strokeWidth: 3.0,
                    displacement: 40.0,
                    triggerDistance: 100.0,
                    showIcon: true,
                    iconSize: 24.0,
                    useFadeTransition: true,
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemCount: productList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailScreen.routeName,
                              arguments: productList![index],
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ProductCardHorizontal(
                              product: productList![index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
        ),
      ],
    );
  }
}
