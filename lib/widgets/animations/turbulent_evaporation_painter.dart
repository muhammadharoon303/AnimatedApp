import 'dart:math';
import 'package:flutter/material.dart';

class TurbulentEvaporationWidget extends StatefulWidget {
  final double scale;
  final bool interactive;

  const TurbulentEvaporationWidget({
    super.key,
    this.scale = 1.0,
    this.interactive = true,
  });

  @override
  State<TurbulentEvaporationWidget> createState() =>
      _TurbulentEvaporationWidgetState();
}

class _TurbulentEvaporationWidgetState extends State<TurbulentEvaporationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _steamTurbulence = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerVaporBurst() {
    if (!widget.interactive) return;
    setState(() => _steamTurbulence = 2.4);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _steamTurbulence = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerVaporBurst,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: SizedBox(
            width: 250,
            height: 260,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Soft Ambient Radial Thermal Hearth Glow
                Positioned(
                  bottom: 30,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final double glowPulse = sin(_controller.value * 2 * pi) * 0.08;
                      return Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFC77944).withValues(alpha: 0.38 + glowPulse),
                              const Color(0xFFD4AF37).withValues(alpha: 0.12),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.45, 1.0],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Multi-stream Turbulent Evaporation Painter (Rises above cup rim)
                Positioned(
                  bottom: 74,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(180, 190),
                        painter: _AccurateEvaporationSmokePainter(
                          progress: _controller.value,
                          turbulence: _steamTurbulence,
                        ),
                      );
                    },
                  ),
                ),

                // Artisan Cup Body & Saucer
                _buildArtisanCup(),

                // Interactive Tap Prompt
                if (widget.interactive && _steamTurbulence > 1.2)
                  Positioned(
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE6C280).withValues(alpha: 0.6),
                        ),
                      ),
                      child: const Text(
                        '~ Thermal Evaporation Surge ~',
                        style: TextStyle(
                          color: Color(0xFFE6C280),
                          fontSize: 10,
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

  Widget _buildArtisanCup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Hammered Brass Handle with Specular Highlight
            Positioned(
              right: 18,
              top: 12,
              child: Container(
                width: 36,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  border: Border.all(
                    color: const Color(0xFFE6C280),
                    width: 5.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Porcelain Cup Body with Gold Filigree
            Container(
              width: 114,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(44),
                  bottomRight: Radius.circular(44),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFAF6F0),
                    Color(0xFFE5D7C5),
                    Color(0xFFB8A287),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.7),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: const Color(0xFFC77944).withValues(alpha: 0.3),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Gold Filigree Rim
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6C280),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),

                  // Liquid Surface (Grand Cru Infusion with Crema Ripple)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 102,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF381B0B),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            final double ripple = sin(_controller.value * 4 * pi) * 2;
                            return Container(
                              width: 48 + ripple,
                              height: 7,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B3A1C).withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE6C280).withValues(alpha: 0.3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        // Gold-Trimmed Saucer Plate
        Container(
          width: 160,
          height: 13,
          decoration: BoxDecoration(
            color: const Color(0xFFD9C8B5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE6C280),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.75),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccurateEvaporationSmokePainter extends CustomPainter {
  final double progress;
  final double turbulence;

  _AccurateEvaporationSmokePainter({
    required this.progress,
    required this.turbulence,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Thermal Core Plume (Directly over the center, rises fastest)
    _drawBuoyantPlume(
      canvas,
      size,
      baseXFraction: 0.50,
      waveFreq: 3.2,
      speedScale: 1.25,
      spread: 24.0 * turbulence,
      strokeWidth: 16.0,
      phaseShift: 0.0,
      alphaPeak: 0.36,
    );

    // 2. Left Vortex Eddy Plume (Rolls outward to the left as it cools)
    _drawBuoyantPlume(
      canvas,
      size,
      baseXFraction: 0.38,
      waveFreq: 2.6,
      speedScale: 0.95,
      spread: 32.0 * turbulence,
      strokeWidth: 14.0,
      phaseShift: 0.35,
      alphaPeak: 0.28,
    );

    // 3. Right Vortex Eddy Plume (Rolls outward to the right)
    _drawBuoyantPlume(
      canvas,
      size,
      baseXFraction: 0.62,
      waveFreq: 2.9,
      speedScale: 1.10,
      spread: 30.0 * turbulence,
      strokeWidth: 13.0,
      phaseShift: 0.70,
      alphaPeak: 0.30,
    );

    // 4. Outer Hazy Fog Billow (Wide dispersion at the top)
    _drawBuoyantPlume(
      canvas,
      size,
      baseXFraction: 0.48,
      waveFreq: 1.8,
      speedScale: 0.80,
      spread: 44.0 * turbulence,
      strokeWidth: 22.0,
      phaseShift: 1.15,
      alphaPeak: 0.18,
    );

    // 5. Rising Micro-Condensation Droplets
    _drawCondensationDroplets(canvas, size);
  }

  void _drawBuoyantPlume(
    Canvas canvas,
    Size size, {
    required double baseXFraction,
    required double waveFreq,
    required double speedScale,
    required double spread,
    required double strokeWidth,
    required double phaseShift,
    required double alphaPeak,
  }) {
    final Path path = Path();
    final double originX = size.width * baseXFraction;
    final double originY = size.height;

    path.moveTo(originX, originY);

    const int steps = 36;
    for (int i = 1; i <= steps; i++) {
      final double t = i / steps; // 0.0 (bottom/hot) to 1.0 (top/cooled)
      final double y = originY - (t * size.height);

      // Vortex shedding: Two overlapping waves (primary curl + harmonic turbulence)
      final double primaryWave = sin((progress * speedScale * 2 * pi) + (t * waveFreq * pi) + (phaseShift * 2 * pi));
      final double secondaryEddy = cos((progress * speedScale * 4 * pi) + (t * 6.0));

      // Buoyancy spread accelerates with height (pow 1.3)
      final double drift = (primaryWave * 0.75 + secondaryEddy * 0.25) * (spread * pow(t, 1.25));
      final double x = originX + drift;

      path.lineTo(x, y);
    }

    final Rect bounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 13)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          const Color(0xFFFFF7ED).withValues(alpha: (alphaPeak * turbulence).clamp(0.0, 0.65)),
          const Color(0xFFF5EBE1).withValues(alpha: (alphaPeak * 0.6 * turbulence).clamp(0.0, 0.45)),
          Colors.white.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.20, 0.65, 1.0],
      ).createShader(bounds);

    canvas.drawPath(path, paint);
  }

  void _drawCondensationDroplets(Canvas canvas, Size size) {
    final Paint dropletPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

    for (int i = 0; i < 10; i++) {
      final double seed = (i * 0.103);
      final double particleT = (progress * 1.15 + seed) % 1.0;
      final double py = size.height - (particleT * size.height * 0.92);
      final double px = (size.width * 0.5) +
          (sin(particleT * 6 * pi + seed * 14) * (42.0 * particleT));
      final double radius = (1.2 + (sin(particleT * pi) * 2.8));
      final double opacity = sin(particleT * pi) * 0.32;

      dropletPaint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(px, py), radius, dropletPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AccurateEvaporationSmokePainter oldDelegate) => true;
}
