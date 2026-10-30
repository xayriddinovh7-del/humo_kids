import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class PinDots extends StatelessWidget {
  const PinDots({
    super.key,
    required this.length,
    required this.filled,
    this.hasError = false,
  });

  final int length;
  final int filled;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isFilled = index < filled;
        Color color;
        if (hasError) {
          color = Colors.red;
        } else if (isFilled) {
          color = AppColors.primary;
        } else {
          color = const Color(0xFFDCE6F8);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      }),
    );
  }
}
