import 'package:flutter/material.dart';
import 'main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).iconTheme.color),
        title: Text(
          'SETTINGS',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            SettingsToggle(
              icon: Icons.notifications,
              label: "NOTIFICATIONS",
              value: notificationsEnabled,
              onChanged: (val) {
                setState(() {
                  notificationsEnabled = val;
                });
                // TODO: Add notification toggle logic here
              },
            ),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, currentMode, _) {
                bool darkModeEnabled = currentMode == ThemeMode.dark;
                return SettingsToggle(
                  icon: Icons.nightlight_round,
                  label: "DARK MODE",
                  value: darkModeEnabled,
                  onChanged: (val) {
                    themeNotifier.value =
                        val ? ThemeMode.dark : ThemeMode.light;
                  },
                );
              },
            ),
            Spacer(),
            GestureDetector(
              onTap: () => logOut(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.black87),
                    SizedBox(width: 8),
                    Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut(BuildContext context) {
    // Clear user data, tokens, sessions here if needed

    // Navigate to splash screen, removing all previous routes
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/splash',
      (Route<dynamic> route) => false,
    );
  }
}

class SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  SettingsToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        activeColor: Colors.blue,
        secondary: Icon(icon, color: color),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}