import 'dart:ui'; // عشان استخدم المتغير color

abstract class AppColors {
  static const Color lightColor = Color(0xffDFECDB);
  static const Color darkColor = Color(0xff060E1E);

  // الألوان الأساسية الممكن يختار منها المستخدم
  static const Color whiteblue = Color(0xff5D9CEC);
  static const Color blue = Color(0xff5D9CEC);
  static const Color red = Color(0xffFF6B6B);
  static const Color green = Color(0xff4ECDC4);
  static const Color orange = Color(0xffFFA726);
  static const Color purple = Color(0xffBA68C8);
  static const Color teal = Color(0xff009688);
  static const Color yellow = Color(0xffFFEB3B);
  static const Color indigo = Color(0xff3F51B5);
  static const Color cyan = Color(0xff00BCD4);
  static const Color amber = Color(0xffFFC107);
  static const Color pink = Color(0xffF06292);

  // الألوان الفخمة (Luxury Colors)
  static const Color gold = Color(0xFFB59F5E);
  static const Color darkGrey = Color(0xFF3A3A3A);
  static const Color mediumGrey = Color(0xFF5C5C5C);
  static const Color bronze = Color(0xFFB44C10);
  static const Color richBlack = Color(0xFF1C1C1C);

  // إضافة الأبيض والشفاف
  static const Color white = Color(0xFFFFFFFF); // اللون الأبيض
  static const Color transparent = Color(0x00000000); // الشفاف

  static const Color black = Color(0xFF000000); // اللون الأسود
  static const Color grey = Color(0xFF808080); // اللون الرمادي
}
