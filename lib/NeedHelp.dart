import 'package:flutter/material.dart';

class NeedHelpScreen extends StatelessWidget {
  const NeedHelpScreen({super.key});

  // Brand Colors
  final Color brandGreen = const Color(0xFF5FA75D);
  final Color bgColor = const Color(0xFFF2F2F2);
  final Color cardBgColor = Colors.white;
  final Color labelGray = const Color(0xFF8E8E8E);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brandGreen = const Color(0xFF5FA75D);
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF2F2F2);
    final cardBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final labelGray = isDark ? Colors.grey : const Color(0xFF8E8E8E);
    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 Background watermark
            // _buildWatermarkBackground(),

            // 🔹 Back button
            Positioned(
              top: 16,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    size: 22,
                    color: iconColor,
                  ),
                ),
              ),
            ),

            // 🔹 Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🔹 Logo
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: brandGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Image(
                          image: AssetImage('assets/gymchad.png'),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 🔹 Title
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Contact us if you're having trouble accessing your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: labelGray,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 🔹 Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Information",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),

                          const SizedBox(height: 20),

                          _buildContactItem(
                            icon: Icons.phone_android,
                            label: "Phone",
                            value: "+63 912 345 6789",
                            textColor: textColor,
                            labelGray: labelGray,
                          ),
                          _buildContactItem(
                            icon: Icons.email_outlined,
                            label: "Email",
                            value: "support@gymchad.com",
                            textColor: textColor,
                            labelGray: labelGray,
                          ),
                          _buildContactItem(
                            icon: Icons.access_time,
                            label: "Office Hours",
                            value: "Mon - Fri | 9:00 AM - 5:00 PM",
                            textColor: textColor,
                            labelGray: labelGray,
                          ),
                          _buildContactItem(
                            icon: Icons.location_on_outlined,
                            label: "Location",
                            value: "Quezon City, Philippines",
                            textColor: textColor,
                            labelGray: labelGray,
                          ),

                          const SizedBox(height: 20),

                          Center(
                            child: Text(
                              "Our team usually responds within 24 hours",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: labelGray,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Contact item widget
  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
    required Color labelGray,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: brandGreen, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: labelGray,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}