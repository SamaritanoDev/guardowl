import 'package:flutter/material.dart';

class DropMarker extends StatelessWidget {
  const DropMarker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(119, 85),
          painter: _DropPainter(),
        ),
        Icon(Icons.coffee, color: color.onPrimary),
      ],
    );
  }
}

class _DropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(59.2157, 20);
    path_0.cubicTo(48.6201, 20, 40, 28.7481, 40, 39.501);
    path_0.cubicTo(40, 52.8456, 57.1962, 68.5901, 57.9283, 69.4175);
    path_0.cubicTo(58.616, 70.1948, 59.8166, 70.1935, 60.5031, 69.4175);
    path_0.cubicTo(61.2352, 68.5901, 78.4314, 52.8456, 78.4314, 39.501);
    path_0.cubicTo(78.4312, 28.7481, 69.8112, 20, 59.2157, 20);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff555FD2).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
