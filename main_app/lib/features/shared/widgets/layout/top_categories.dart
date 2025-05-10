import 'package:e_commerce_app/features/client/presentation/screens/category/category_deal_screen.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void toCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDealScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocalizations.of(context)!.localeName == "ar";

    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: Declarations.catImages.length,
        itemBuilder: (context, index) {
          final category = Declarations.catImages[index];
          return GestureDetector(
            onTap: () => toCategoryPage(context, category['title']!),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        category['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 70,
                    child: Text(
                      getName(category['title']!, context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getName(String theName, BuildContext context) {
    switch (theName) {
      case "Mobiles":
        return AppLocalizations.of(context)!.mobiles;
      case "Appliances":
        return AppLocalizations.of(context)!.appliances;
      case "Fashion":
        return AppLocalizations.of(context)!.fashion;
      case "Essentials":
        return AppLocalizations.of(context)!.essentials;
      case "Computers":
        return AppLocalizations.of(context)!.computers;
      default:
        return "";
    }
  }
}
