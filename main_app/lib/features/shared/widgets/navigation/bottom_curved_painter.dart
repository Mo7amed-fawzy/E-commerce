import 'package:e_commerce_app/features/shared/widgets/navigation/centered_elasticin_curve.dart';
import 'package:flutter/material.dart';

class BackgroundCurvePainter extends CustomPainter {
  static const _radiusTop = 50.0;
  static const _radiusBottom = 30.0;
  static const _horizontalControlTop = 0.6;
  static const _horizontalControlBottom = 0.5;
  static const _pointControlTop = 0.35;
  static const _pointControlBottom = 0.85;
  static const _topY = -60.0;
  static const _bottomY = 0.0;
  static const _topDistance = 0.0;
  static const _bottomDistance = 10.0;

  final double _x;
  final double _normalizedY;
  final Color _color;

  BackgroundCurvePainter(double x, double normalizedY, Color color)
    : _x = x,
      _normalizedY = normalizedY,
      _color = color;

  @override
  void paint(canvas, size) {
    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 5;
    final radius = Tween<double>(
      begin: _radiusTop,
      end: _radiusBottom,
    ).transform(norm);
    final anchorControlOffset = Tween<double>(
      begin: radius * _horizontalControlTop,
      end: radius * _horizontalControlBottom,
    ).transform(const LinearPointCurve(0.5, 0.75).transform(norm));
    final dipControlOffset = Tween<double>(
      begin: radius * _pointControlTop,
      end: radius * _pointControlBottom,
    ).transform(const LinearPointCurve(0.5, 0.8).transform(norm));
    final y = Tween<double>(
      begin: _topY,
      end: _bottomY,
    ).transform(const LinearPointCurve(0.2, 0.7).transform(norm));
    final dist = Tween<double>(
      begin: _topDistance,
      end: _bottomDistance,
    ).transform(const LinearPointCurve(0.5, 0.0).transform(norm));
    final x0 = _x - dist / 2;
    final x1 = _x + dist / 2;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(x0 - radius, 0)
          ..cubicTo(
            x0 - radius + anchorControlOffset,
            0,
            x0 - dipControlOffset,
            y,
            x0,
            y,
          )
          ..lineTo(x1, y)
          ..cubicTo(
            x1 + dipControlOffset,
            y,
            x1 + radius - anchorControlOffset,
            0,
            x1 + radius,
            0,
          )
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height);

    final paint = Paint()..color = _color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundCurvePainter oldDelegate) {
    return _x != oldDelegate._x ||
        _normalizedY != oldDelegate._normalizedY ||
        _color != oldDelegate._color;
  }
}
