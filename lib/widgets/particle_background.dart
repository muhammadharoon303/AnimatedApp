import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;

  const ParticleBackground({
    super.key,
    required this.child,
    this.scrollController,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  static const int _particleCount = 45;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(_generateParticle());
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  _Particle _generateParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      radius: _random.nextDouble() * 2.5 + 0.8,
      speed: _random.nextDouble() * 0.05 + 0.02,
      opacity: _random.nextDouble() * 0.45 + 0.15,
      driftPhase: _random.nextDouble() * 2 * pi,
      driftSpeed: _random.nextDouble() * 1.5 + 0.5,
      color: _random.nextBool()
          ? const Color(0xFFD4AF37) // Pale luxury gold
          : const Color(0xFFC77944), // Warm amber bronze
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background particles
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  time: _controller.value,
                  scrollOffset: widget.scrollController?.hasClients == true
                      ? widget.scrollController!.offset
                      : 0.0,
                ),
              );
            },
          ),
        ),
        // Content
        widget.child,
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  final double radius;
  final double speed;
  final double opacity;
  final double driftPhase;
  final double driftSpeed;
  final Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
    required this.driftPhase,
    required this.driftSpeed,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double time;
  final double scrollOffset;

  _ParticlePainter({
    required this.particles,
    required this.time,
    required this.scrollOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      // Upward drift with continuous loop
      double currentY = (p.y - (time * p.speed * 2.0)) % 1.0;
      if (currentY < 0) currentY += 1.0;

      // Subtle horizontal wobble
      double wobble = sin((time * 2 * pi * p.driftSpeed) + p.driftPhase) * 0.02;
      double currentX = (p.x + wobble) % 1.0;
      if (currentX < 0) currentX += 1.0;

      final double px = currentX * size.width;
      final double py = currentY * size.height;

      // Outer soft glow
      paint.color = p.color.withValues(alpha: p.opacity * 0.3);
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, p.radius * 2.5);
      canvas.drawCircle(Offset(px, py), p.radius * 2.0, paint);

      // Core particle
      paint.color = p.color.withValues(alpha: p.opacity);
      paint.maskFilter = null;
      canvas.drawCircle(Offset(px, py), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
