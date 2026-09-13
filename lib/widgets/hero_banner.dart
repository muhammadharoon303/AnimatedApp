import 'package:flutter/material.dart';
import 'animations/turbulent_evaporation_painter.dart';

class HeroBanner extends StatelessWidget {
  final VoidCallback onExplorePressed;
  final VoidCallback? onRestaurantPressed;
  final VoidCallback? onHotelPressed;

  const HeroBanner({
    super.key,
    required this.onExplorePressed,
    this.onRestaurantPressed,
    this.onHotelPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isWide = screenSize.width > 750;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),

          // Hotel Monogram & Top Tagline
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 36,
                color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
              ),
              const SizedBox(width: 14),
              const Text(
                'THE RIVIERA SANCTUARY',
                style: TextStyle(
                  color: Color(0xFFE6C280),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.5,
                ),
              ),
              const SizedBox(width: 14),
              Container(
                height: 1,
                width: 36,
                color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Grand Hotel Title
          Text(
            'THE AURELIA\nPALACE & RESORT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFF9F6F0),
              fontSize: isWide ? 56 : 38,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
              height: 1.15,
              shadows: [
                Shadow(
                  color: const Color(0xFFC77944).withValues(alpha: 0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: const Text(
              'An idyllic sanctuary where ultra-luxury clifftop villas, Michelin gastronomy, and bespoke ocean voyages converge in timeless serenity.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFA69D92),
                fontSize: 15,
                height: 1.6,
                letterSpacing: 0.4,
              ),
            ),
          ),

          const SizedBox(height: 36),

          // Floating Steaming Centerpiece with Live Evaporation Physics
          const Center(
            child: TurbulentEvaporationWidget(
              scale: 1.15,
              interactive: true,
            ),
          ),

          const SizedBox(height: 20),

          // Centerpiece Label with Tap Prompt
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC77944),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Welcome Reception • Tap Cup for Thermal Vapor Burst',
                style: TextStyle(
                  color: Color(0xFFE6C280),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Combined Dual Portal: Restaurant & Palace Suites
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              OutlinedButton.icon(
                onPressed: onRestaurantPressed,
                icon: const Icon(Icons.restaurant, color: Color(0xFFE6C280), size: 16),
                label: const Text(
                  'The Grand Restaurant & Bar',
                  style: TextStyle(
                    color: Color(0xFFF5EBE1),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onHotelPressed,
                icon: const Icon(Icons.hotel, color: Color(0xFFC77944), size: 16),
                label: const Text(
                  'Palace Suites & Cliffside Villas',
                  style: TextStyle(
                    color: Color(0xFFF5EBE1),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFC77944), width: 1.2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Quick Reservation Bar
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF191512).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: isWide
                  ? Row(
                      children: [
                        _buildQuickField(
                          icon: Icons.calendar_today_outlined,
                          title: 'DATES',
                          value: 'Oct 14 — Oct 20',
                        ),
                        _buildDivider(),
                        _buildQuickField(
                          icon: Icons.person_outline,
                          title: 'GUESTS',
                          value: '2 Adults, 1 Villa',
                        ),
                        _buildDivider(),
                        _buildQuickField(
                          icon: Icons.spa_outlined,
                          title: 'EXPERIENCES',
                          value: 'All-Inclusive Luxury',
                        ),
                        const SizedBox(width: 16),
                        _buildCheckButton(),
                      ],
                    )
                  : Column(
                      children: [
                        _buildQuickField(
                          icon: Icons.calendar_today_outlined,
                          title: 'DATES',
                          value: 'Oct 14 — Oct 20',
                        ),
                        const SizedBox(height: 12),
                        _buildQuickField(
                          icon: Icons.person_outline,
                          title: 'GUESTS',
                          value: '2 Adults, 1 Villa',
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _buildCheckButton(),
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 48),

          // Scroll Down Indicator
          GestureDetector(
            onTap: onExplorePressed,
            child: Column(
              children: [
                const Text(
                  'SCROLL TO EXPLORE SUITES & PRODUCTS',
                  style: TextStyle(
                    color: Color(0xFF7D7267),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 32,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE6C280).withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6C280),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickField({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF28201A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFE6C280), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF7A7067),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFF5EBE1),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 36,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      color: const Color(0xFF332A23),
    );
  }

  Widget _buildCheckButton() {
    return ElevatedButton(
      onPressed: onExplorePressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC77944),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
      ),
      child: const Text(
        'Explore Collection',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
