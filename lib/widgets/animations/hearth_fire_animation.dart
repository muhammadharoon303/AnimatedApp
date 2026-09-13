import 'dart:math';
import 'package:flutter/material.dart';

class HearthFireWidget extends StatefulWidget {
  final double scale;

  const HearthFireWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<HearthFireWidget> createState() => _HearthFireWidgetState();
}

class _HearthFireWidgetState extends State<HearthFireWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _flareIntensity = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _stokeFire() {
    setState(() => _flareIntensity = 2.4);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _flareIntensity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _stokeFire,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: Container(
            width: 280,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFFF6D00).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3D00).withValues(alpha: 0.3),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Nero Marquina Marble Hearth Cavity
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0F0B09),
                        Color(0xFF1E130D),
                        Color(0xFF0A0706),
                      ],
                    ),
                  ),
                ),

                // Radial Hearth Firelight Glow
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final double pulse = sin(_controller.value * 8 * pi) * 0.12 * _flareIntensity;
                    return Positioned(
                      bottom: 20,
                      left: 40,
                      right: 40,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFFAB00).withValues(alpha: (0.45 + pulse).clamp(0.0, 1.0)),
                              const Color(0xFFFF3D00).withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Licking Flames & Swirling Embers Painter
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(280, 230),
                      painter: _FireFlamesPainter(
                        time: _controller.value,
                        flare: _flareIntensity,
                      ),
                    );
                  },
                ),

                // Birchwood Fire Logs
                Positioned(
                  bottom: 12,
                  left: 60,
                  right: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFireLog(-15),
                      _buildFireLog(12),
                    ],
                  ),
                ),

                // Tap Hint
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFAB00).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      'TAP TO STOKE FLAMES',
                      style: TextStyle(
                        color: Color(0xFFFFD54F),
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

  Widget _buildFireLog(double angle) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        width: 80,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF42210B),
              Color(0xFF261306),
              Color(0xFF140A03),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFF6D00).withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
    );
  }
}

class _FireFlamesPainter extends CustomPainter {
  final double time;
  final double flare;

  _FireFlamesPainter({
    required this.time,
    required this.flare,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double originX = size.width * 0.5;
    final double originY = size.height - 25;

    // 3 Layers of flame: Red/Orange Core, Golden Body, White-hot Inner Flame
    _drawFlameLayer(
      canvas,
      originX: originX,
      originY: originY,
      height: 110.0 * flare,
      width: 70.0 * flare,
      colors: [
        const Color(0xFFFF1744).withValues(alpha: 0.7),
        const Color(0xFFFF5722).withValues(alpha: 0.85),
        const Color(0xFFFF9100).withValues(alpha: 0.5),
      ],
      phase: 0.0,
      speed: 2.0,
    );

    _drawFlameLayer(
      canvas,
      originX: originX,
      originY: originY,
      height: 85.0 * flare,
      width: 48.0 * flare,
      colors: [
        const Color(0xFFFF9100),
        const Color(0xFFFFD600),
        const Color(0xFFFFEA00).withValues(alpha: 0.4),
      ],
      phase: 1.2,
      speed: 2.8,
    );

    _drawFlameLayer(
      canvas,
      originX: originX,
      originY: originY,
      height: 55.0 * flare,
      width: 28.0 * flare,
      colors: [
        Colors.white,
        const Color(0xFFFFF9C4),
        const Color(0xFFFFD54F),
      ],
      phase: 2.5,
      speed: 3.5,
    );

    // Swirling Ember Sparks
    final Paint sparkPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 18; i++) {
      final double seed = (i * 0.137);
      final double particleT = (time * (1.2 + (i % 3) * 0.4) + seed) % 1.0;
      final double py = originY - (particleT * 140.0 * flare);
      final double px = originX + sin((particleT * 6 * pi) + (seed * 15)) * (40.0 * particleT);
      final double radius = (1.0 + sin(particleT * pi) * 2.2);
      final double opacity = sin(particleT * pi).clamp(0.2, 0.95);

      sparkPaint.color = const Color(0xFFFFAB00).withValues(alpha: opacity);
      canvas.drawCircle(Offset(px, py), radius, sparkPaint);
    }
  }

  void _drawFlameLayer(
    Canvas canvas, {
    required double originX,
    required double originY,
    required double height,
    required double width,
    required List<Color> colors,
    required double phase,
    required double speed,
  }) {
    final Path path = Path();
    path.moveTo(originX - (width * 0.5), originY);

    // Left flame curve with chaotic flicker
    final double flickerLeft = sin((time * speed * 2 * pi) + phase) * 14.0;
    final double flickerTop = cos((time * speed * 3 * pi) + phase) * 12.0;

    path.quadraticBezierTo(
      originX - width + flickerLeft,
      originY - (height * 0.5),
      originX + (flickerLeft * 0.5),
      originY - height + flickerTop,
    );

    // Right flame curve
    final double flickerRight = cos((time * speed * 2 * pi) + phase * 1.5) * 14.0;
    path.quadraticBezierTo(
      originX + width + flickerRight,
      originY - (height * 0.5),
      originX + (width * 0.5),
      originY,
    );
    path.close();

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(originX - width, originY - height, width * 2, height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FireFlamesPainter oldDelegate) => true;
}
