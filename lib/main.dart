import 'package:flutter/material.dart';
import 'models/hotel_product.dart';
import 'widgets/animations/turbulent_evaporation_painter.dart';
import 'widgets/category_filter_bar.dart';
import 'widgets/hotel_footer.dart';
import 'widgets/particle_background.dart';
import 'widgets/product_detail_sheet.dart';
import 'widgets/scroll_animated_product_card.dart';

void main() {
  runApp(const LuxuryHotelApp());
}

class LuxuryHotelApp extends StatelessWidget {
  const LuxuryHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Aurelia Palace & Riviera Resort',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C0A09),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC77944),
          secondary: Color(0xFFD4AF37),
          surface: Color(0xFF141210),
        ),
        fontFamily: 'Georgia',
      ),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0; // 0 = Food Menu, 1 = Hotel Suites, 2 = Welcome Lounge

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // TAB 0: THE GRAND RESTAURANT & FOOD MENU
          const FoodMenuPage(),

          // TAB 1: PALACE HOTEL SUITES & ROOMS
          const HotelSuitesPage(),

          // TAB 2: RESORT LOUNGE & HERO CENTERPIECE
          ResortLoungePage(
            onExploreFood: () => setState(() => _currentIndex = 0),
            onExploreHotel: () => setState(() => _currentIndex = 1),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF110E0C),
          border: Border(
            top: BorderSide(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFE6C280),
          unselectedItemColor: const Color(0xFF8E857B),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              activeIcon: Icon(Icons.restaurant_menu, color: Color(0xFFE6C280)),
              label: 'Food Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              activeIcon: Icon(Icons.hotel, color: Color(0xFFE6C280)),
              label: 'Hotel Suites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee),
              activeIcon: Icon(Icons.coffee, color: Color(0xFFE6C280)),
              label: 'Artisan Lounge',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// PAGE 1: THE GRAND RESTAURANT & FOOD MENU (All Food Items Animated!)
// ============================================================================
class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Steaks & Sizzling Mains',
    'Steaming Broths & Soups',
    'Artisan Brews & Tea Rites',
    'Mixology & Sommelier Cellar',
    'Artisan Desserts',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<HotelProduct> foodItems = HotelProduct.sampleProducts
        .where((p) => p.department == DepartmentType.restaurant)
        .where((p) => _selectedCategory == 'All' || p.category == _selectedCategory)
        .toList();

    return ParticleBackground(
      scrollController: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header Bar
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1E1712),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 24, color: const Color(0xFFD4AF37)),
                      const SizedBox(width: 8),
                      const Text(
                        'SECTION 1 • MICHELIN DINING',
                        style: TextStyle(
                          color: Color(0xFFE6C280),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(height: 1, width: 24, color: const Color(0xFFD4AF37)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The Grand Restaurant Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF9F6F0),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Every single dish animates with real-life steam, sizzling grill coals, and fizzing champagne bubbles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF9E9285), fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  CategoryFilterBar(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    onSelected: (cat) => setState(() => _selectedCategory = cat),
                  ),
                ],
              ),
            ),
          ),

          // Animated Food Cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = foodItems[index];
                return Center(
                  child: ScrollAnimatedProductCard(
                    key: ValueKey(product.id),
                    product: product,
                    index: index,
                    scrollController: _scrollController,
                    onTap: () => ProductDetailSheet.show(context, product),
                  ),
                );
              },
              childCount: foodItems.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PAGE 2: PALACE HOTEL SUITES & ROOMS (All Hotel Items Animated: Bed, Pool, Hearth!)
// ============================================================================
class HotelSuitesPage extends StatefulWidget {
  const HotelSuitesPage({super.key});

  @override
  State<HotelSuitesPage> createState() => _HotelSuitesPageState();
}

class _HotelSuitesPageState extends State<HotelSuitesPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Palace Suites & Villas',
    'Wellness & Thermal Baths',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<HotelProduct> hotelItems = HotelProduct.sampleProducts
        .where((p) => p.department == DepartmentType.hotel)
        .where((p) => _selectedCategory == 'All' || p.category == _selectedCategory)
        .toList();

    return ParticleBackground(
      scrollController: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header Bar
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1E1712),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: 24, color: const Color(0xFFD4AF37)),
                      const SizedBox(width: 8),
                      const Text(
                        'SECTION 2 • LUXURY ACCOMMODATIONS',
                        style: TextStyle(
                          color: Color(0xFFE6C280),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(height: 1, width: 24, color: const Color(0xFFD4AF37)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Palace Hotel Suites & Villas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF9F6F0),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Featuring the animated Royal Canopy Bed with starlight, undulating Infinity Pool, and Marble Fireplace Hearth.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF9E9285), fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  CategoryFilterBar(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    onSelected: (cat) => setState(() => _selectedCategory = cat),
                  ),
                ],
              ),
            ),
          ),

          // Animated Hotel Cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = hotelItems[index];
                return Center(
                  child: ScrollAnimatedProductCard(
                    key: ValueKey(product.id),
                    product: product,
                    index: index,
                    scrollController: _scrollController,
                    onTap: () => ProductDetailSheet.show(context, product),
                  ),
                );
              },
              childCount: hotelItems.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PAGE 3: RESORT LOUNGE & HERO CENTERPIECE (Interactive Steaming Cup & Overview)
// ============================================================================
class ResortLoungePage extends StatelessWidget {
  final VoidCallback onExploreFood;
  final VoidCallback onExploreHotel;

  const ResortLoungePage({
    super.key,
    required this.onExploreFood,
    required this.onExploreHotel,
  });

  @override
  Widget build(BuildContext context) {
    return ParticleBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Resort Tagline
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1, width: 30, color: const Color(0xFFD4AF37)),
                  const SizedBox(width: 10),
                  const Text(
                    'THE RIVIERA SANCTUARY',
                    style: TextStyle(
                      color: Color(0xFFE6C280),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(height: 1, width: 30, color: const Color(0xFFD4AF37)),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                'THE AURELIA\nPALACE & RESORT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF9F6F0),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Welcome to the unified luxury resort. Tap the cup below to stir live thermal steam, or jump directly into the animated Food Menu or Hotel Suites.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFA69D92), fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 28),

              // Interactive Steaming Cup Centerpiece
              const Center(
                child: TurbulentEvaporationWidget(
                  scale: 1.15,
                  interactive: true,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Grand Cru Tea & Coffee • Tap Cup for Vapor Burst',
                style: TextStyle(
                  color: Color(0xFFE6C280),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 36),

              // Quick Jump Cards
              Row(
                children: [
                  Expanded(
                    child: _buildJumpCard(
                      icon: Icons.restaurant,
                      title: 'Food Menu',
                      subtitle: '5 Animated Dishes',
                      onTap: onExploreFood,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildJumpCard(
                      icon: Icons.hotel,
                      title: 'Hotel Suites',
                      subtitle: '4 Animated Suites',
                      onTap: onExploreHotel,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const HotelFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJumpCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1612),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFE6C280), size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFF9F6F0),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF9E9285),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
