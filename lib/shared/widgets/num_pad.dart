import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class NumPad extends StatelessWidget {
  const NumPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.keyHeight = 50,
    this.bottomLeading,
  });

  final void Function(String digit) onDigit;
  final VoidCallback onBackspace;
  final double keyHeight;
  final Widget? bottomLeading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 8),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 8),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 8),
        _buildLastRow(),
      ],
    );
  }

  Widget _buildRow(List<String> digits) {
    return Row(
      children: [
        for (int i = 0; i < digits.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(
            child: _NumKey(
              label: digits[i],
              height: keyHeight,
              onTap: () => onDigit(digits[i]),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLastRow() {
    return Row(
      children: [
        Expanded(
          child: bottomLeading ?? const SizedBox(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _NumKey(
            label: '0',
            height: keyHeight,
            onTap: () => onDigit('0'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _BackspaceKey(
            height: keyHeight,
            onTap: onBackspace,
          ),
        ),
      ],
    );
  }
}

class _NumKey extends StatelessWidget {
  const _NumKey({
    required this.label,
    required this.height,
    required this.onTap,
  });

  final String label;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F6FA),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        splashColor: AppColors.primary.withValues(alpha: 0.12),
        highlightColor: AppColors.primary.withValues(alpha: 0.06),
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }
}

class _BackspaceKey extends StatelessWidget {
  const _BackspaceKey({
    required this.height,
    required this.onTap,
  });

  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F6FA),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        splashColor: AppColors.primary.withValues(alpha: 0.12),
        highlightColor: AppColors.primary.withValues(alpha: 0.06),
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: const Icon(
            Icons.backspace_outlined,
            color: AppColors.darkText,
            size: 22,
          ),
        ),
      ),
    );
  }
}
