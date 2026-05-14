import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/core/widgets/hampi_slider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ Immersive Background Image (Full-bleed)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=2000&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),

          // 🎭 Luxury Gradient Overlay (Bottom-to-Top)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    HampiTheme.deepNavy.withOpacity(0.9),
                    HampiTheme.deepNavy.withOpacity(0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // 🏛️ Content Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  
                  // Brand Logo / Tagline
                  Text(
                    'HAMPI STAYS',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: HampiTheme.mutedGold,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),

                  const SizedBox(height: 16),

                  // Hero Heading
                  Text(
                    'Ancient Sanctuary,\nModern Precision.',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: HampiTheme.warmIvory,
                    ),
                  ).animate()
                    .fadeIn(delay: 400.ms, duration: 800.ms)
                    .slideY(begin: 0.1, curve: HampiTheme.luxuryCurve),

                  const SizedBox(height: 24),

                  // Subtext
                  Text(
                    'Experience the architectural marvels of Hampi with world-class hospitality and heritage stays.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HampiTheme.warmIvory.withOpacity(0.8),
                    ),
                  ).animate()
                    .fadeIn(delay: 800.ms, duration: 800.ms)
                    .slideY(begin: 0.1, curve: HampiTheme.luxuryCurve),

                  const SizedBox(height: 64),

                  // 🛝 Signature Slider
                  Center(
                    child: HampiSlider(
                      text: 'Slide to Explore',
                      onCompleted: () {
                        context.go('/auth');
                      },
                    ),
                  ).animate()
                    .fadeIn(delay: 1200.ms, duration: 800.ms)
                    .scale(begin: const Offset(0.9, 0.9), curve: Curves.elasticOut),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
