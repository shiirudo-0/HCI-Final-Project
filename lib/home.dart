import 'package:flutter/material.dart';
import 'tracking_screen.dart';
import 'achievement_list.dart';
import 'Settings.dart';
import 'planner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    final Color cardBgColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEAEAEA);
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color brandGreen = const Color(0xFF5FA75D);

    return Scaffold(
      backgroundColor: bgColor,
      drawer: Drawer(
        backgroundColor: bgColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: brandGreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/gymchad.png', height: 60),
                  const SizedBox(height: 16),
                  const Text(
                    "GYMCHAD",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: textColor),
              title: Text("Home", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: textColor),
              title: Text("Planner", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlannerScreen()), 
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events, color: textColor),
              title: Text("Achievements", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AchievementListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run, color: textColor),
              title: Text("Tracker", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: Image.asset('assets/gymchad.png', height: 35),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: Icon(Icons.settings, color: textColor, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildWatermarkBackground(isDark),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "WELCOME, USER!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 25,
                        children: [
                          buildMenuCard(context, Icons.directions_run, "Tracker", cardBgColor, textColor),
                          buildMenuCard(context, Icons.calendar_today, "Planner", cardBgColor, textColor),
                          buildMenuCard(context, Icons.emoji_events, "Achievements", cardBgColor, textColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuCard(BuildContext context, IconData icon, String title, Color cardColor, Color textColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (title == "Tracker") {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingScreen()));
              } else if (title == "Achievements") {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AchievementListScreen()));
              } else if (title == "Planner") {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PlannerScreen()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PlaceholderPage(title)));
              }
            },
            child: Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              child: Icon(icon, size: 38, color: textColor),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildWatermarkBackground(bool isDark) {
    return IgnorePointer(
      child: Opacity(
        opacity: isDark ? 0.15 : 0.1,
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
            return Center(
              child: Image.asset(
                'assets/gymchad.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade500,
                colorBlendMode: BlendMode.modulate,
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        title: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      ),
      body: Center(child: Text("$title Page", style: const TextStyle(fontSize: 22))),
    );
  }
}