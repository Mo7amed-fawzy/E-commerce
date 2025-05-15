import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/features/admin/presentation/admin_screen.dart';
import 'package:e_commerce_app/core/services/auth_service.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final authService = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Column(
      children: [
        // Row for Wish List and Log Out buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTopButton("Wish List", () {}),
            _buildTopButton("Log Out", () {
              showAlertDialog(
                context,
                () {
                  authService.logOut(context);
                },
                'Stop',
                'Do you want to log out ?',
              );
            }),
          ],
        ),
        const SizedBox(height: 20),

        // Row for Admin Tools button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopButton("Admin Tools", () {
              if (user.type == "admin") {
                Navigator.pushNamed(context, AdminScreen.routeName);
              } else {
                showAlertDialog2(
                  context,
                  'Stop',
                  'You don\'t have access permission.',
                );
              }
            }),
          ],
        ),
      ],
    );
  }

  // Custom method to build buttons with a luxurious style for a light theme
  Widget _buildTopButton(String text, VoidCallback onClick) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // White background for light theme
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ), // Rounded corners for a sleek look
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 2,
            ), // Light border for a soft touch
          ),
          shadowColor: Colors.black.withOpacity(
            0.1,
          ), // Subtle shadow for light theme
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87, // Dark text for readability
            fontWeight: FontWeight.w600, // Bold text for emphasis
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
