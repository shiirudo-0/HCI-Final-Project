import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
                  Image.asset('assets/logo.png', height: 50),
                  SizedBox(height: 10),
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
              leading: Icon(Icons.fitness_center),
              title: Text("Workout"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlaceholderPage("Workout")),
                );
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
                  MaterialPageRoute(builder: (_) => PlaceholderPage("Achievements")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text("Tracker"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlaceholderPage("Tracker")),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset('gymchad.png', height: 30),
            SizedBox(width: 10),
            Text(
              "GYMCHAD",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PlaceholderPage("Settings")),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
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
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                children: [
                  buildMenuCard(context, Icons.fitness_center, "Start workout"),
                  buildMenuCard(context, Icons.calendar_today, "Planner"),
                  buildMenuCard(context, Icons.emoji_events, "Achievements"),
                  buildMenuCard(context, Icons.directions_run, "Tracker"),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlaceholderPage(title)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title Page",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
