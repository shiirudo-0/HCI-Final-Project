import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar is the header at the top of the screen
      appBar: AppBar(
        title: const Text("Gymchad"),
        backgroundColor: Color(0xFF5FAA58),
        foregroundColor: Colors.white,
      ),

      // Center places our text perfectly in the middle of the screen
      body: const Center(
        child: Text(
          "Welcome to Gymchad!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}