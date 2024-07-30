import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_my_theme.dart';

class MyBackground extends StatelessWidget {
  final Widget child;
  const MyBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    return SizedBox(
      width: width,
      height: 270,
      child: CustomPaint(
        painter: _CurvePainter(),
        child: child,
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 1,
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
