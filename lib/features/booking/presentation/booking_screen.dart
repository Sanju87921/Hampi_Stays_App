import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

part 'booking_screen.g.dart';

@riverpod
class BookingController extends _$BookingController {
  @override
  Map<String, dynamic> build() {
    return {
      'step': 0,
      'selectedRoomId': null,
      'resortId': null,
      'addOns': [],
      'totalPrice': 0.0,
    };
  }

  void selectRoom(String roomId, double price) {
    state = {...state, 'selectedRoomId': roomId, 'totalPrice': price, 'step': 1};
  }

  void nextStep() {
    state = {...state, 'step': state['step'] + 1};
  }

  void previousStep() {
    if (state['step'] > 0) {
      state = {...state, 'step': state['step'] - 1};
    }
  }
}

class RoomSelectionScreen extends ConsumerWidget {
  final String resortName;

  const RoomSelectionScreen({super.key, required this.resortName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          resortName,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: Row(
              children: [
                _buildStep(context, 'Rooms', true),
                _buildDivider(),
                _buildStep(context, 'Details', false),
                _buildDivider(),
                _buildStep(context, 'Payment', false),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _RoomOption(
                  name: 'Heritage Suite',
                  price: '₹42,000',
                  amenities: ['Private Pool', 'Heritage View', 'King Bed'],
                  imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1000&auto=format&fit=crop',
                  onSelect: () => ref.read(bookingControllerProvider.notifier).selectRoom('r1', 42000),
                ),
                const SizedBox(height: 24),
                _RoomOption(
                  name: 'Royal Chamber',
                  price: '₹32,500',
                  amenities: ['Boulder View', 'Spa Access', 'Queen Bed'],
                  imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=1000&auto=format&fit=crop',
                  onSelect: () => ref.read(bookingControllerProvider.notifier).selectRoom('r2', 32500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? HampiTheme.mutedGold : HampiTheme.sandstone,
            shape: BoxShape.circle,
            border: Border.all(color: HampiTheme.mutedGold.withOpacity(0.3)),
          ),
          child: Center(
            child: isActive 
              ? const Icon(Icons.check, size: 16, color: HampiTheme.warmIvory)
              : Text('1', style: Theme.of(context).textTheme.bodySmall),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? HampiTheme.deepNavy : HampiTheme.deepNavy.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
      child: Container(
        height: 1,
        color: HampiTheme.sandstone,
        margin: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
      ),
    );
  }
}

class _RoomOption extends StatelessWidget {
  final String name;
  final String price;
  final List<String> amenities;
  final String imageUrl;
  final VoidCallback onSelect;

  const _RoomOption({
    required this.name,
    required this.price,
    required this.amenities,
    required this.imageUrl,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HampiTheme.sandstone.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
                    Text(price, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: HampiTheme.mutedGold)),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: amenities.map((a) => _buildAmenityTag(context, a)).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSelect,
                    child: const Text('SELECT THIS ROOM'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: HampiTheme.warmIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.1)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11)),
    );
  }
}
