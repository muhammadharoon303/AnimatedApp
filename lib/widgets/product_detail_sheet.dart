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

class ProductDetailSheet extends StatefulWidget {
  final HotelProduct product;

  const ProductDetailSheet({
    super.key,
    required this.product,
  });

  static void show(BuildContext context, HotelProduct product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => ProductDetailSheet(product: product),
    );
  }

  @override
  State<ProductDetailSheet> createState() => _ProductDetailSheetState();
}

class _ProductDetailSheetState extends State<ProductDetailSheet> {
  int _guests = 2;
  int _nights = 3;
  bool _isBooked = false;

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.product.price * _nights;
    final Size size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.88,
        maxWidth: 820,
      ),
      margin: EdgeInsets.only(
        left: size.width > 820 ? (size.width - 820) / 2 : 0,
        right: size.width > 820 ? (size.width - 820) / 2 : 0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141210),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 36,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF4A3E34),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Scrollable Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Category & Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF28211C),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          widget.product.badge.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFE6C280),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFFB5A48F),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Title
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      color: Color(0xFFF9F6F0),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    widget.product.subtitle,
                    style: const TextStyle(
                      color: Color(0xFFC77944),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Media Showcase: Steam cup or Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: const Color(0xFF221C18),
                              child: const Icon(
                                Icons.hotel,
                                size: 48,
                                color: Color(0xFFC77944),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: _buildDetailAnimation(widget.product.animationType),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'THE EXPERIENCE',
                    style: TextStyle(
                      color: Color(0xFF7A7067),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      color: Color(0xFFC4B8A9),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Amenities Grid
                  const Text(
                    'INCLUDED PRIVILEGES',
                    style: TextStyle(
                      color: Color(0xFF7A7067),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: widget.product.amenities
                        .map(
                          (amenity) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1814),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF382F28),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_outline_rounded,
                                  size: 15,
                                  color: Color(0xFFD4AF37),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  amenity,
                                  style: const TextStyle(
                                    color: Color(0xFFF5EBE1),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 28),

                  // Reservation Customizer (Nights & Guests)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1814),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Nights counter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Duration (Nights):',
                              style: TextStyle(
                                color: Color(0xFFDCC8B3),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                _buildCounterButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    if (_nights > 1) {
                                      setState(() => _nights--);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    '$_nights',
                                    style: const TextStyle(
                                      color: Color(0xFFE6C280),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() => _nights++);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Divider(color: const Color(0xFF332A23), height: 1),
                        const SizedBox(height: 16),

                        // Guests counter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Guests:',
                              style: TextStyle(
                                color: Color(0xFFDCC8B3),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                _buildCounterButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    if (_guests > 1) {
                                      setState(() => _guests--);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    '$_guests',
                                    style: const TextStyle(
                                      color: Color(0xFFE6C280),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() => _guests++);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Pricing Breakdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ESTIMATED TOTAL',
                            style: TextStyle(
                              color: Color(0xFF7A7067),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${totalPrice.toInt()}',
                            style: const TextStyle(
                              color: Color(0xFFE6C280),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Tax & Service Included',
                        style: TextStyle(
                          color: const Color(0xFF9E9285).withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Confirmation or Reserve CTA
                  if (_isBooked)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B3828),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF2E7D32)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF81C784),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Reservation Confirmed! Welcome to Aurelia.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _isBooked = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC77944),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          'Confirm Luxury Reservation',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
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

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFF2A221C),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4A3E34)),
        ),
        child: Icon(icon, color: const Color(0xFFF5EBE1), size: 16),
      ),
    );
  }

  Widget _buildDetailAnimation(ProductAnimationType type) {
    switch (type) {
      case ProductAnimationType.turbulentSteam:
        return const TurbulentEvaporationWidget(scale: 0.88, interactive: true);
      case ProductAnimationType.sizzlingCloche:
        return const SizzlingClocheWidget(scale: 0.88);
      case ProductAnimationType.champagneBubbles:
        return const ChampagneBubblesWidget(scale: 0.88);
      case ProductAnimationType.steamingBowl:
        return const SteamingBowlWidget(scale: 0.85);
      case ProductAnimationType.moltenCake:
        return const MoltenCakeWidget(scale: 0.85);
      case ProductAnimationType.realisticBed:
        return const RealisticBedWidget(scale: 0.82);
      case ProductAnimationType.infinityPool:
        return const UndulatingPoolWidget(scale: 0.85);
      case ProductAnimationType.hearthFire:
        return const HearthFireWidget(scale: 0.85);
      case ProductAnimationType.geothermalMist:
        return const GeothermalMistWidget(scale: 0.85);
    }
  }
}
