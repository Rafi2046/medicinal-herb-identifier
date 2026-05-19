import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/history_provider.dart';
import 'core/providers/theme_provider.dart';
import 'features/splash/presentations/page/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _primaryTeal = Color(0xFF00897B);

  static const Color _lightBg = Color(0xFFF0FDF4);
  static const Color _darkBg = Color(0xFF0F172A);
  static const Color _darkSurface = Color(0xFF1E293B);
  static const Color _darkCard = Color(0xFF334155);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        primaryColor: Colors.teal,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),

        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.teal.withValues(alpha: 0.2),
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primaryColor: Colors.teal,

        scaffoldBackgroundColor: _darkBg,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
          surface: _darkSurface,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: _darkSurface,
          surfaceTintColor: _darkSurface,
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: _darkCard,
          indicatorColor: Colors.teal.withValues(alpha: 0.2),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
