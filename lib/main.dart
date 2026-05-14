import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/features/onboarding/presentation/onboarding_screen.dart';
import 'package:hampi_stays/features/auth/presentation/auth_screen.dart';

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
      builder: (context, state) => const Scaffold(body: Center(child: Text('Traveller Home'))),
    ),
    GoRoute(
      path: '/owner/dashboard',
      builder: (context, state) => const Scaffold(body: Center(child: Text('Owner Dashboard'))),
    ),
  ],
);
