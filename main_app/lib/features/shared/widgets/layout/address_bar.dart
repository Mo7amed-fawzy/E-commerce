import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/my_premium_collection/premium_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final isArabic = AppLocalizations.of(context)!.localeName == 'ar';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_outlined, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${AppLocalizations.of(context)!.addressOf} - ',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  TextSpan(
                    text: '${user.name}, ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: user.address,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          PremiumDropdownMenu(
            menuItems: ['Change Address', 'Add New Address', 'Settings'],
            onItemSelected: (value) {
              // معالجة الخيار الذي تم اختياره
              printHere(value); // يمكنك تخصيص المعالجة هنا
            },
            animationDuration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
