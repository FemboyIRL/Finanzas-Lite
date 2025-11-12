import 'package:finanzas_lite/screens/enter_pin_screen/screen.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FinanzasLiteApp());
}

class FinanzasLiteApp extends StatelessWidget {
  const FinanzasLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App para la gestión de finanzas personales',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          labelSmall: TextStyle(fontSize: 12, color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          backgroundColor: const Color(0xFF4F4F4F),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          color: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
