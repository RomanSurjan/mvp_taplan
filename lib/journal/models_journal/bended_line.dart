import 'dart:math';
import 'package:flutter/material.dart';

class BendedLinePainter extends CustomPainter{
  final Color color;
  final double leftPadding;
  static const halfLineWidth = 2.0;
  static const roundingRadius = 5.0;

  const BendedLinePainter({
    required this.color,
    required this.leftPadding
  });

  @override
  void paint(Canvas canvas, Size size){

    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = halfLineWidth * 2;

    canvas.drawLine(
        Offset(size.width, halfLineWidth),
        Offset((roundingRadius + leftPadding + halfLineWidth), halfLineWidth),
        line
    );
    canvas.drawArc(
        Rect.fromLTWH((leftPadding + halfLineWidth), halfLineWidth, 10, 10),
        (pi * 1.5),
        (-pi * 0.5),
        false,
        line
    );
    canvas.drawLine(
        Offset((leftPadding + halfLineWidth), (roundingRadius + halfLineWidth)),
        Offset((leftPadding + halfLineWidth), size.height),
        line
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return false;
  }
}