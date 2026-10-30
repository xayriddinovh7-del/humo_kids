import 'package:flutter/material.dart';

class HumoBirdIcon extends StatelessWidget {
  const HumoBirdIcon({
    super.key,
    this.size = 28,
    this.color = const Color(0xFF0F3A8A),
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.3,
      height: size,
      child: CustomPaint(painter: _HumoBirdPainter(color: color)),
    );
  }
}

class _HumoBirdPainter extends CustomPainter {
  const _HumoBirdPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;

    // Wing swoosh 1 (main tall crescent)
    final path1 = Path();
    path1.moveTo(w * 0.45, h * 0.65);
    path1.cubicTo(w * 0.48, h * 0.35, w * 0.58, h * 0.05, w * 0.68, 0);
    path1.cubicTo(w * 0.62, h * 0.22, w * 0.64, h * 0.45, w * 0.72, h * 0.55);
    path1.cubicTo(w * 0.60, h * 0.58, w * 0.50, h * 0.62, w * 0.45, h * 0.65);
    path1.close();
    canvas.drawPath(path1, paint);

    // Wing swoosh 2 (middle wing)
    final path2 = Path();
    path2.moveTo(w * 0.35, h * 0.72);
    path2.cubicTo(w * 0.42, h * 0.45, w * 0.52, h * 0.25, w * 0.62, h * 0.18);
    path2.cubicTo(w * 0.56, h * 0.35, w * 0.54, h * 0.52, w * 0.60, h * 0.64);
    path2.cubicTo(w * 0.50, h * 0.68, w * 0.40, h * 0.70, w * 0.35, h * 0.72);
    path2.close();
    canvas.drawPath(path2, paint);

    // Body & lower swoop (with bird head / beak on right)
    final path3 = Path();
    path3.moveTo(0, h * 0.82);
    path3.cubicTo(w * 0.15, h * 0.65, w * 0.35, h * 0.62, w * 0.50, h * 0.74);
    path3.cubicTo(w * 0.65, h * 0.86, w * 0.85, h * 0.82, w * 1.0, h * 0.55);
    path3.cubicTo(w * 0.92, h * 0.70, w * 0.85, h * 0.74, w * 0.75, h * 0.70);
    path3.cubicTo(w * 0.62, h * 0.64, w * 0.45, h * 0.75, w * 0.25, h * 0.82);
    path3.cubicTo(w * 0.15, h * 0.86, w * 0.08, h * 0.90, 0, h * 0.82);
    path3.close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant _HumoBirdPainter oldDelegate) =>
      oldDelegate.color != color;
}

class HumoLogo extends StatelessWidget {
  const HumoLogo({
    super.key,
    this.iconSize = 22,
    this.fontSize = 17,
    this.showText = true,
  });

  final double iconSize;
  final double fontSize;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HumoBirdIcon(size: iconSize, color: const Color(0xFF0F3A8A)),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            'Humo Kids',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F3A8A),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ],
    );
  }
}
