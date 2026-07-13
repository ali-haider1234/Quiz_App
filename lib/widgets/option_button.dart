import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

enum OptionStatus { normal, correct, incorrect, disabled }

class OptionButton extends StatefulWidget {
  final String text;
  final String letter;
  final VoidCallback onTap;
  final OptionStatus status;
  final bool enabled;

  const OptionButton({
    super.key,
    required this.text,
    required this.letter,
    required this.onTap,
    this.status = OptionStatus.normal,
    required this.enabled,
  });

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;

  Color get _backgroundColor {
    switch (widget.status) {
      case OptionStatus.correct:
        return AppColors.correctBg;
      case OptionStatus.incorrect:
        return AppColors.incorrectBg;
      case OptionStatus.disabled:
        return AppColors.optionDefaultBg.withOpacity(0.4);
      case OptionStatus.normal:
        return AppColors.optionDefaultBg;
    }
  }

  Color get _borderColor {
    switch (widget.status) {
      case OptionStatus.correct:
        return AppColors.correctBorder;
      case OptionStatus.incorrect:
        return AppColors.incorrectBorder;
      case OptionStatus.disabled:
        return AppColors.optionDefaultBorder.withOpacity(0.3);
      case OptionStatus.normal:
        return isPressed
            ? AppColors.primaryIndigo
            : AppColors.optionDefaultBorder;
    }
  }

  Color get _textColor {
    switch (widget.status) {
      case OptionStatus.correct:
        return AppColors.correctText;
      case OptionStatus.incorrect:
        return AppColors.incorrectText;
      case OptionStatus.disabled:
        return AppColors.textMuted;
      case OptionStatus.normal:
        return AppColors.textPrimary;
    }
  }

  Widget? get _statusIcon {
    switch (widget.status) {
      case OptionStatus.correct:
        return const Icon(
          Icons.check_circle_rounded,
          color: AppColors.correctBorder,
          size: 24,
        );
      case OptionStatus.incorrect:
        return const Icon(
          Icons.cancel_rounded,
          color: AppColors.incorrectBorder,
          size: 24,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled
          ? (_) => setState(() => isPressed = true)
          : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => isPressed = false);
              widget.onTap();
            }
          : null,
      onTapCancel: widget.enabled
          ? () => setState(() => isPressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _borderColor,
            width: widget.status != OptionStatus.normal &&
                    widget.status != OptionStatus.disabled
                ? 2.0
                : 1.2,
          ),
          boxShadow: widget.status == OptionStatus.correct
              ? [
                  BoxShadow(
                    color: AppColors.correctBorder.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : widget.status == OptionStatus.incorrect
                  ? [
                      BoxShadow(
                        color: AppColors.incorrectBorder.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
        ),
        child: Row(
          children: [
            // Letter Badge (A, B, C, D)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: widget.status == OptionStatus.correct
                    ? AppColors.correctBorder.withOpacity(0.2)
                    : widget.status == OptionStatus.incorrect
                        ? AppColors.incorrectBorder.withOpacity(0.2)
                        : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _borderColor.withOpacity(0.6),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.letter,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Option Text
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  color: _textColor,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),

            // Right Icon (or arrow/circle)
            if (_statusIcon != null) ...[
              const SizedBox(width: 10),
              _statusIcon!,
            ] else if (widget.status == OptionStatus.normal) ...[
              const SizedBox(width: 10),
              Icon(
                Icons.radio_button_unchecked_rounded,
                color: AppColors.textMuted.withOpacity(0.5),
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}