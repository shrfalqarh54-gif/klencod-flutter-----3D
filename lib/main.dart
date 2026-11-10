import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // استدعاء شاشة المنهج الرئيسية

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PhysicsApp());
}

class PhysicsApp extends StatelessWidget {
  const PhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فيزياء 3 ثانوي - تفاعلي',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1128),
        primaryColor: const Color(0xFF121B38),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFF001F54),
          surface: Color(0xFF121B38),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A1128),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
          titleTextStyle: TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const HomeScreen(), // توجيه التطبيق لشاشة الوحدات الجديدة
    );
  }
}