import 'package:e_commerce_app/features/client/presentation/screens/search/search_screen.dart';
import 'package:e_commerce_app/features/shared/widgets/layout/below_app_bar.dart';
import 'package:e_commerce_app/features/client/presentation/screens/orders/orders.dart';
import 'package:e_commerce_app/features/shared/widgets/layout/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSearchOpen = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      isSearchOpen = !isSearchOpen;
      if (!isSearchOpen) _searchController.clear();
    });
  }

  void _searchForProduct(String text) {
    if (text.trim().isEmpty) return;
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: text);
    _toggleSearch(); // اغلق السيرش بعد البحث
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white.withOpacity(0.85),
          elevation: 0,
          title: Row(
            children: [
              Image.asset('assets/images/logo.png', width: 90),
              const Spacer(),
              if (isSearchOpen)
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 40,
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: _searchForProduct,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'ابحث...',
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
              IconButton(
                onPressed: _toggleSearch,
                icon: Icon(
                  isSearchOpen ? Icons.close : Icons.search,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (_) => const SizedBox(
                          height: 300,
                          child: Center(
                            child: Text('Notifications will appear here'),
                          ),
                        ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: const [
              BelowAppBar(),
              SizedBox(height: 10),
              TopButtons(),
              SizedBox(height: 15),
              Orders(),
            ],
          ),
        ),
      ),
    );
  }
}
