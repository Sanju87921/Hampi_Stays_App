import 'package:flutter/material.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      appBar: AppBar(
        title: Text(
          'Personal Profile',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            // 👤 Profile Avatar
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: HampiTheme.mutedGold, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1000&auto=format&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: HampiTheme.deepNavy,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: HampiTheme.warmIvory, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 📝 Personal Details Form
            _buildProfileField(context, 'Full Name', 'Sanjiv Kumar'),
            _buildProfileField(context, 'Email Address', 'sanjiv.k@luxury.com'),
            _buildProfileField(context, 'Phone Number', '+91 98765 43210'),
            _buildProfileField(context, 'Default Currency', 'INR (₹)'),
            
            const SizedBox(height: 40),
            
            // 🛡️ Security & Preferences
            _buildSectionHeader(context, 'Security'),
            _buildPreferenceTile(context, 'Biometric Login', true),
            _buildPreferenceTile(context, 'Push Notifications', true),
            
            const SizedBox(height: 60),
            
            // 🚪 Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: HampiTheme.clayRed,
                  side: const BorderSide(color: HampiTheme.clayRed),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: const Text('SIGN OUT OF SANCTUARY'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: HampiTheme.deepNavy.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: HampiTheme.sandstone.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildPreferenceTile(BuildContext context, String title, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Switch(
          value: value,
          onChanged: (v) {},
          activeColor: HampiTheme.mutedGold,
        ),
      ],
    );
  }
}
