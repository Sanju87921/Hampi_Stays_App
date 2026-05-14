import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/features/auth/data/auth_service.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bioService = ref.watch(biometricServiceProvider);
    final storage = ref.watch(secureStorageProvider);

    Future<void> handleRoleSelection(String role) async {
      // Premium Biometric Authentication
      final isAuthenticated = await bioService.authenticate();
      
      if (isAuthenticated) {
        // Save session securely
        await storage.saveRole(role);
        await storage.saveToken("mock_jwt_token_for_$role");
        
        if (context.mounted) {
          context.go(role == 'Traveller' ? '/traveller/home' : '/owner/dashboard');
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication failed. Please try again.'),
              backgroundColor: HampiTheme.clayRed,
            ),
          );
        }
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          // Subtle heritage background pattern
          Container(color: HampiTheme.warmIvory),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  Text(
                    'Welcome to',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 24,
                      color: HampiTheme.deepNavy.withOpacity(0.6),
                    ),
                  ).animate().fadeIn().slideX(begin: -0.1),
                  
                  Text(
                    'HampiStays',
                    style: Theme.of(context).textTheme.displayLarge,
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    'Choose your path to begin the journey.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).animate().fadeIn(delay: 400.ms),
                  
                  const SizedBox(height: 60),
                  
                  // Role Selection Cards
                  Expanded(
                    child: Column(
                      children: [
                        _RoleCard(
                          title: 'Traveller',
                          subtitle: 'Discover & book heritage stays',
                          icon: Icons.explore_outlined,
                          onTap: () => handleRoleSelection('Traveller'),
                        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                        
                        const SizedBox(height: 24),
                        
                        _RoleCard(
                          title: 'Resort Owner',
                          subtitle: 'Manage properties & hosting',
                          icon: Icons.domain_outlined,
                          onTap: () => handleRoleSelection('Owner'),
                        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
                      ],
                    ),
                  ),
                  
                  // Login Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: HampiTheme.mutedGold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => HapticFeedback.lightImpact(),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: HampiTheme.sandstone.withOpacity(0.5),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: HampiTheme.deepNavy,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: HampiTheme.warmIvory, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: HampiTheme.mutedGold,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
