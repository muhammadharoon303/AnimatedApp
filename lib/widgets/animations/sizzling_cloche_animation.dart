import 'dart:math';
import 'package:flutter/material.dart';

class SizzlingClocheWidget extends StatefulWidget {
  final double scale;

  const SizzlingClocheWidget({
    super.key,
    this.scale = 1.0,
  });

  @override
  State<SizzlingClocheWidget> createState() => _SizzlingClocheWidgetState();
}

class _SizzlingClocheWidgetState extends State<SizzlingClocheWidget>
    with TickerProviderStateMixin {
  late final AnimationController _steamController;
  late final AnimationController _clocheController;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _steamController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _clocheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _steamController.dispose();
    _clocheController.dispose();
    super.dispose();
  }

  void _toggleCloche() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _clocheController.forward();
      } else {
        _clocheController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCloche,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Transform.scale(
          scale: widget.scale,
          child: SizedBox(
            width: 260,
            height: 250,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Warm embers background glow
                Positioned(
                  bottom: 25,
                  child: AnimatedBuilder(
                    animation: _steamController,
                    builder: (context, _) {
                      final double pulse = sin(_steamController.value * 2 * pi) * 0.15;
                      return Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFE65100).withValues(alpha: 0.35 + pulse),
                              const Color(0xFFD4AF37).withValues(alpha: 0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Sizzling Sparks & Smoke (Visible and intensified when cloche is lifted)
                Positioned(
                  bottom: 50,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_steamController, _clocheController]),
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(180, 190),
                        painter: _SizzleSteamAndSparksPainter(
                          progress: _steamController.value,
                          openRatio: _clocheController.value,
                        ),
                      );
                    },
                  ),
                ),

                // Base Dish (Wagyu & Périgord Truffle on hot slate plate)
                _buildDishBase(),

                // Ornate Golden Cloche Dome (Lifts up on tap/hover)
                AnimatedBuilder(
                  animation: _clocheController,
                  builder: (context, _) {
                    final double lift = CurvedAnimation(
                      parent: _clocheController,
                      curve: Curves.easeOutBack,
                    ).value * 85.0;

                    return Positioned(
                      bottom: 42 + lift,
                      child: _buildGoldenClocheDome(),
                    );
                  },
                ),

                // Interactive Tap Hint Label
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE6C280).withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isOpen ? Icons.restaurant : Icons.touch_app_outlined,
                          size: 13,
                          color: const Color(0xFFE6C280),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _isOpen ? 'CLOCHE REVEALED • SIZZLING' : 'TAP TO REVEAL SIZZLING DISH',
                          style: const TextStyle(
                            color: Color(0xFFF5EBE1),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
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

  Widget _buildDishBase() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sizzling Truffle Wagyu Medallions
        Container(
          width: 130,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF38150A),
                Color(0xFF5C2612),
                Color(0xFF2B1006),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6D00).withValues(alpha: 0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gold leaf garnish shimmer
              Container(
                width: 16,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6C280),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFFD4AF37), blurRadius: 4),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6C280),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        // Heavy Silver Rimmed Platter
        Container(
          width: 175,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFFC7BDB1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE6C280), width: 1.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoldenClocheDome() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crown Handle
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE6C280),
            border: Border.all(color: const Color(0xFF8C6430), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        // Dome Body
        Container(
          width: 145,
          height: 72,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75),
              topRight: Radius.circular(75),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFF4D4),
                Color(0xFFE6C280),
                Color(0xFFD4AF37),
                Color(0xFF8A652B),
              ],
              stops: [0.0, 0.35, 0.70, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 14,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF8A652B),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SizzleSteamAndSparksPainter extends CustomPainter {
  final double progress;
  final double openRatio;

  _SizzleSteamAndSparksPainter({
    required this.progress,
    required this.openRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (openRatio <= 0.05) return; // Hidden while cloche covers dish

    final Paint smokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14.0 * openRatio
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Thick billowing grill smoke curls
    for (int s = 0; s < 3; s++) {
      final Path path = Path();
      final double originX = size.width * (0.35 + (s * 0.15));
      final double originY = size.height;

      path.moveTo(originX, originY);
      for (int i = 1; i <= 20; i++) {
        final double t = i / 20.0;
        final double y = originY - (t * size.height * (0.6 + openRatio * 0.4));
        final double drift = sin((progress * 3 * pi) + (t * 5) + (s * 2)) * (26 * t);
        path.lineTo(originX + drift, y);
      }

      smokePaint.shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          const Color(0xFFFFECB3).withValues(alpha: 0.45 * openRatio),
          Colors.white.withValues(alpha: 0.20 * openRatio),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(path, smokePaint);
    }

    // Sizzling orange spark particles
    final Paint sparkPaint = Paint()..style = PaintingStyle.fill;
    final Random random = Random(42);

    for (int p = 0; p < 12; p++) {
      final double seed = random.nextDouble();
      final double particleT = (progress * 1.6 + seed) % 1.0;
      final double py = size.height - (particleT * size.height * 0.85);
      final double px = (size.width * 0.5) +
          (sin(particleT * 8 * pi + seed * 20) * (30.0 + (p * 4)));
      final double opacity = (sin(particleT * pi) * openRatio).clamp(0.0, 1.0);

      sparkPaint.color = const Color(0xFFFF9100).withValues(alpha: opacity);
      canvas.drawCircle(Offset(px, py), 2.2, sparkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SizzleSteamAndSparksPainter oldDelegate) => true;
}
