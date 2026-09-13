import 'dart:math';
import 'package:flutter/material.dart';

class SteamingBowlWidget extends StatefulWidget {
  final double scale;

  const SteamingBowlWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<SteamingBowlWidget> createState() => _SteamingBowlWidgetState();
}

class _SteamingBowlWidgetState extends State<SteamingBowlWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _steamSurge = 1.0;

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

  void _stirBroth() {
    setState(() => _steamSurge = 2.2);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _steamSurge = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _stirBroth,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Warm broth backlight
                Positioned(
                  bottom: 30,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF8F00).withValues(alpha: 0.32),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Rising Broth Steam Plumes
                Positioned(
                  bottom: 75,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(180, 180),
                        painter: _BowlSteamPainter(
                          progress: _controller.value,
                          surge: _steamSurge,
                        ),
                      );
                    },
                  ),
                ),

                // Lacquer Ceramic Ramen / Soup Bowl
                _buildLacquerBowl(),

                // Tap Hint
                Positioned(
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE6C280).withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      _steamSurge > 1.2 ? '★ BROTH STIRRED • AROMATIC ★' : 'TAP BOWL TO STIR BROTH',
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

  Widget _buildLacquerBowl() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Chopsticks Resting Across Rim
        Transform.rotate(
          angle: -12 * pi / 180,
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            width: 175,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF8D6E63),
                  Color(0xFF4E342E),
                  Color(0xFFE6C280),
                ],
                stops: [0.0, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),

        // Ceramic Bowl Body
        Container(
          width: 155,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF261D18),
                Color(0xFF140F0C),
                Color(0xFF0A0706),
              ],
            ),
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Gold Rim Band
              Container(
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6C280),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),

              // Rich Hot Amber Broth Surface
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 140,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8D4004),
                        Color(0xFFB25000),
                        Color(0xFF5E2700),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Floating Scallions / Herbs
                      _buildHerbGarnish(const Color(0xFF66BB6A)),
                      _buildHerbGarnish(const Color(0xFFE6C280)),
                      _buildHerbGarnish(const Color(0xFF81C784)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 3),

        // Bowl Base Ring
        Container(
          width: 65,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFF3E2723),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFD4AF37), width: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildHerbGarnish(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 3),
        ],
      ),
    );
  }
}

class _BowlSteamPainter extends CustomPainter {
  final double progress;
  final double surge;

  _BowlSteamPainter({
    required this.progress,
    required this.surge,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint steamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    for (int s = 0; s < 3; s++) {
      final Path path = Path();
      final double originX = size.width * (0.36 + (s * 0.14));
      final double originY = size.height;

      path.moveTo(originX, originY);

      for (int i = 1; i <= 24; i++) {
        final double t = i / 24.0;
        final double y = originY - (t * size.height);
        final double drift = sin((progress * 2.5 * pi) + (t * 5.0) + (s * 2.0)) * (24.0 * t * surge);
        path.lineTo(originX + drift, y);
      }

      steamPaint.strokeWidth = (10.0 + (s * 3)) * surge.clamp(1.0, 1.4);
      steamPaint.shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          const Color(0xFFFFF3E0).withValues(alpha: 0.35 * surge.clamp(0.8, 1.5)),
          const Color(0xFFF5EBE1).withValues(alpha: 0.20 * surge.clamp(0.8, 1.5)),
          Colors.white.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.22, 0.65, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(path, steamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BowlSteamPainter oldDelegate) => true;
}
