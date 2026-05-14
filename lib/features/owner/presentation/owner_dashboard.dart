import 'package:flutter/material.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: HampiTheme.deepNavy,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Owner Dashboard',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: HampiTheme.warmIvory, fontSize: 20),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 📊 Analytics Overview
                _buildAnalyticsRow(context),
                const SizedBox(height: 32),
                
                // 🏘️ My Properties
                Text(
                  'My Properties',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildPropertyCard(context, 'Hampi Heritage Resort', 'Kamalapur', 'Active'),
                const SizedBox(height: 24),
                
                // 📅 Upcoming Check-ins
                Text(
                  'Upcoming Check-ins',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildGuestTile(context, 'Rahul Sharma', 'Heritage Suite', 'Check-in Today'),
                _buildGuestTile(context, 'Anita Desai', 'Royal Chamber', 'Check-in Tomorrow'),
                
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/owner/onboarding'), // Mock route
        backgroundColor: HampiTheme.mutedGold,
        label: const Text('ADD NEW PROPERTY'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAnalyticsRow(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, 'Total Revenue', '₹8.4L', Icons.payments_outlined),
        const SizedBox(width: 16),
        _buildStatCard(context, 'Occupancy', '84%', Icons.hotel_outlined),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HampiTheme.sandstone.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: HampiTheme.mutedGold, size: 24),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24)),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, String name, String location, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HampiTheme.deepNavy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: HampiTheme.warmIvory.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.hotel, color: HampiTheme.mutedGold),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: HampiTheme.warmIvory, fontSize: 16)),
                Text(location, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: HampiTheme.warmIvory.withOpacity(0.6))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: HampiTheme.mutedGold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(status, style: const TextStyle(color: HampiTheme.mutedGold, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestTile(BuildContext context, String guest, String room, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HampiTheme.warmIvory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: HampiTheme.sandstone, child: Icon(Icons.person, color: HampiTheme.deepNavy)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(guest, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text(room, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(status, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: HampiTheme.mutedGold, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
