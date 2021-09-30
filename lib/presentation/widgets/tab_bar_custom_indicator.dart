import 'package:flutter/cupertino.dart';

class UnderLineTabIndicator extends Decoration {
  final BoxPainter _painter;

  UnderLineTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true
          ..strokeWidth = 3.0;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration imageConfig) {
    final Offset p1 = offset +
        Offset(imageConfig.size!.width * 0.30, imageConfig.size!.height);
    final Offset p2 = offset +
        Offset(imageConfig.size!.width * 0.70, imageConfig.size!.height);
    canvas.drawLine(p1, p2, _paint);
  }
}
