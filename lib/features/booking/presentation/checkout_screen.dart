import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';
import 'package:hampi_stays/features/booking/presentation/booking_screen.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingControllerProvider);
    final totalPrice = bookingState['totalPrice'] as double;

    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      appBar: AppBar(
        title: Text(
          'Review & Pay',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Luxury Summary Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HampiTheme.deepNavy,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: HampiTheme.deepNavy.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow(context, 'Stay Duration', '2 Nights', isHeader: true),
                  const Divider(color: Colors.white24, height: 32),
                  _buildSummaryRow(context, 'Base Price', '₹${totalPrice.toStringAsFixed(0)}'),
                  const SizedBox(height: 12),
                  _buildSummaryRow(context, 'Heritage Tax (5%)', '₹${(totalPrice * 0.05).toStringAsFixed(0)}'),
                  const SizedBox(height: 12),
                  _buildSummaryRow(context, 'Service Fee', '₹850'),
                  const Divider(color: Colors.white24, height: 32),
                  _buildSummaryRow(
                    context, 
                    'Total Amount', 
                    '₹${(totalPrice * 1.05 + 850).toStringAsFixed(0)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            
            _buildPaymentMethod(context, 'UPI / QR Code', Icons.qr_code_scanner, true),
            const SizedBox(height: 12),
            _buildPaymentMethod(context, 'Credit / Debit Card', Icons.credit_card, false),
            const SizedBox(height: 12),
            _buildPaymentMethod(context, 'Net Banking', Icons.account_balance, false),
            
            const SizedBox(height: 60),
            
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HampiTheme.mutedGold,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => _showSuccessDialog(context),
                child: const Text('CONFIRM & PAY NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isHeader = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isHeader || isTotal ? HampiTheme.warmIvory : HampiTheme.warmIvory.withOpacity(0.6),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isTotal ? HampiTheme.mutedGold : HampiTheme.warmIvory,
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 22 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(BuildContext context, String name, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? HampiTheme.mutedGold.withOpacity(0.1) : HampiTheme.sandstone.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? HampiTheme.mutedGold : HampiTheme.deepNavy.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? HampiTheme.mutedGold : HampiTheme.deepNavy),
          const SizedBox(width: 16),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          if (isSelected) const Icon(Icons.check_circle, color: HampiTheme.mutedGold, size: 20),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: HampiTheme.warmIvory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.check_circle_outline, color: HampiTheme.mutedGold, size: 80),
            const SizedBox(height: 24),
            Text(
              'Booking Confirmed!',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'Your sanctuary awaits. We have sent the confirmation details to your email.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/traveller/home'),
                child: const Text('BACK TO HOME'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
