import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية الصفحة
      appBar: AppBar(
        elevation: 5, // إضافة ظل خفيف للـ AppBar
        backgroundColor: Colors.white,
        title: Text(
          'Profile', // عنوان الصفحة
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87, // اللون الداكن لخط العنوان
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة البروفايل مع تأثير الظل
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://www.example.com/profile.jpg',
                ), // صورة المستخدم
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // تأثير الظل
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // اسم المستخدم
            Center(
              child: Text(
                'Mohamed Fawzy', // اسم المستخدم
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black87, // خط داكن وواضح
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Flutter Developer', // وصف الوظيفة
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey[600], // خط أنعم
                ),
              ),
            ),
            SizedBox(height: 30),

            // قسم الإعدادات - مع تعديل مكان الخيارات
            Card(
              elevation: 8, // زيادة تأثير الظل للـ Card لجعلها أكثر فخامة
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // زوايا دائرية
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان إعدادات الحساب
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black87, // اللون الداكن للنص
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),

                    // تغيير الصورة الشخصية
                    ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                        color: Colors.orange,
                      ), // أيقونة الكاميرا البرتقالية
                      title: Text('Change Profile Picture'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        // إضافة منطق لتغيير الصورة هنا
                      },
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),

                    // إعدادات اللغة
                    ListTile(
                      leading: Icon(Icons.language, color: Colors.orange),
                      title: Text('Language Settings'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        // إضافة منطق لتغيير اللغة هنا
                      },
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),

                    // تسجيل الخروج
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.orange,
                      ), // أيقونة تسجيل الخروج
                      title: Text('Log Out'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        // منطق لتسجيل الخروج
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
