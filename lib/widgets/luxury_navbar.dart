import 'dart:ui';
import 'package:flutter/material.dart';

class LuxuryNavbar extends StatelessWidget {
  final VoidCallback onBookPressed;
  final Function(String category) onCategorySelected;

  const LuxuryNavbar({
    super.key,
    required this.onBookPressed,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isWide = size.width > 960;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0B0A).withValues(alpha: 0.78),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Monogram / Logo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE6C280),
                        width: 1.5,
                      ),
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFF38291D),
                          Color(0xFF14110F),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Color(0xFFE6C280),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'A U R E L I A',
                        style: TextStyle(
                          color: Color(0xFFF9F6F0),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                      Text(
                        'PALACE & RESORT',
                        style: TextStyle(
                          color: Color(0xFFC77944),
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Desktop navigation menu links
              if (isWide)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavLink('Suites', () => onCategorySelected('Suites & Villas')),
                    _buildNavLink('Dining', () => onCategorySelected('Fine Dining')),
                    _buildNavLink('Wellness', () => onCategorySelected('Wellness & Spa')),
                    _buildNavLink('Experiences', () => onCategorySelected('Curated Experiences')),
                  ],
                ),

              // Action button
              ElevatedButton(
                onPressed: onBookPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC77944),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Book Stay',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFDCC8B3),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
