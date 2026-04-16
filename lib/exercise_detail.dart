import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'planner.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseDetail exercise;
  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final Color cardColor = isDark ? const Color(0xFF2A2A2A) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color brandGreen = const Color(0xFF5FA75D);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            PlannerScreen.buildWatermarkBackground(isDark),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      PlannerScreen.buildBackButton(context, isDark),
                      Expanded(
                        child: Text(
                          exercise.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
                        ),
                      ),
                      Image.asset('assets/gymchad.png', width: 42, height: 42, fit: BoxFit.contain),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200, width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEAEAEA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ExerciseVideoPlayer(videoUrl: exercise.videoUrl, textColor: textColor),
                        ),
                        const SizedBox(height: 24),
                        Wrap(
  spacing: 12, // Horizontal space between badges
  runSpacing: 12, // Vertical space if it gets pushed to a new line
  children: [
    _buildBadge(Icons.accessibility_new, exercise.muscle, cardColor, textColor),
    _buildBadge(Icons.fitness_center, exercise.equipment, cardColor, textColor),
  ],
),
                        const SizedBox(height: 12),
                        _buildBadge(Icons.speed, "Difficulty: ${exercise.difficulty}", cardColor, textColor),
                        const SizedBox(height: 32),
                        Text("Instructions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor)),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor, borderRadius: BorderRadius.circular(20),
                            boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(exercise.steps.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${index + 1}.", style: TextStyle(fontWeight: FontWeight.bold, color: brandGreen, fontSize: 16)),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(exercise.steps[index], style: TextStyle(color: textColor, fontSize: 15, height: 1.4))),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    colors: [bgColor, bgColor.withOpacity(0.8), bgColor.withOpacity(0.0)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandGreen, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(exercise.isTimerBased ? Icons.timer : Icons.add),
                      const SizedBox(width: 10),
                      Text(exercise.isTimerBased ? "START TIMER" : "LOG SET", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text, Color cardColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF5FA75D)),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class ExerciseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Color textColor;
  const ExerciseVideoPlayer({super.key, required this.videoUrl, required this.textColor});

  @override
  State<ExerciseVideoPlayer> createState() => _ExerciseVideoPlayerState();
}

class _ExerciseVideoPlayerState extends State<ExerciseVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _hasValidUrl = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl.isNotEmpty) {
      _hasValidUrl = true;
      final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '';
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId, autoPlay: true,
        params: const YoutubePlayerParams(mute: true, showControls: false, showFullscreenButton: false, loop: true),
      );
    }
  }

  @override
  void dispose() {
    if (_hasValidUrl) { _controller.close(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasValidUrl) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 40, color: widget.textColor.withOpacity(0.3)),
            const SizedBox(height: 8),
            Text("Video coming soon", style: TextStyle(color: widget.textColor.withOpacity(0.5), fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }
    return ClipRRect(borderRadius: BorderRadius.circular(20), child: YoutubePlayer(controller: _controller));
  }
}