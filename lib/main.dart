import 'package:flutter/material.dart';
import 'home.dart';
import 'onboardingscreen.dart';

void main() {
  runApp(MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GYMCHAD',
          theme: ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black87),
              bodyMedium: TextStyle(color: Colors.black87),
              bodySmall: TextStyle(color: Colors.black54),
              displayLarge: TextStyle(color: Colors.black87),
              displayMedium: TextStyle(color: Colors.black87),
              titleLarge: TextStyle(color: Colors.black87),
            ),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF1E1E1E),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.grey),
              displayLarge: TextStyle(color: Colors.white),
              displayMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
            ),
            cardColor: const Color(0xFF1E1E1E),
          ),
          themeMode: currentMode,
          home: const OnboardingScreen(),
          routes: {
            '/splash': (context) => const OnboardingScreen(),
            '/home': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
