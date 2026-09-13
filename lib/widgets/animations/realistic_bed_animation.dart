import 'dart:math';
import 'package:flutter/material.dart';

class RealisticBedWidget extends StatefulWidget {
  final double scale;

  const RealisticBedWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<RealisticBedWidget> createState() => _RealisticBedWidgetState();
}

class _RealisticBedWidgetState extends State<RealisticBedWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isFluffed = false;

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

  void _tapFluff() {
    setState(() => _isFluffed = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _isFluffed = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tapFluff,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: Container(
            width: 290,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC77944).withValues(alpha: 0.25),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // 1. Midnight Starlight Window in the background
                _buildStarlightWindow(),

                // 2. Bedside Lamp Warm Light Aura
                _buildLampGlow(),

                // 3. Royal Canopy King Bed
                Positioned(
                  bottom: 12,
                  left: 25,
                  right: 25,
                  child: _buildKingBed(),
                ),

                // 4. Bedside Gold Sconces / Lamps
                _buildBedsideLamps(),

                // 5. Floating Starlight / Pillow Dust Sparkles
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(290, 230),
                      painter: _StarlightSparklesPainter(
                        time: _controller.value,
                        isFluffed: _isFluffed,
                      ),
                    );
                  },
                ),

                // Tap Hint
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE6C280).withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      _isFluffed ? '★ PILLOWS FLUFFED ★' : 'TAP BED TO FLUFF',
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

  Widget _buildStarlightWindow() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF090B14),
            Color(0xFF141829),
            Color(0xFF1B1612),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Arched window frame
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: 140,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(70)),
                border: Border.all(color: const Color(0xFF3E3126), width: 2),
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFF1F2847),
                    Color(0xFF0E1220),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Crescent Moon
                  Positioned(
                    top: 18,
                    right: 32,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFF9C4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFF9C4).withValues(alpha: 0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLampGlow() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double pulse = sin(_controller.value * 2 * pi) * 0.08;
        return Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 45,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFB300).withValues(alpha: 0.32 + pulse),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 45,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFB300).withValues(alpha: 0.32 + pulse),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKingBed() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double breathing = sin(_controller.value * 2 * pi) * 1.5;
        final double fluff = _isFluffed ? -6.0 : 0.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tufted Leather/Velvet Headboard
            Container(
              width: 195,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF382A1E),
                    Color(0xFF5A4432),
                    Color(0xFF261C14),
                  ],
                ),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black, blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => Container(
                    width: 2,
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),

            // Pillows Row (with breathing motion)
            Transform.translate(
              offset: Offset(0, breathing + fluff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPillow(-5),
                  const SizedBox(width: 8),
                  _buildPillow(5),
                ],
              ),
            ),

            const SizedBox(height: 2),

            // Silk Duvet & Mattress
            Container(
              width: 210,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF7F3EB),
                    Color(0xFFE4D9C8),
                    Color(0xFFC7B79F),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Gold Silk Bed Runner
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC77944),
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Color(0xFFE6C280),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPillow(double tiltAngle) {
    return Transform.rotate(
      angle: tiltAngle * pi / 180,
      child: Container(
        width: 58,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDCC8B3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBedsideLamps() {
    return Positioned(
      bottom: 50,
      left: 14,
      right: 14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLamp(),
          _buildLamp(),
        ],
      ),
    );
  }

  Widget _buildLamp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Lamp Shade
        Container(
          width: 22,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFFFECB3),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB300).withValues(alpha: 0.8),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        // Stand
        Container(
          width: 3,
          height: 14,
          color: const Color(0xFFE6C280),
        ),
        // Base
        Container(
          width: 14,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _StarlightSparklesPainter extends CustomPainter {
  final double time;
  final bool isFluffed;

  _StarlightSparklesPainter({
    required this.time,
    required this.isFluffed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint starPaint = Paint()..style = PaintingStyle.fill;
    final Random random = Random(88);

    const int starCount = 16;
    for (int i = 0; i < starCount; i++) {
      final double x = size.width * (0.28 + random.nextDouble() * 0.44);
      final double y = 20.0 + random.nextDouble() * 70.0;
      final double twinkle = sin((time * 4 * pi) + (i * 1.5)).abs();

      starPaint.color = Colors.white.withValues(alpha: twinkle * 0.85);
      canvas.drawCircle(Offset(x, y), 1.2 + (twinkle * 0.8), starPaint);
    }

    if (isFluffed) {
      final Paint dustPaint = Paint()..style = PaintingStyle.fill;
      for (int i = 0; i < 14; i++) {
        final double t = (time * 2 + (i * 0.08)) % 1.0;
        final double py = 160.0 - (t * 50.0);
        final double px = 80.0 + (i * 10.0) + sin(t * 4 * pi) * 12.0;

        dustPaint.color = const Color(0xFFFFD54F).withValues(alpha: (1.0 - t));
        canvas.drawCircle(Offset(px, py), 1.5, dustPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StarlightSparklesPainter oldDelegate) => true;
}
