import 'package:flutter/material.dart';

class Achievement {
  final String title;
  double progress; // 0.0 to 1.0

  Achievement(this.title, this.progress);

  bool get isCompleted => progress >= 1.0;
}

class AchievementListScreen extends StatefulWidget {
  @override
  _AchievementListScreenState createState() => _AchievementListScreenState();
}

class _AchievementListScreenState extends State<AchievementListScreen> {
  // Initialize achievements with 0 progress (none completed)
  List<Achievement> achievements = [
    Achievement("First Step", 0.0),
    Achievement("1 km Walk", 0.0),
    Achievement("5 km Walk", 0.0),
    Achievement("10 km Walk", 0.0),
    Achievement("30 minutes Active", 0.0),
    Achievement("1 Hour Active", 0.0),
    Achievement("Burn 100 Calories", 0.0),
    Achievement("Burn 500 Calories", 0.0),
    Achievement("Morning Runner", 0.0),
    Achievement("Night Owl", 0.0),
    Achievement("3 Days Streak", 0.0),
    Achievement("7 Days Streak", 0.0),
    Achievement("30 Days Streak", 0.0),
    Achievement("10 Sessions", 0.0),
    Achievement("First Route Saved", 0.0),
    Achievement("Explorer", 0.0),
    Achievement("Social Starter", 0.0),
    Achievement("Half Marathon", 0.0),
    Achievement("Marathon", 0.0),
    Achievement("100 km Milestone", 0.0),
    Achievement("200 km Milestone", 0.0),
    Achievement("500 km Milestone", 0.0),
    Achievement("Early Bird", 0.0),
    Achievement("Sunset Walker", 0.0),
    Achievement("Weekend Warrior", 0.0),
    Achievement("Weekend Champion", 0.0),
    Achievement("Weekday Warrior", 0.0),
    Achievement("Weather Ready", 0.0),
    Achievement("Quick Start", 0.0),
    Achievement("Pro Tracker", 0.0),
    Achievement("Race Pace", 0.0),
    Achievement("Cool Down", 0.0),
    Achievement("Longest Walk", 0.0),
    Achievement("First Pause", 0.0),
    Achievement("First Resume", 0.0),
    Achievement("Follow Fan", 0.0),
    Achievement("Fast Finisher", 0.0),
    Achievement("Energy Burner", 0.0),
    Achievement("Daily Habit", 0.0),
    Achievement("Fitness Master", 0.0),
    Achievement("Trail Blazer", 0.0),
    Achievement("Distance Beast", 0.0),
    Achievement("Night Vision", 0.0),
    Achievement("Sunrise Seeker", 0.0),
    Achievement("Early Starter", 0.0),
    Achievement("Night Runner", 0.0),
    Achievement("Midnight Move", 0.0),
    Achievement("New Record", 0.0),
    Achievement("Heart Pacer", 0.0),
    Achievement("Ultimate Achiever", 0.0),
  ];

  int get completedCount =>
      achievements.where((a) => a.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ACHIEVEMENTS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('gymchad.png', height: 40),
              SizedBox(width: 12),
          Text(
            "ACHIEVEMENTS $completedCount/50",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return AchievementCard(
                  title: achievement.title,
                  index: index + 1,
                  progress: achievement.progress,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final String title;
  final int index;
  final double progress;

  AchievementCard({
    required this.title,
    required this.index,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final bool completed = progress >= 1.0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green[300]
            : (Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF2A2A2A)
                : Colors.grey[300]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. $title",
            style: TextStyle(
              fontSize: 16,
              fontWeight: completed ? FontWeight.bold : FontWeight.normal,
              color: completed ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: completed ? Colors.green[700] : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[400]),
              valueColor: AlwaysStoppedAnimation<Color>(
                  completed ? Colors.white : Colors.blue),
              minHeight: 8,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "${(progress * 100).toStringAsFixed(0)}% completed",
            style: TextStyle(
              fontSize: 12,
              color: completed ? Colors.white70 : Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}