import 'package:e_commerce_app/core/databases/local/theme_mode.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:e_commerce_app/features/client/presentation/setting/change_password_screen.dart';
import 'package:e_commerce_app/features/client/presentation/setting/contact_support.dart';
import 'package:e_commerce_app/features/client/presentation/setting/help_center.dart';
import 'package:e_commerce_app/features/client/presentation/setting/language_bottom_sheet.dart';
import 'package:e_commerce_app/features/client/presentation/setting/report.dart';
import 'package:e_commerce_app/features/client/presentation/setting/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = true;
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool biometricAuth = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
            child: Text(
              'GENERAL',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    Provider.of<UserProvider>(context).language == 'ar'
                        ? 'العربية'
                        : 'English',
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (_) => LanguageBottomSheet(),
                    );
                  },
                ),

                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Switch(
                    value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                    onChanged: (val) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
            child: Text(
              'NOTIFICATIONS',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.notifications_active_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Push Notifications',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Switch(
                    value: pushNotifications,
                    onChanged: (val) => setState(() => pushNotifications = val),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Email Notifications',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Switch(
                    value: emailNotifications,
                    onChanged:
                        (val) => setState(() => emailNotifications = val),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
            child: Text(
              'SECURITY',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Change Password',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.fingerprint,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Biometric Authentication',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Switch(
                    value: biometricAuth,
                    onChanged: (val) => setState(() => biometricAuth = val),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
            child: Text(
              'APP PREFERENCES',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.color_lens_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text('App Theme'),
                  subtitle: Text('Pick your favorite color'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    showColorPickerPopup(context);
                  },
                ),

                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.format_size,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Text Size',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text('Medium'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
            child: Text(
              'SUPPORT',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Help Center',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HelpCenterScreen()),
                    );
                  },
                ),
                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.support_agent,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Contact Support',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactSupportScreen(),
                      ),
                    );
                  },
                ),

                Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: Icon(
                    Icons.bug_report_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Report a Bug',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  onTap: () => showBugReportPopup(context),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),
          Center(
            child: Text(
              'App version 1.0.0',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => LanguageBottomSheet(),
  );
}
