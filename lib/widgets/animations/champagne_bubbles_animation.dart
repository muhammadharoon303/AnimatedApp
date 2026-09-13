import 'dart:math';
import 'package:flutter/material.dart';

class ChampagneBubblesWidget extends StatefulWidget {
  final double scale;

  const ChampagneBubblesWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<ChampagneBubblesWidget> createState() => _ChampagneBubblesWidgetState();
}

class _ChampagneBubblesWidgetState extends State<ChampagneBubblesWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _fizzMultiplier = 1.0;

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

  void _triggerFizzBurst() {
    setState(() => _fizzMultiplier = 2.8);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _fizzMultiplier = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerFizzBurst,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: SizedBox(
            width: 200,
            height: 250,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Ambient Champagne Aura Glow
                Positioned(
                  bottom: 50,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4AF37).withValues(alpha: 0.35),
                          const Color(0xFFE6C280).withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Crystal Flute with Liquid & Rising Bubbles
                Positioned(
                  bottom: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Flute Bowl (Contains liquid and bubbles)
                      Container(
                        width: 76,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(38),
                            top: Radius.circular(6),
                          ),
                          border: Border.all(
                            color: const Color(0xFFFAF6F0).withValues(alpha: 0.45),
                            width: 1.5,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.08),
                              const Color(0xFFE6C280).withValues(alpha: 0.55),
                              const Color(0xFFC77944).withValues(alpha: 0.8),
                            ],
                            stops: const [0.0, 0.4, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            // Liquid Meniscus Top
                            Positioned(
                              top: 20,
                              left: 4,
                              right: 4,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E1).withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            // Rising Carbonation Bubbles
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                return CustomPaint(
                                  size: const Size(76, 140),
                                  painter: _ChampagneBubblePainter(
                                    progress: _controller.value,
                                    fizzRate: _fizzMultiplier,
                                  ),
                                );
                              },
                            ),

                            // Glass Specular Highlight Refraction
                            Positioned(
                              left: 6,
                              top: 6,
                              bottom: 12,
                              child: Container(
                                width: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Flute Stem
                      Container(
                        width: 5,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF6F0).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Flute Base Plate
                      Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF6F0).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE6C280),
                            width: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tap Hint
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE6C280).withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      _fizzMultiplier > 1.2 ? '★ FIZZ SURGE CHARGED ★' : 'TAP FOR FIZZ SURGE',
                      style: const TextStyle(
                        color: Color(0xFFE6C280),
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

class _ChampagneBubblePainter extends CustomPainter {
  final double progress;
  final double fizzRate;

  _ChampagneBubblePainter({
    required this.progress,
    required this.fizzRate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bubblePaint = Paint()..style = PaintingStyle.fill;
    final Paint rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = Colors.white.withValues(alpha: 0.8);

    const int bubbleCount = 28;

    for (int i = 0; i < bubbleCount; i++) {
      final double seed = (i * 0.173);
      final double speed = (0.7 + (i % 5) * 0.3) * fizzRate;
      final double particleT = (progress * speed + seed) % 1.0;

      // Ascending Y
      final double py = (size.height - 15) - (particleT * (size.height - 35));

      // Gentle horizontal wobble
      final double wobble = sin((particleT * 8 * pi) + (seed * 20)) * 5.0;
      final double px = (size.width * 0.5) + ((i % 2 == 0 ? 1 : -1) * (i * 1.8 % 22)) + wobble;

      final double radius = 1.2 + ((i % 4) * 0.7);
      final double opacity = sin(particleT * pi).clamp(0.2, 0.95);

      bubblePaint.color = const Color(0xFFFFFDE7).withValues(alpha: opacity);

      canvas.drawCircle(Offset(px, py), radius, bubblePaint);
      canvas.drawCircle(Offset(px, py), radius, rimPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChampagneBubblePainter oldDelegate) => true;
}
