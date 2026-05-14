import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

class TravellerDashboard extends StatelessWidget {
  const TravellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      body: CustomScrollView(
        slivers: [
          // 🏮 Premium Header
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: HampiTheme.deepNavy,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Sanctuary',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: HampiTheme.warmIvory,
                  fontSize: 22,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [HampiTheme.deepNavy, Color(0xFF1E293B)],
                  ),
                ),
                child: Opacity(
                  opacity: 0.2,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=2000&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 🏆 Loyalty Rewards Card
                _buildLoyaltyCard(context),
                const SizedBox(height: 32),

                // 🗓️ Upcoming Trips
                Text(
                  'Upcoming Journey',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildTripCard(
                  context,
                  'Evolve Back Hampi',
                  'June 12 - June 15',
                  'Heritage Suite',
                  'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=1000&auto=format&fit=crop',
                ),
                const SizedBox(height: 32),

                // ⚡ Quick Actions Grid
                Text(
                  'Explore More',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildActionsGrid(context),
                
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: HampiTheme.luxuryGoldGradient,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: HampiTheme.mutedGold.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.stars, color: HampiTheme.warmIvory, size: 32),
              Text(
                'Gold Member',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 2),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '12,450',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: HampiTheme.warmIvory,
              fontSize: 36,
            ),
          ),
          Text(
            'Heritage Points Earned',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: HampiTheme.warmIvory.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: HampiTheme.warmIvory.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(HampiTheme.warmIvory),
            borderRadius: BorderRadius.circular(2),
          ),
          const SizedBox(height: 8),
          Text(
            '2,550 points to Platinum',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: HampiTheme.warmIvory.withOpacity(0.6),
              fontSize: 11,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildTripCard(BuildContext context, String title, String dates, String type, String img) {
    return Container(
      decoration: BoxDecoration(
        color: HampiTheme.sandstone.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
            child: Image.network(img, width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                Text(dates, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: HampiTheme.mutedGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: HampiTheme.deepNavy, size: 20),
          const SizedBox(width: 16),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildActionsGrid(BuildContext context) {
    final actions = [
      {'name': 'Wishlist', 'icon': Icons.favorite_outline},
      {'name': 'Referral', 'icon': Icons.card_giftcard_outlined},
      {'name': 'Reviews', 'icon': Icons.rate_review_outlined},
      {'name': 'Guide', 'icon': Icons.map_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.2,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: HampiTheme.warmIvory,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Icon(actions[index]['icon'] as IconData, color: HampiTheme.mutedGold, size: 20),
              const SizedBox(width: 12),
              Text(
                actions[index]['name'] as String,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      },
    ).animate().fadeIn(delay: 400.ms);
  }
}
