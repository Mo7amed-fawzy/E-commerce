import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/widgets/stars_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;

    if (product.rating != null && product.rating!.isNotEmpty) {
      for (int i = 0; i < product.rating!.length; i++) {
        totalRating += product.rating![i].rating;
      }

      avgRating = totalRating / product.rating!.length;
    }
    // double avgRating = 0;
    // double totalRating = 0;
    // if (product.rating != null) {
    //   for (final r in product.rating!) {
    //     totalRating += r.rating;
    //   }
    //   if (totalRating > 0) {
    //     avgRating = totalRating / product.rating!.length;
    //   }
    // }
    // // for (int i = 0; i < product.rating!.length; i++) {
    // //   totalRating += product.rating![i].rating;
    // // }
    // if (totalRating > 0) {
    //   avgRating = totalRating / product.rating!.length;
    // }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.firstImage,

                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: StarsBar(rating: avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      AppLocalizations.of(context)!.eligibleForFREEShipping,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.inStock,
                      style: const TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
