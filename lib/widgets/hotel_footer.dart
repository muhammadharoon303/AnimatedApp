import 'package:flutter/material.dart';

class HotelFooter extends StatefulWidget {
  const HotelFooter({super.key});

  @override
  State<HotelFooter> createState() => _HotelFooterState();
}

class _HotelFooterState extends State<HotelFooter> {
  final TextEditingController _emailController = TextEditingController();
  bool _subscribed = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF090807),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              // Awards & Accolades Banner
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF13100E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                  ),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 24,
                  runSpacing: 18,
                  children: const [
                    _AwardBadge(
                      title: 'FORBES TRAVEL GUIDE',
                      subtitle: '5-Star Award 2025',
                    ),
                    _AwardBadge(
                      title: 'WORLD LUXURY AWARDS',
                      subtitle: 'Best Boutique Hotel',
                    ),
                    _AwardBadge(
                      title: 'MICHELIN GUIDE',
                      subtitle: '3-Star Gastronomy',
                    ),
                    _AwardBadge(
                      title: 'CONDÉ NAST',
                      subtitle: 'Gold List Sanctuary',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Newsletter & Concierge Section
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Column(
                  children: [
                    const Text(
                      'THE AURELIA GAZETTE',
                      style: TextStyle(
                        color: Color(0xFFE6C280),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Curated Inquiries & Private Privileges',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF9F6F0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Receive private villa releases, seasonal tasting menus, and secret yacht charters directly to your inbox.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8E857B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_subscribed)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B3828),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF2E7D32)),
                        ),
                        child: const Text(
                          'You are now enrolled in the Aurelia Private Circle.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter your email address...',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF6B6056),
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF171310),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: const Color(0xFFD4AF37)
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE6C280),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              if (_emailController.text.isNotEmpty) {
                                setState(() => _subscribed = true);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC77944),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Join',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              Divider(color: const Color(0xFF231C18), height: 1),
              const SizedBox(height: 30),

              // Bottom Credits & Location
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '© 2026 The Aurelia Palace & Resort. All rights reserved.',
                    style: TextStyle(color: Color(0xFF635950), fontSize: 12),
                  ),
                  Text(
                    'Riviera Coastline, France',
                    style: TextStyle(color: Color(0xFF8E857B), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AwardBadge extends StatelessWidget {
  final String title;
  final String subtitle;

  const _AwardBadge({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.workspace_premium_outlined,
          color: Color(0xFFD4AF37),
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE6C280),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF8E857B),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
