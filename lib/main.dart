import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/features/onboarding/presentation/onboarding_screen.dart';
import 'package:hampi_stays/features/auth/presentation/auth_screen.dart';
import 'package:hampi_stays/features/discovery/presentation/discovery_screen.dart';
import 'package:hampi_stays/features/booking/presentation/booking_screen.dart';
import 'package:hampi_stays/features/booking/presentation/checkout_screen.dart';
import 'package:hampi_stays/features/profile/presentation/traveller_dashboard.dart';
import 'package:hampi_stays/features/profile/presentation/profile_screen.dart';
import 'package:hampi_stays/features/owner/presentation/owner_dashboard.dart';
import 'package:hampi_stays/features/owner/presentation/owner_onboarding_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: HampiStaysApp(),
    ),
  );
}

class HampiStaysApp extends StatelessWidget {
  const HampiStaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HampiStays',
      debugShowCheckedModeBanner: false,
      theme: HampiTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    // Placeholder routes for Phase 2+
    GoRoute(
      path: '/traveller/home',
      builder: (context, state) => const DiscoveryScreen(),
    ),
    GoRoute(
      path: '/booking/rooms',
      builder: (context, state) => const RoomSelectionScreen(resortName: 'Evolve Back Hampi'),
    ),
    GoRoute(
      path: '/booking/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/traveller/dashboard',
      builder: (context, state) => const TravellerDashboard(),
    ),
    GoRoute(
      path: '/traveller/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/owner/dashboard',
      builder: (context, state) => const OwnerDashboard(),
    ),
    GoRoute(
      path: '/owner/onboarding',
      builder: (context, state) => const OwnerOnboardingScreen(),
    ),
  ],
);
