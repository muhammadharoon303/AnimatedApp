import 'dart:math';
import 'package:flutter/material.dart';

class UndulatingPoolWidget extends StatefulWidget {
  final double scale;

  const UndulatingPoolWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<UndulatingPoolWidget> createState() => _UndulatingPoolWidgetState();
}

class _UndulatingPoolWidgetState extends State<UndulatingPoolWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Offset> _touchRipples = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _touchRipples.add(details.localPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: Container(
            width: 280,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00B0FF).withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Deep Mediterranean Water Gradient Base
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF003B5C),
                        Color(0xFF00609C),
                        Color(0xFF00223D),
                      ],
                    ),
                  ),
                ),

                // Undulating Wave & Caustics Painter
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(280, 220),
                      painter: _PoolCausticsPainter(
                        time: _controller.value,
                        touchPoints: _touchRipples,
                      ),
                    );
                  },
                ),

                // Floating Hibiscus / Frangipani Petals
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final double bob = sin(_controller.value * 2 * pi) * 4;
                    return Positioned(
                      top: 70 + bob,
                      left: 60,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFF4081),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFEE58),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Interactive Hint Label
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      'TAP POOL FOR RIPPLES',
                      style: TextStyle(
                        color: Color(0xFF80D8FF),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PoolCausticsPainter extends CustomPainter {
  final double time;
  final List<Offset> touchPoints;

  _PoolCausticsPainter({
    required this.time,
    required this.touchPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint causticPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Overlapping undulating trigonometric wave mesh
    const int lines = 7;
    for (int l = 0; l < lines; l++) {
      final Path path = Path();
      final double baseY = (size.height / (lines + 1)) * (l + 1);

      path.moveTo(0, baseY);
      for (double x = 0; x <= size.width; x += 8) {
        final double wave1 = sin((x * 0.035) + (time * 2 * pi) + (l * 0.8)) * 8.0;
        final double wave2 = cos((x * 0.05) - (time * 3 * pi) + (l * 1.2)) * 4.0;
        path.lineTo(x, baseY + wave1 + wave2);
      }

      causticPaint.color = const Color(0xFF80D8FF)
          .withValues(alpha: 0.28 + sin(time * 2 * pi + l) * 0.1);
      canvas.drawPath(path, causticPaint);
    }

    // Touch Ripples
    final Paint ripplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = const Color(0xFFE0F7FA).withValues(alpha: 0.7);

    for (final point in touchPoints) {
      final double r = ((time * 120) % 90);
      ripplePaint.color = const Color(0xFFE0F7FA)
          .withValues(alpha: (1.0 - (r / 90.0)).clamp(0.0, 1.0));
      canvas.drawCircle(point, r, ripplePaint);
      canvas.drawCircle(point, r * 0.6, ripplePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PoolCausticsPainter oldDelegate) => true;
}
