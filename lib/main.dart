import 'package:finanzas_lite/screens/login_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: "https://afmhatdjnlxoosyjhexe.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFmbWhhdGRqbmx4b29zeWpoZXhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2NzIwMzIsImV4cCI6MjA3OTI0ODAzMn0.ZaT4hyigD_8dC5c6PwxirZ8wyCADl14D3LsIh8VH8u0",
  );

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
      home: const LoginEmailScreen(),
    );
  }
}
