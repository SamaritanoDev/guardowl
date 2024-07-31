import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget child;
  final double height;
  const MyBackground({
    super.key,
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(context, height),
      child: child,
    );
  }
}

class _CurvePainter extends CustomPainter {
  final BuildContext context;
  final double height;

  _CurvePainter(
    this.context,
    this.height,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final color = Theme.of(context).colorScheme;

    final paint = Paint()
      ..strokeWidth = 10
      ..color = color.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * height,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
