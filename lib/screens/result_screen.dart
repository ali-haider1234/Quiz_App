import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';
import '../utils/app_colors.dart';
import '../widgets/gradient_button.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  String get performanceTitle {
    final percentage = score / totalQuestions;
    if (percentage >= 0.8) return "Mastery Achieved!";
    if (percentage >= 0.5) return "Great Effort!";
    return "Keep Practicing!";
  }

  Color get performanceColor {
    final percentage = score / totalQuestions;
    if (percentage >= 0.8) return AppColors.correctBorder;
    if (percentage >= 0.5) return AppColors.primaryIndigo;
    return AppColors.incorrectBorder;
  }

  IconData get performanceIcon {
    final percentage = score / totalQuestions;
    if (percentage >= 0.8) return Icons.workspace_premium_rounded;
    if (percentage >= 0.5) return Icons.thumb_up_alt_rounded;
    return Icons.school_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final int incorrect = totalQuestions - score;
    final int accuracy = ((score / totalQuestions) * 100).toInt();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Header
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "CHALLENGE SUMMARY",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                // Center Trophy & Stats Section
                Column(
                  children: [
                    // Trophy Glowing Circle
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            performanceColor,
                            performanceColor.withOpacity(0.6),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: performanceColor.withOpacity(0.4),
                            blurRadius: 36,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          performanceIcon,
                          size: 68,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Performance Title
                    Text(
                      performanceTitle,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "You answered $score out of $totalQuestions questions correctly",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Score Big Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.cardBorder.withOpacity(0.6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "SCORE",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "$score / $totalQuestions",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 44,
                            width: 1,
                            color: AppColors.cardBorder,
                            margin: const EdgeInsets.symmetric(horizontal: 28),
                          ),
                          Column(
                            children: [
                              const Text(
                                "ACCURACY",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "$accuracy%",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: performanceColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Correct vs Incorrect Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatTile(
                            "Correct",
                            "$score",
                            Icons.check_circle_rounded,
                            AppColors.correctBorder,
                            AppColors.correctBg.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatTile(
                            "Incorrect",
                            "$incorrect",
                            Icons.cancel_rounded,
                            AppColors.incorrectBorder,
                            AppColors.incorrectBg.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Bottom Actions
                Column(
                  children: [
                    GradientButton(
                      text: "Play Again",
                      icon: Icons.refresh_rounded,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, anim, _) =>
                                const QuizScreen(),
                            transitionsBuilder: (context, anim, _, child) =>
                                FadeTransition(opacity: anim, child: child),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, anim, _) =>
                                  const HomeScreen(),
                              transitionsBuilder: (context, anim, _, child) =>
                                  FadeTransition(opacity: anim, child: child),
                            ),
                            (route) => false,
                          );
                        },
                        icon: const Icon(
                          Icons.home_rounded,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        label: const Text(
                          "Return to Home",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(
    String label,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}