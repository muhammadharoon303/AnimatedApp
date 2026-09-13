import 'dart:math';
import 'package:flutter/material.dart';

class MoltenCakeWidget extends StatefulWidget {
  final double scale;

  const MoltenCakeWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<MoltenCakeWidget> createState() => _MoltenCakeWidgetState();
}

class _MoltenCakeWidgetState extends State<MoltenCakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isOozing = false;

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

  void _tapMelt() {
    setState(() => _isOozing = true);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _isOozing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tapMelt,
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
                // Warm dessert backlight
                Positioned(
                  bottom: 30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4AF37).withValues(alpha: 0.28),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Sweet Cocoa Vapor Trails
                Positioned(
                  bottom: 60,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(160, 160),
                        painter: _DessertSteamPainter(
                          progress: _controller.value,
                          isOozing: _isOozing,
                        ),
                      );
                    },
                  ),
                ),

                // Lava Cake & China Plate
                _buildCakeAndPlate(),

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
                      _isOozing ? '★ MOLTEN CHOCOLATE FLOWING ★' : 'TAP TO OOZE WARM CHOCOLATE',
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

  Widget _buildCakeAndPlate() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cake Body
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2C150B),
                    Color(0xFF4A2514),
                    Color(0xFF1E0E07),
                  ],
                ),
                border: Border.all(color: const Color(0xFF5D2E17)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.7),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Molten Lava Center
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: _isOozing ? 48 : 34,
                    height: _isOozing ? 26 : 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFF6B2A0F),
                          Color(0xFF2E1106),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),

                  // 24K Edible Gold Leaf Flakes
                  Positioned(
                    top: 12,
                    left: 28,
                    child: Container(
                      width: 10,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6C280),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFD4AF37), blurRadius: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Fine Bone China Dessert Plate with Gold Trim
        Container(
          width: 175,
          height: 12,
          decoration: BoxDecoration(
            color: const Color(0xFFF0EBE1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE6C280), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.75),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DessertSteamPainter extends CustomPainter {
  final double progress;
  final bool isOozing;

  _DessertSteamPainter({
    required this.progress,
    required this.isOozing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint steamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = isOozing ? 12.0 : 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    for (int i = 0; i < 2; i++) {
      final Path path = Path();
      final double originX = size.width * (0.42 + (i * 0.16));
      final double originY = size.height;

      path.moveTo(originX, originY);
      for (int step = 1; step <= 20; step++) {
        final double t = step / 20.0;
        final double y = originY - (t * size.height * 0.8);
        final double drift = sin((progress * 2 * pi) + (t * 4) + (i * 3)) * (18.0 * t);
        path.lineTo(originX + drift, y);
      }

      steamPaint.shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.transparent,
          const Color(0xFFFFF3E0).withValues(alpha: isOozing ? 0.38 : 0.22),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(path, steamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DessertSteamPainter oldDelegate) => true;
}
