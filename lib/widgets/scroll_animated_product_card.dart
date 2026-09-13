import 'package:flutter/material.dart';
import '../models/hotel_product.dart';
import 'animations/champagne_bubbles_animation.dart';
import 'animations/geothermal_mist_animation.dart';
import 'animations/hearth_fire_animation.dart';
import 'animations/molten_cake_animation.dart';
import 'animations/realistic_bed_animation.dart';
import 'animations/sizzling_cloche_animation.dart';
import 'animations/steaming_bowl_animation.dart';
import 'animations/turbulent_evaporation_painter.dart';
import 'animations/undulating_pool_animation.dart';

class ScrollAnimatedProductCard extends StatefulWidget {
  final HotelProduct product;
  final int index;
  final ScrollController scrollController;
  final VoidCallback onTap;

  const ScrollAnimatedProductCard({
    super.key,
    required this.product,
    required this.index,
    required this.scrollController,
    required this.onTap,
  });

  @override
  State<ScrollAnimatedProductCard> createState() =>
      _ScrollAnimatedProductCardState();
}

class _ScrollAnimatedProductCardState extends State<ScrollAnimatedProductCard> {
  final GlobalKey _cardKey = GlobalKey();
  double _viewportOffset = 0.0; // -1.0 (top) to 1.0 (bottom)
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateScrollProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollProgress());
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateScrollProgress);
    super.dispose();
  }

  void _updateScrollProgress() {
    if (!mounted) return;
    final RenderObject? renderObject =
        _cardKey.currentContext?.findRenderObject();
    if (renderObject is RenderBox && renderObject.hasSize) {
      final Size screenSize = MediaQuery.of(context).size;
      final Offset cardPosition = renderObject.localToGlobal(Offset.zero);
      final double cardCenterY = cardPosition.dy + (renderObject.size.height / 2);
      final double screenCenterY = screenSize.height / 2;

      final double rawProgress =
          (cardCenterY - screenCenterY) / (screenSize.height / 1.5);
      final double clamped = rawProgress.clamp(-1.0, 1.0);

      if ((clamped - _viewportOffset).abs() > 0.01) {
        setState(() {
          _viewportOffset = clamped;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 3D perspective calculations
    final double tiltX = -_viewportOffset * 0.09;
    final double tiltY = (widget.index.isEven ? 1 : -1) * (_viewportOffset.abs() * 0.03);
    final double centerProximity = 1.0 - (_viewportOffset.abs() * 0.4);
    final double scale = (0.92 + (centerProximity * 0.08)) * (_isHovered ? 1.02 : 1.0);
    final double parallaxY = -_viewportOffset * 35.0;

    return Container(
      key: _cardKey,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateX(tiltX)
              ..rotateY(tiltY)
              ..scaleByDouble(scale, scale, 1.0, 1.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 780),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFF141210),
                border: Border.all(
                  color: _isHovered
                      ? const Color(0xFFE6C280).withValues(alpha: 0.8)
                      : const Color(0xFFD4AF37).withValues(alpha: 0.22 + (centerProximity * 0.18)),
                  width: _isHovered ? 1.8 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC77944).withValues(alpha: 0.12 * centerProximity),
                    blurRadius: 36,
                    offset: const Offset(0, 18),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.7),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Main card content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Visual Section (Image with parallax or Steam Canvas)
                      SizedBox(
                        height: 320,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Parallax Background Image
                            Transform.translate(
                              offset: Offset(0, parallaxY),
                              child: Transform.scale(
                                scale: 1.15,
                                child: Image.network(
                                  widget.product.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF26201B),
                                            Color(0xFF161311),
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.hotel_class,
                                          size: 56,
                                          color: Color(0xFFC77944),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Dark cinema vignette gradient
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.2),
                                    Colors.black.withValues(alpha: 0.4),
                                    const Color(0xFF141210),
                                  ],
                                  stops: const [0.0, 0.6, 1.0],
                                ),
                              ),
                            ),

                            // Real-life Physics Simulation Centerpiece
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: _buildAnimationWidget(widget.product.animationType),
                              ),
                            ),

                            // Luxury Badge
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.65),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: const Color(0xFFE6C280).withValues(alpha: 0.6),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.auto_awesome,
                                      size: 14,
                                      color: Color(0xFFE6C280),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.product.badge.toUpperCase(),
                                      style: const TextStyle(
                                        color: Color(0xFFF5EBE1),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Category Tag
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC77944).withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.product.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Card Details Body
                      Padding(
                        padding: const EdgeInsets.fromLTRB(26, 16, 26, 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Star Rating & Review count
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 17,
                                  color: Color(0xFFD4AF37),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.product.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Color(0xFFF5EBE1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${widget.product.reviewsCount} verified reviews)',
                                  style: const TextStyle(
                                    color: Color(0xFF8E857B),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Title
                            Text(
                              widget.product.title,
                              style: const TextStyle(
                                color: Color(0xFFF9F6F0),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                height: 1.25,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Subtitle
                            Text(
                              widget.product.subtitle,
                              style: const TextStyle(
                                color: Color(0xFFC77944),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Description
                            Text(
                              widget.product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFFA69D92),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Amenities Pills
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.product.amenities
                                  .take(3)
                                  .map(
                                    (amenity) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF221C18),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(0xFF382F28),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.check_circle_outline,
                                            size: 13,
                                            color: Color(0xFFD4AF37),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            amenity,
                                            style: const TextStyle(
                                              color: Color(0xFFDCC8B3),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),

                            const SizedBox(height: 22),

                            // Divider
                            Divider(
                              color: const Color(0xFF2D2621),
                              height: 1,
                            ),

                            const SizedBox(height: 18),

                            // Price and CTA Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'EXPERIENCE FROM',
                                      style: TextStyle(
                                        color: Color(0xFF7A7067),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '\$${widget.product.price.toInt()}',
                                          style: const TextStyle(
                                            color: Color(0xFFE6C280),
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          ' / ${widget.product.priceUnit}',
                                          style: const TextStyle(
                                            color: Color(0xFF9E9285),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Reserve Button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 13,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFC77944),
                                        Color(0xFF9E5424),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFC77944)
                                            .withValues(alpha: 0.35),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Reserve Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Dynamic Glare / Light Reflection Overlay
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(
                              -1.0 + (_viewportOffset * 2.0),
                              -1.0,
                            ),
                            end: Alignment(
                              1.0 + (_viewportOffset * 2.0),
                              1.0,
                            ),
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(
                                alpha: 0.04 + (centerProximity * 0.04),
                              ),
                              Colors.transparent,
                            ],
                            stops: const [0.35, 0.5, 0.65],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationWidget(ProductAnimationType type) {
    switch (type) {
      case ProductAnimationType.turbulentSteam:
        return const TurbulentEvaporationWidget(scale: 0.95);
      case ProductAnimationType.sizzlingCloche:
        return const SizzlingClocheWidget(scale: 0.95);
      case ProductAnimationType.champagneBubbles:
        return const ChampagneBubblesWidget(scale: 0.95);
      case ProductAnimationType.steamingBowl:
        return const SteamingBowlWidget(scale: 0.92);
      case ProductAnimationType.moltenCake:
        return const MoltenCakeWidget(scale: 0.92);
      case ProductAnimationType.realisticBed:
        return const RealisticBedWidget(scale: 0.90);
      case ProductAnimationType.infinityPool:
        return const UndulatingPoolWidget(scale: 0.92);
      case ProductAnimationType.hearthFire:
        return const HearthFireWidget(scale: 0.92);
      case ProductAnimationType.geothermalMist:
        return const GeothermalMistWidget(scale: 0.92);
    }
  }
}
