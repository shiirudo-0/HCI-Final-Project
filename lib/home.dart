import 'package:flutter/material.dart';
import 'tracking_screen.dart';
import 'achievement_list.dart';
import 'Settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('gymchad.png', height: 60),
                  SizedBox(height: 20),
                  Text(
                    "GYMCHAD",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text("Planner"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlaceholderPage("Planner")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text("Achievements"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AchievementListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text("Tracker"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TrackingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        title: Row(
          children: [
            Image.asset('gymchad.png', height: 40),
            SizedBox(width: 20),
            Text(
              "GYMCHAD",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "WELCOME, USER!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                children: [
                  buildMenuCard(context, Icons.directions_run, "Tracker"),
                  buildMenuCard(context, Icons.calendar_today, "Planner"),
                  buildMenuCard(context, Icons.emoji_events, "Achievements"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Tracker") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TrackingScreen()),
          );
        } else if (title == "Achievements") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AchievementListScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PlaceholderPage(title)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2A2A2A)
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title Page", style: TextStyle(fontSize: 22))),
    );
  }
}
