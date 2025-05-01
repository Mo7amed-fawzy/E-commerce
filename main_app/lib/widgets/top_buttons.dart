import 'package:e_commerce_app/app/screens/admin_screen.dart';
import 'package:e_commerce_app/app/services/auth_service.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "wish list", onClick: () {}),
            AccountButton(
              text: "log out",
              onClick: () {
                showAlertDialog(
                  context,
                  () {
                    authService.logOut(context);
                  },
                  'Stop',
                  'Do you want to log out ?',
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: "admin Tools",
              onClick: () {
                if (user.type == "admin") {
                  Navigator.pushNamed(context, AdminScreen.routeName);
                } else {
                  showAlertDialog2(
                    context,
                    'Stop',
                    'you don\'t have an access permission',
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
