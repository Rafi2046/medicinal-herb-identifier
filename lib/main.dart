import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'features/splash/presentations/page/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _primaryGreen = Color(0xFF27AE60);
  static const Color _lightBg = Color(0xFFF0FDF4);
  static const Color _darkBg = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkCard = Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primaryColor: _primaryGreen,
        scaffoldBackgroundColor: _darkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryGreen,
          brightness: Brightness.dark,
          surface: _darkSurface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _darkSurface,
          surfaceTintColor: _darkSurface,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: _darkCard,
          indicatorColor: _primaryGreen.withOpacity(0.2),
        ),
      ),

      themeMode: themeProvider.themeMode,

      home: const SplashScreen(),
    );
  }
}
