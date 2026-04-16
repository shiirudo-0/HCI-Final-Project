import 'package:flutter/material.dart';
import 'exercise_detail.dart';

class ExerciseDetail {
  final String name;
  final String muscle;
  final String equipment;
  final String difficulty;
  final List<String> steps;
  final bool isTimerBased;
  final String videoUrl; 

  ExerciseDetail({
    required this.name,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.steps,
    required this.videoUrl, 
    this.isTimerBased = false,
  });
}

class ExerciseData {
  static Map<String, List<ExerciseDetail>> exercises = {
    "Chest": [
      ExerciseDetail(
        name: "Bench Press",
        muscle: "Pectorals",
        equipment: "Barbell & Bench",
        difficulty: "Intermediate",
        videoUrl: 'https://www.youtube.com/watch?v=4Y2ZdHCOXok',
        steps: [
          "Lie flat on the bench with your eyes under the bar.",
          "Grip the bar slightly wider than shoulder-width.",
          "Lower the bar to your mid-chest in a controlled motion.",
          "Press the bar back up powerfully."
        ],
      ),
      ExerciseDetail(
        name: "Push-up",
        muscle: "Chest & Triceps",
        equipment: "Bodyweight",
        difficulty: "Beginner",
        videoUrl: 'https://www.youtube.com/watch?v=IODxDxX7oi4',
        steps: [
          "Place hands slightly wider than shoulder-width apart.",
          "Keep your body in a straight line from head to heels.",
          "Lower your body until your chest grazes the floor.",
          "Push back up to the starting position."
        ],
      ),
      ExerciseDetail(
        name: "Chest Fly",
        muscle: "Pectorals",
        equipment: "Dumbbells",
        difficulty: "Intermediate",
        videoUrl: 'https://www.youtube.com/watch?v=eozdVDA78K0',
        steps: [
          "Lie on a bench holding dumbbells straight above your chest.",
          "Keep a slight bend in your elbows.",
          "Slowly lower your arms out to the sides in a wide arc.",
          "Squeeze your chest muscles to bring the weights back up."
        ],
      ),
    ],
    "Bicep": [
      ExerciseDetail(
        name: "Dumbbell Curl",
        muscle: "Biceps",
        equipment: "Dumbbells",
        difficulty: "Beginner",
        videoUrl: 'https://www.youtube.com/watch?v=ykJmrZ5v0Oo',
        steps: [
          "Stand straight holding a dumbbell in each hand.",
          "Keep your elbows pinned to your sides.",
          "Curl the weights upward while contracting your biceps.",
          "Lower the weights slowly and controlled."
        ],
      ),
      ExerciseDetail(
        name: "Hammer Curl",
        muscle: "Brachialis & Biceps",
        equipment: "Dumbbells",
        difficulty: "Beginner",
        videoUrl: 'https://www.youtube.com/watch?v=zC3nLlEvin4',
        steps: [
          "Stand holding dumbbells with palms facing your torso (neutral grip).",
          "Keep elbows stationary.",
          "Curl the weight up, maintaining the neutral grip.",
          "Lower slowly."
        ],
      ),
      ExerciseDetail(
        name: "Concentration Curl",
        muscle: "Biceps Peak",
        equipment: "Dumbbell & Bench",
        difficulty: "Intermediate",
        videoUrl: 'https://www.youtube.com/watch?v=Jvj2wV0vOYU',
        steps: [
          "Sit on a bench with your legs apart.",
          "Rest the back of your working arm against your inner thigh.",
          "Curl the dumbbell upward, focusing on the bicep contraction.",
          "Lower slowly back to the start."
        ],
      ),
    ],
    "Calves": [
      ExerciseDetail(
        name: "Standing Calf Raise",
        muscle: "Gastrocnemius",
        equipment: "Machine / Dumbbells",
        difficulty: "Beginner",
        videoUrl: 'https://www.youtube.com/watch?v=YMmgqO8Jo-k',
        steps: [
          "Stand on the edge of a step or block, heels hanging off.",
          "Keep your knees mostly straight but not locked.",
          "Drop your heels down to stretch the calves.",
          "Push up onto your toes as high as possible and squeeze."
        ],
      ),
      ExerciseDetail(
        name: "Seated Calf Raise",
        muscle: "Soleus",
        equipment: "Machine",
        difficulty: "Beginner",
        videoUrl: 'https://www.youtube.com/watch?v=JbyjNymZOt0',
        steps: [
          "Sit on the machine and place the balls of your feet on the platform.",
          "Lower your heels to stretch the muscle.",
          "Press up onto your toes to contract.",
          "Hold the top position for a second before lowering."
        ],
      ),
      ExerciseDetail(
        name: "Jump Rope",
        muscle: "Calves & Cardio",
        equipment: "Jump Rope",
        difficulty: "Intermediate",
        videoUrl: 'https://www.youtube.com/watch?v=IFgQfVQT_68',
        isTimerBased: true,
        steps: [
          "Hold the handles loosely with your elbows close to your ribs.",
          "Use your wrists to swing the rope, not your whole arms.",
          "Jump just high enough for the rope to clear your feet.",
          "Land softly on the balls of your feet with a slight knee bend."
        ],
      ),
    ],
  };
}

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  static Widget buildBackButton(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Icon(Icons.arrow_back, size: 22, color: isDark ? Colors.white : Colors.black87),
      ),
    );
  }

  static Widget buildWatermarkBackground(bool isDark) {
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            buildWatermarkBackground(isDark),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      buildBackButton(context, isDark),
                      Expanded(
                        child: Text(
                          "Planner",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/gymchad.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Exercise Categories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: const [
                      _CategoryButton(label: "Chest", icon: Icons.accessibility_new),
                      SizedBox(height: 16),
                      _CategoryButton(label: "Bicep", icon: Icons.fitness_center),
                      SizedBox(height: 16),
                      _CategoryButton(label: "Calves", icon: Icons.directions_run),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseListScreen extends StatelessWidget {
  final String category;
  const ExerciseListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final list = ExerciseData.exercises[category] ?? [];

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
                          "$category Exercises",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/gymchad.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _ExerciseItem(exercise: list[index]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEAEAEA);
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExerciseListScreen(category: label)),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, color: textColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: textColor.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseItem extends StatelessWidget {
  final ExerciseDetail exercise;

  const _ExerciseItem({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? const Color(0xFF2A2A2A) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseDetailScreen(exercise: exercise),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: Color(0xFF5FA75D),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    exercise.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: textColor.withOpacity(0.3), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}