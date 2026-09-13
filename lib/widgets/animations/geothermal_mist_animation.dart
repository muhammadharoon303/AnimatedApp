import 'dart:math';
import 'package:flutter/material.dart';

class GeothermalMistWidget extends StatefulWidget {
  final double scale;

  const GeothermalMistWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<GeothermalMistWidget> createState() => _GeothermalMistWidgetState();
}

class _GeothermalMistWidgetState extends State<GeothermalMistWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _mistDensity = 1.0;

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

  void _triggerSteamSurge() {
    setState(() => _mistDensity = 2.5);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _mistDensity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerSteamSurge,
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
                color: const Color(0xFF80CBC4).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00796B).withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Deep Volcanic Mineral Hot Springs Cavity
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF00251A),
                        Color(0xFF004D40),
                        Color(0xFF00150F),
                      ],
                    ),
                  ),
                ),

                // Basalt Hot Stones at Base
                Positioned(
                  bottom: 15,
                  left: 30,
                  right: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBasaltStone(38, 22),
                      _buildBasaltStone(50, 26, isHot: true),
                      _buildBasaltStone(42, 24),
                      _buildBasaltStone(32, 18),
                    ],
                  ),
                ),

                // Concentric Mineral Droplets and Volumetric Mist Clouds
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(280, 230),
                      painter: _ThermalMistPainter(
                        progress: _controller.value,
                        density: _mistDensity,
                      ),
                    );
                  },
                ),

                // Tap Hint
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF80CBC4).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      'TAP FOR EUCALYPTUS SURGE',
                      style: TextStyle(
                        color: Color(0xFFB2DFDB),
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

  Widget _buildBasaltStone(double width, double height, {bool isHot = false}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double heatGlow = isHot ? (sin(_controller.value * 2 * pi) * 0.2 + 0.5) : 0.0;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF1B2321),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHot
                  ? const Color(0xFFFF7043).withValues(alpha: heatGlow)
                  : const Color(0xFF26A69A).withValues(alpha: 0.4),
              width: 1.2,
            ),
            boxShadow: isHot
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF5722).withValues(alpha: heatGlow * 0.6),
                      blurRadius: 12,
                    ),
                  ]
                : [],
          ),
        );
      },
    );
  }
}

class _ThermalMistPainter extends CustomPainter {
  final double progress;
  final double density;

  _ThermalMistPainter({
    required this.progress,
    required this.density,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Concentric Mineral Drop Ripples
    final Paint dropPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final double dropT = (progress * 1.5) % 1.0;
    final double radius = dropT * 65.0;
    final double dropAlpha = (1.0 - dropT).clamp(0.0, 1.0);

    dropPaint.color = const Color(0xFF80CBC4).withValues(alpha: dropAlpha * 0.8);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.65), radius, dropPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.65), radius * 0.5, dropPaint);

    // 2. Rolling Volumetric Eucalyptus Mist Clouds
    final Paint mistPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);

    for (int i = 0; i < 6; i++) {
      final double seed = i * 0.16;
      final double mistT = (progress * 0.7 + seed) % 1.0;
      final double py = (size.height * 0.75) - (mistT * (size.height * 0.6));
      final double px = (size.width * 0.2) + (i * 38.0) + sin(mistT * 2 * pi + seed * 8) * 20.0;
      final double cloudRadius = (28.0 + sin(mistT * pi) * 18.0) * density.clamp(1.0, 1.6);
      final double opacity = sin(mistT * pi) * 0.32 * density.clamp(0.8, 1.8);

      mistPaint.color = const Color(0xFFE0F2F1).withValues(alpha: opacity.clamp(0.0, 0.6));
      canvas.drawCircle(Offset(px, py), cloudRadius, mistPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ThermalMistPainter oldDelegate) => true;
}
