import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import '../widgets/option_button.dart';
import '../widgets/gradient_button.dart';
import '../utils/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];

  int currentQuestionIndex = 0;
  int score = 0;

  bool isLoading = true;
  bool answerSelected = false;
  bool isCorrectAnswer = false;

  String? selectedAnswer;

  final List<String> letters = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final fetched = await ApiService.fetchQuestions();
      if (mounted) {
        setState(() {
          questions = fetched;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void checkAnswer(String answer) {
    if (answerSelected) return;

    final correct =
        answer == questions[currentQuestionIndex].correctAnswer;

    setState(() {
      selectedAnswer = answer;
      answerSelected = true;
      isCorrectAnswer = correct;

      if (correct) {
        score++;
      }
    });
  }

  OptionStatus getOptionStatus(String option) {
    if (!answerSelected) {
      return OptionStatus.normal;
    }

    if (option == questions[currentQuestionIndex].correctAnswer) {
      return OptionStatus.correct;
    }

    if (option == selectedAnswer) {
      return OptionStatus.incorrect;
    }

    return OptionStatus.disabled;
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        answerSelected = false;
        isCorrectAnswer = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ResultScreen(
            score: score,
            totalQuestions: questions.length,
          ),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.cardBorder.withOpacity(0.5)),
        ),
        title: const Text(
          "Quit Quiz?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: const Text(
          "Your current progress will be lost. Are you sure you want to return to the home screen?",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit quiz
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.incorrectBorder,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Quit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.mainGradient),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryIndigo,
                ),
                SizedBox(height: 20),
                Text(
                  "Curating questions...",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.mainGradient),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: AppColors.incorrectBorder,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Unable to Load Quiz",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Please check your connection and try again.",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  GradientButton(
                    text: "Return Home",
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header & Progress
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    // Close Button
                    GestureDetector(
                      onTap: _showExitConfirmation,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.cardBorder.withOpacity(0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Progress Bar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "QUESTION ${currentQuestionIndex + 1} OF ${questions.length}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                "${(progress * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryIndigo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            tween: Tween<double>(begin: 0, end: progress),
                            builder: (context, value, _) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 6,
                                  backgroundColor: AppColors.cardSurface,
                                  valueColor: const AlwaysStoppedAnimation(
                                    AppColors.primaryIndigo,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Score Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.cardBorder.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.workspace_premium_rounded,
                            color: Color(0xFFFACC15),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "$score",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),

                      // Animated Question Card
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.05),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          key: ValueKey<int>(currentQuestionIndex),
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.cardBorder.withOpacity(0.6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Text(
                            currentQuestion.question,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Options
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: ListView.builder(
                            key: ValueKey<int>(currentQuestionIndex),
                            physics: const BouncingScrollPhysics(),
                            itemCount: currentQuestion.options.length,
                            itemBuilder: (context, index) {
                              final option = currentQuestion.options[index];
                              final letter =
                                  index < letters.length ? letters[index] : '${index + 1}';

                              return OptionButton(
                                text: option,
                                letter: letter,
                                status: getOptionStatus(option),
                                enabled: !answerSelected,
                                onTap: () => checkAnswer(option),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Bar (Appears when answer selected)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: BoxDecoration(
                  color: answerSelected
                      ? AppColors.cardSurface.withOpacity(0.95)
                      : Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: answerSelected
                          ? AppColors.cardBorder.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: answerSelected
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isCorrectAnswer
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel_rounded,
                                color: isCorrectAnswer
                                    ? AppColors.correctBorder
                                    : AppColors.incorrectBorder,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isCorrectAnswer
                                    ? "Awesome! That's correct."
                                    : "Oops! Correct: ${currentQuestion.correctAnswer}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isCorrectAnswer
                                      ? AppColors.correctText
                                      : AppColors.incorrectText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          GradientButton(
                            text: currentQuestionIndex == questions.length - 1
                                ? "View Results"
                                : "Next Question",
                            icon: currentQuestionIndex == questions.length - 1
                                ? Icons.emoji_events_rounded
                                : Icons.arrow_forward_rounded,
                            onPressed: nextQuestion,
                          ),
                        ],
                      )
                    : const SizedBox(height: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}