import 'dart:math';
import 'package:flutter/material.dart';

class RealisticSteamPainter extends CustomPainter {
  final double progress;
  final Color? tintColor;

  RealisticSteamPainter({
    required this.progress,
    this.tintColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawVaporStream(canvas, size,
        baseOffset: 0.35, phaseOffset: 0.0, speedScale: 1.0, spread: 22.0);
    _drawVaporStream(canvas, size,
        baseOffset: 0.50, phaseOffset: 0.35, speedScale: 0.85, spread: 30.0);
    _drawVaporStream(canvas, size,
        baseOffset: 0.65, phaseOffset: 0.70, speedScale: 1.15, spread: 25.0);
  }

  void _drawVaporStream(
    Canvas canvas,
    Size size, {
    required double baseOffset,
    required double phaseOffset,
    required double speedScale,
    required double spread,
  }) {
    final path = Path();
    final double originX = size.width * baseOffset;
    final double originY = size.height;

    path.moveTo(originX, originY);

    const int segments = 24;
    for (int i = 1; i <= segments; i++) {
      final double t = i / segments;
      final double y = originY - (t * size.height);

      final double drift = sin((progress * speedScale * 2 * pi) +
              (t * 4) +
              (phaseOffset * 2 * pi)) *
          (spread * t);
      final double x = originX + drift;

      path.lineTo(x, y);
    }

    final Rect bounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final Color base = tintColor ?? Colors.white;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 11)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          base.withValues(alpha: 0.0),
          base.withValues(alpha: 0.32),
          base.withValues(alpha: 0.18),
          base.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.25, 0.70, 1.0],
      ).createShader(bounds);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant RealisticSteamPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class SteamingTeaCupWidget extends StatefulWidget {
  final double scale;

  const SteamingTeaCupWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<SteamingTeaCupWidget> createState() => _SteamingTeaCupWidgetState();
}

class _SteamingTeaCupWidgetState extends State<SteamingTeaCupWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: SizedBox(
        width: 220,
        height: 240,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Glowing radial backlight
            Positioned(
              bottom: 30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFC77944).withValues(alpha: 0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Rising steam painter
            Positioned(
              bottom: 65,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(120, 150),
                    painter: RealisticSteamPainter(
                      progress: _controller.value,
                      tintColor: const Color(0xFFF9E7D0),
                    ),
                  );
                },
              ),
            ),

            // Tea Cup Body & Saucer
            const CupGraphic(),
          ],
        ),
      ),
    );
  }
}

class CupGraphic extends StatelessWidget {
  const CupGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Handle
            Positioned(
              right: 18,
              top: 14,
              child: Container(
                width: 32,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(color: const Color(0xFFDCC8B3), width: 6),
                ),
              ),
            ),
            // Body
            Container(
              width: 105,
              height: 72,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(38),
                  bottomRight: Radius.circular(38),
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFAF6F0),
                    Color(0xFFE0D5C3),
                    Color(0xFFB5A48F),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33C77944),
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: 95,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A2810),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Saucer
        Container(
          width: 140,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFFD1C4B2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
