import 'package:flutter/material.dart';
import 'home.dart';

class OnboardingContent {
  String title;
  String description;
  IconData icon;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Track Your Progress.',
    description:
        'Log exercises, sets, and reps with ease. Keep a complete record of every workout you complete.',
    icon: Icons.trending_up_rounded,
  ),
  OnboardingContent(
    title: 'Be like a Gymchad.',
    description:
        'Show up. Stay consistent. Track workouts, build habits, and become the strongest version of yourself.',
    icon: Icons.accessibility_new,
  ),
  OnboardingContent(
    title: 'Get Started',
    description:
        'Your future physique is built by todays effort. Stay consistent and never miss a session.',
    icon: Icons.fitness_center,
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Color(0xFF5FAA58)
            : Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          _buildWatermarkBackground(),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              contents[i].icon,
                              size: 150,
                              color: Color(0xFF5FAA58),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              contents[i].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                        ),
                        child: const Text(
                          "SKIP",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (index) => buildDot(index, context),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (currentIndex == contents.length - 1) {
                            Navigator.pushReplacementNamed(context, '/login');
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5FAA58),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          currentIndex == contents.length - 1 ? "START" : "NEXT",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatermarkBackground() {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.15,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Center(
              child: Image(
                image: AssetImage('assets/gymchad.png'),
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}