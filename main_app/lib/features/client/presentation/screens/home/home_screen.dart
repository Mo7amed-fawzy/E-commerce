import 'package:e_commerce_app/features/client/presentation/screens/search/search_screen.dart';
import 'package:e_commerce_app/features/shared/widgets/layout/address_bar.dart';
import 'package:e_commerce_app/features/shared/widgets/layout/carousal_image.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/deal_of_day.dart';
import 'package:e_commerce_app/features/shared/widgets/layout/top_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void searchForProduct(String txt) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: txt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        titleSpacing: 10,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  onFieldSubmitted: searchForProduct,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black54),
                    hintText: AppLocalizations.of(context)!.searchInMySouq,
                    hintStyle: const TextStyle(color: Colors.black45),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressBar(),
              SizedBox(height: 12),
              TopCategories(),
              SizedBox(height: 15),
              CarouselImage(),
              SizedBox(height: 20),
              DealOfDay(),
            ],
          ),
        ),
      ),
    );
  }
}
