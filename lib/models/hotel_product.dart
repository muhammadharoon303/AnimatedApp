enum ProductAnimationType {
  turbulentSteam,
  sizzlingCloche,
  champagneBubbles,
  steamingBowl,
  moltenCake,
  realisticBed,
  infinityPool,
  hearthFire,
  geothermalMist,
}

enum DepartmentType {
  restaurant,
  hotel,
}

class HotelProduct {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final DepartmentType department;
  final double price;
  final String priceUnit;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String badge;
  final String description;
  final List<String> amenities;
  final List<String> highlights;
  final ProductAnimationType animationType;
  final bool isFeatured;

  const HotelProduct({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.department,
    required this.price,
    required this.priceUnit,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.badge,
    required this.description,
    required this.amenities,
    required this.highlights,
    required this.animationType,
    this.isFeatured = false,
  });

  static const List<HotelProduct> sampleProducts = [
    // ==========================================
    // SECTION 1: THE GRAND RESTAURANT & FOOD MENU
    // ==========================================

    // Food 1: Steaming Hot Coffee & Tea
    HotelProduct(
      id: 'food-artisan-brew',
      title: 'Artisan Imperial Steaming Brew',
      subtitle: 'Grand Cru Ceylon Golden Tips & Ethiopian Roasts',
      category: 'Artisan Brews & Tea Rites',
      department: DepartmentType.restaurant,
      price: 65,
      priceUnit: 'per guest',
      rating: 4.9,
      reviewsCount: 420,
      imageUrl:
          'https://images.unsplash.com/photo-1544787219-7f47ccb76574?auto=format&fit=crop&w=1200&q=80',
      badge: 'Live Evaporation Smoke',
      animationType: ProductAnimationType.turbulentSteam,
      isFeatured: true,
      description:
          'A ceremonial tasting rite featuring first-flush harvests steeped with fluid-buoyancy thermal vapor. Served in hammered brass with pure organic acacia honey and warm French canelés.',
      amenities: [
        'Multi-Harvest Rare Tea Flight',
        'Hand-Hammered Brass Service',
        'Organic Highland Acacia Honey',
        'Warm Sourdough Brioche & Canelés',
      ],
      highlights: [
        'Curling Thermal Evaporation Smoke',
        'Single-Origin Micro-Lots',
        'Table-Side Ceremonial Steep',
      ],
    ),

    // Food 2: Sizzling Wagyu & Truffle Platter
    HotelProduct(
      id: 'food-sizzling-wagyu',
      title: 'A5 Miyazaki Wagyu & Périgord Truffle',
      subtitle: 'Sizzling Over White Binchotan Coals with Gold Leaf',
      category: 'Steaks & Sizzling Mains',
      department: DepartmentType.restaurant,
      price: 340,
      priceUnit: 'per entrée',
      rating: 5.0,
      reviewsCount: 512,
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80',
      badge: 'Interactive Sizzling Cloche',
      animationType: ProductAnimationType.sizzlingCloche,
      isFeatured: true,
      description:
          'Hand-carved A5 Wagyu seared over white Japanese binchotan charcoal. Presented beneath an ornate golden dome cloche that releases an intoxicating cloud of aromatic grill smoke and crackling embers.',
      amenities: [
        'Table-Side Golden Cloche Reveal',
        'Black Périgord Winter Truffle Shavings',
        '30-Year Aged Aceto Balsamico',
        'Smoked Bone Marrow Emulsion',
      ],
      highlights: [
        'Lifting Cloche Smoke & Spark Burst',
        'A5 Japanese Miyazaki Certification',
        'Crackling Sizzle Physics',
      ],
    ),

    // Food 3: Steaming Consommé & Truffle Ramen Bowl
    HotelProduct(
      id: 'food-truffle-ramen',
      title: 'Kyoto Truffle Consommé & Ramen',
      subtitle: '24-Hour Roasted Broth with Morel Mushrooms & Soft Egg',
      category: 'Steaming Broths & Soups',
      department: DepartmentType.restaurant,
      price: 145,
      priceUnit: 'per bowl',
      rating: 4.9,
      reviewsCount: 310,
      imageUrl:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=1200&q=80',
      badge: 'Steaming Ceramic Bowl',
      animationType: ProductAnimationType.steamingBowl,
      isFeatured: true,
      description:
          'Simmered for 24 hours with black Périgord truffles, tender roasted duck, hand-pulled noodles, and floating garden scallions. Served in an authentic lacquer ceramic bowl with curling aromatic steam.',
      amenities: [
        '24-Hour Simmered Truffle Dashi',
        'Hand-Pulled Artisan Noodles',
        'Morel Mushrooms & Gilded Egg',
        'Traditional Lacquer Chopsticks',
      ],
      highlights: [
        'Curling Fragrant Broth Steam',
        'Simmering Golden Broth Surface',
        'Table-Side Broth Pour',
      ],
    ),

    // Food 4: Vintage Champagne Flute
    HotelProduct(
      id: 'food-champagne-flute',
      title: 'Dom Pérignon 2008 & 24K Gold Elixir',
      subtitle: 'Vintage Prestige Champagne with Distilled Orange & Saffron',
      category: 'Mixology & Sommelier Cellar',
      department: DepartmentType.restaurant,
      price: 195,
      priceUnit: 'per glass',
      rating: 5.0,
      reviewsCount: 280,
      imageUrl:
          'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?auto=format&fit=crop&w=1200&q=80',
      badge: 'Effervescent Fizz Bubbles',
      animationType: ProductAnimationType.champagneBubbles,
      isFeatured: true,
      description:
          'Rare vintage champagne charged with crystal effervescence, Seville orange bitters, mountain saffron, and suspended flakes of 24K edible gold leaf.',
      amenities: [
        'Vintage 2008 Prestige Cuvee',
        'Hand-Blown Crystal Flute',
        '24K Edible Gold Suspended Leaf',
        'Beluga Royal Caviar Tartlet',
      ],
      highlights: [
        'Rising Micro-Bubble Fizz Physics',
        'Surface Meniscus Popping Sparkles',
        'Prismatic Crystal Refraction',
      ],
    ),

    // Food 5: Warm Molten Lava Cake
    HotelProduct(
      id: 'food-lava-cake',
      title: 'Valrhona Molten Chocolate Lava Cake',
      subtitle: 'Warm Guanaja Chocolate with Bourbon Vanilla & 24K Flakes',
      category: 'Artisan Desserts',
      department: DepartmentType.restaurant,
      price: 55,
      priceUnit: 'per dessert',
      rating: 4.9,
      reviewsCount: 460,
      imageUrl:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=1200&q=80',
      badge: 'Oozing Warm Chocolate',
      animationType: ProductAnimationType.moltenCake,
      isFeatured: false,
      description:
          'Baked to order with pure French Valrhona Guanaja 70% chocolate. Features an oozing warm molten center dusted with edible gold leaf and delicate cocoa steam wisps.',
      amenities: [
        'Valrhona 70% Single-Estate Cocoa',
        'Madagascar Bourbon Vanilla Cream',
        'Fine Bone China Service',
        '24K Gold Garnish Shimmer',
      ],
      highlights: [
        'Oozing Molten Core Physics',
        'Gentle Warm Cocoa Vapor',
        'Crisp Caramelized Crust',
      ],
    ),

    // ==========================================
    // SECTION 2: PALACE HOTEL SUITES & ROOMS
    // ==========================================

    // Hotel 1: The Royal Master Suite Bed
    HotelProduct(
      id: 'hotel-royal-bed',
      title: 'The Royal Imperial Canopy Suite',
      subtitle: 'Hand-Carved Teak Canopy Bed with Silk Duvet & Starlight Sky',
      category: 'Palace Suites & Villas',
      department: DepartmentType.hotel,
      price: 3600,
      priceUnit: 'per night',
      rating: 5.0,
      reviewsCount: 215,
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=80',
      badge: 'Animated Luxury Canopy Bed',
      animationType: ProductAnimationType.realisticBed,
      isFeatured: true,
      description:
          'The ultimate sanctuary of rest. Features a grand hand-carved canopy king bed with plush breathing pillows, soft bedside amber lamp glow, and an arched view of the starlit Riviera night sky.',
      amenities: [
        'Bespoke Silk & Goose Down Bedding',
        '24/7 Dedicated Butler Brigade',
        'Starlight Riviera Arched Balcony',
        'In-Suite Champagne Breakfast',
      ],
      highlights: [
        'Rhythmic Breathing Pillow Physics',
        'Bedside Warm Sconce Glow Pulse',
        'Twinkling Starlight Window View',
      ],
    ),

    // Hotel 2: Cliffside Infinity Pool Villa
    HotelProduct(
      id: 'hotel-infinity-pool',
      title: 'The Royal Cliffside Infinity Villa',
      subtitle: 'Heated Mineral Infinity Pool & Suspended Sun Deck',
      category: 'Palace Suites & Villas',
      department: DepartmentType.hotel,
      price: 4200,
      priceUnit: 'per night',
      rating: 5.0,
      reviewsCount: 198,
      imageUrl:
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
      badge: 'Interactive Wave Caustics',
      animationType: ProductAnimationType.infinityPool,
      isFeatured: true,
      description:
          'Suspended over Mediterranean sea cliffs, featuring a heated infinity pool with undulating wave mathematics, shimmering sunlight caustics, and floating tropical hibiscus petals.',
      amenities: [
        'Heated Private Infinity Pool (32°C)',
        'Cliffside Dining Pergola',
        'Helipad & Private Yacht Mooring',
        'Marble Spa Bathroom',
      ],
      highlights: [
        'Real-Time Water Wave Mathematics',
        'Shimmering Pool Sunlight Caustics',
        'Touch-Responsive Concentric Ripples',
      ],
    ),

    // Hotel 3: The Obsidian Penthouse Hearth Fireplace
    HotelProduct(
      id: 'hotel-obsidian-hearth',
      title: 'The Obsidian Sky Penthouse',
      subtitle: 'Double-Height Glass Tower with Open Marble Fireplace',
      category: 'Palace Suites & Villas',
      department: DepartmentType.hotel,
      price: 4900,
      priceUnit: 'per night',
      rating: 5.0,
      reviewsCount: 114,
      imageUrl:
          'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=1200&q=80',
      badge: 'Living Fireplace Hearth',
      animationType: ProductAnimationType.hearthFire,
      isFeatured: true,
      description:
          'Perched at the summit of the palace with double-height glass walls. Centerpiece is a hand-carved Nero Marquina marble hearth with dancing birch flames, crackling sparks, and starlight Jacuzzi.',
      amenities: [
        'Double-Sided Nero Marquina Fireplace',
        'Private Sommelier Wine Cellar',
        'Starlight Open-Air Heated Jacuzzi',
        'Bang & Olufsen Acoustic System',
      ],
      highlights: [
        'Living Multi-Layer Flame Physics',
        'Swirling Ember Sparks & Hearth Glow',
        '360° Riviera Skyline Panorama',
      ],
    ),

    // Hotel 4: Zenith Geothermal Mineral Hot Springs
    HotelProduct(
      id: 'hotel-zenith-springs',
      title: 'Zenith Geothermal Hydro-Spa Suite',
      subtitle: 'Subterranean Basalt Baths with Eucalyptus Thermal Steam',
      category: 'Wellness & Thermal Baths',
      department: DepartmentType.hotel,
      price: 680,
      priceUnit: 'per journey',
      rating: 5.0,
      reviewsCount: 540,
      imageUrl:
          'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1200&q=80',
      badge: 'Volumetric Thermal Fog',
      animationType: ProductAnimationType.geothermalMist,
      isFeatured: false,
      description:
          'Subterranean volcanic thermal waters. Features concentric mineral droplet ripples, dense drifting eucalyptus steam clouds, and breathing hot basalt hydrotherapy loungers.',
      amenities: [
        'Thermal Mineral Springs (38°C)',
        'Volumetric Eucalyptus Steam Cave',
        'Basalt Heated Hydro-Loungers',
        'Himalayan Salt Sanctuary',
      ],
      highlights: [
        'Concentric Water Drop Ripple Physics',
        'Drifting Volumetric Steam Cloud',
        'Thermal Stone Heat Breathing Glow',
      ],
    ),
  ];
}
