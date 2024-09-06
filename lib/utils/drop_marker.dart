import 'package:flutter/material.dart';

class DropMarker extends StatelessWidget {
  final Widget icon;
  final Color colorMarker;

  const DropMarker({
    super.key,
    required this.icon,
    required this.colorMarker,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(20, 30),
            painter: _DropPainter(colorMarker: colorMarker),
          ),
          Align(
            alignment: Alignment.center,
            child: icon,
          ),
        ],
      ),
    );
  }
}

class _DropPainter extends CustomPainter {
  final Color colorMarker;

  _DropPainter({required this.colorMarker});

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 40;
    final double scaleY = size.height / 50;

    Path path = Path();
    path.moveTo(20 * scaleX, 5 * scaleY);
    path.cubicTo(
      16 * scaleX,
      5 * scaleY,
      10 * scaleX,
      8 * scaleY,
      10 * scaleX,
      19 * scaleY,
    );
    path.cubicTo(
      10 * scaleX,
      28 * scaleY,
      20 * scaleX,
      45 * scaleY,
      20 * scaleX,
      45 * scaleY,
    );
    path.cubicTo(
      20 * scaleX,
      45 * scaleY,
      30 * scaleX,
      28 * scaleY,
      30 * scaleX,
      19 * scaleY,
    );
    path.cubicTo(
      30 * scaleX,
      8 * scaleY,
      24 * scaleX,
      5 * scaleY,
      20 * scaleX,
      5 * scaleY,
    );
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = colorMarker.withOpacity(1.0);
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
