import 'package:e_commerce_app/app/app.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    final selectedStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

    final unselectedStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black54,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Language',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 25),
          InkWell(
            onTap: () {
              provider.changeLanguage('ar');
              MyApp.setLocale(context, const Locale('ar', ''));
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    provider.language == 'ar'
                        ? Colors.orange.withValues(alpha: 0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'العربية',
                      style:
                          provider.language == 'ar'
                              ? selectedStyle
                              : unselectedStyle,
                    ),
                  ),
                  Icon(
                    provider.language == 'ar'
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color:
                        provider.language == 'ar' ? Colors.orange : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
              MyApp.setLocale(context, const Locale('en', ''));
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    provider.language == 'en'
                        ? Colors.orange.withValues(alpha: 0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'English',
                      style:
                          provider.language == 'en'
                              ? selectedStyle
                              : unselectedStyle,
                    ),
                  ),
                  Icon(
                    provider.language == 'en'
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color:
                        provider.language == 'en' ? Colors.orange : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
