import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/features/discovery/presentation/widgets/discovery_widgets.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  static const _hampiCenter = LatLng(15.3350, 76.4600);
  
  // Mock data for Phase 2 UI
  final List<Map<String, dynamic>> _mockResorts = [
    {
      'title': 'Evolve Back Kamala Reserver',
      'location': 'Kamalapur, Hampi',
      'price': '₹42,000/night',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2000&auto=format&fit=crop',
    },
    {
      'title': 'Hampi Heritage & Wilderness',
      'location': 'Near Vitthala Temple',
      'price': '₹28,500/night',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=2000&auto=format&fit=crop',
    },
    {
      'title': 'The Kishkinda Heritage Resort',
      'location': 'Anegundi, Hampi',
      'price': '₹18,000/night',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2000&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🗺️ Map-First Layer
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _hampiCenter,
              zoom: 13,
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            // Custom map style would be applied here in a real scenario
          ),
          
          // 🔍 Floating Immersive Search Bar
          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ImmersiveSearchBar(),
            ),
          ),
          
          // 🛌 Scrollable Resort Listings (Bottom Sheet style)
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: HampiTheme.warmIvory,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _mockResorts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Drag Handle and Title
                      return Column(
                        children: [
                          const SizedBox(height: 12),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: HampiTheme.deepNavy.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended Stays',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'See All',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: HampiTheme.mutedGold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    }
                    
                    final resort = _mockResorts[index - 1];
                    return CinematicResortCard(
                      title: resort['title'],
                      location: resort['location'],
                      price: resort['price'],
                      rating: resort['rating'],
                      imageUrl: resort['image'],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      
      // 🏷️ Luxury Dock (Bottom Navigation)
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        height: 70,
        decoration: BoxDecoration(
          color: HampiTheme.deepNavy,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: HampiTheme.deepNavy.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.explore, true, '/traveller/home'),
            _buildNavItem(context, Icons.favorite_outline, false, '/traveller/dashboard'),
            _buildNavItem(context, Icons.confirmation_number_outlined, false, '/traveller/dashboard'),
            _buildNavItem(context, Icons.person_outline, false, '/traveller/profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, bool isActive, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? HampiTheme.mutedGold : HampiTheme.warmIvory.withOpacity(0.5),
            size: 26,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: HampiTheme.mutedGold,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
