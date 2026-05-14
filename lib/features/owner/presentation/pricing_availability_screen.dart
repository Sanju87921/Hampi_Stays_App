import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

// --- STATE MANAGEMENT ---

class PricingState {
  final DateTime selectedDate;
  final Map<String, double> roomPrices;
  final Map<String, int> roomAvailability;
  final Map<String, bool> isBlocked;

  PricingState({
    required this.selectedDate,
    required this.roomPrices,
    required this.roomAvailability,
    required this.isBlocked,
  });

  PricingState copyWith({
    DateTime? selectedDate,
    Map<String, double>? roomPrices,
    Map<String, int>? roomAvailability,
    Map<String, bool>? isBlocked,
  }) {
    return PricingState(
      selectedDate: selectedDate ?? this.selectedDate,
      roomPrices: roomPrices ?? this.roomPrices,
      roomAvailability: roomAvailability ?? this.roomAvailability,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}

class PricingController extends StateNotifier<PricingState> {
  PricingController()
      : super(PricingState(
          selectedDate: DateTime.now(),
          roomPrices: {'Heritage Suite': 42000, 'Royal Chamber': 32500},
          roomAvailability: {'Heritage Suite': 2, 'Royal Chamber': 5},
          isBlocked: {'Heritage Suite': false, 'Royal Chamber': false},
        ));

  void selectDate(DateTime date) {
    // In a real app, this would fetch new data for the selected date.
    // Here we just mock some variation for demonstration.
    final bool isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
    
    state = state.copyWith(
      selectedDate: date,
      roomPrices: {
        'Heritage Suite': isWeekend ? 48000 : 42000,
        'Royal Chamber': isWeekend ? 38000 : 32500,
      },
      roomAvailability: {
        'Heritage Suite': isWeekend ? 0 : 2,
        'Royal Chamber': isWeekend ? 1 : 5,
      },
    );
  }

  void updatePrice(String roomType, double newPrice) {
    final updatedPrices = Map<String, double>.from(state.roomPrices);
    updatedPrices[roomType] = newPrice;
    state = state.copyWith(roomPrices: updatedPrices);
  }

  void updateAvailability(String roomType, int newCount) {
    final updatedAvail = Map<String, int>.from(state.roomAvailability);
    updatedAvail[roomType] = newCount;
    state = state.copyWith(roomAvailability: updatedAvail);
  }

  void toggleBlockStatus(String roomType) {
    final updatedBlocks = Map<String, bool>.from(state.isBlocked);
    updatedBlocks[roomType] = !(updatedBlocks[roomType] ?? false);
    state = state.copyWith(isBlocked: updatedBlocks);
  }
}

final pricingControllerProvider = StateNotifierProvider<PricingController, PricingState>((ref) {
  return PricingController();
});

// --- UI COMPONENTS ---

class PricingAvailabilityScreen extends ConsumerWidget {
  const PricingAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pricingControllerProvider);
    final controller = ref.read(pricingControllerProvider.notifier);

    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      appBar: AppBar(
        backgroundColor: HampiTheme.deepNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: HampiTheme.warmIvory),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Inventory',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: HampiTheme.warmIvory,
                    fontSize: 20,
                  ),
            ),
            Text(
              'Hampi Heritage Resort',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: HampiTheme.warmIvory.withOpacity(0.7),
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: HampiTheme.mutedGold),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(context, state.selectedDate, controller),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildSectionHeader(context, 'Availability & Pricing'),
                const SizedBox(height: 16),
                ...state.roomPrices.keys.map((roomType) {
                  return _buildRoomManagementCard(
                    context,
                    roomType: roomType,
                    price: state.roomPrices[roomType]!,
                    available: state.roomAvailability[roomType]!,
                    isBlocked: state.isBlocked[roomType]!,
                    controller: controller,
                  );
                }).toList(),
                const SizedBox(height: 40),
                _buildBulkActionCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, DateTime selectedDate, PricingController controller) {
    final now = DateTime.now();
    final dates = List.generate(30, (index) => now.add(Duration(days: index)));

    return Container(
      color: HampiTheme.deepNavy,
      padding: const EdgeInsets.only(bottom: 24, top: 16),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final isSelected = date.year == selectedDate.year &&
                date.month == selectedDate.month &&
                date.day == selectedDate.day;

            return GestureDetector(
              onTap: () => controller.selectDate(date),
              child: Container(
                width: 65,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: isSelected ? HampiTheme.mutedGold : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? HampiTheme.mutedGold : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MMM').format(date).toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isSelected ? HampiTheme.deepNavy : HampiTheme.warmIvory.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${date.day}',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: isSelected ? HampiTheme.deepNavy : HampiTheme.warmIvory,
                            fontSize: 22,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('E').format(date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isSelected ? HampiTheme.deepNavy : HampiTheme.warmIvory.withOpacity(0.6),
                            fontSize: 10,
                          ),
                    ),
                  ],
                ),
              ).animate(target: isSelected ? 1 : 0).scale(
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.05, 1.05),
                    curve: Curves.easeOut,
                  ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 20,
            color: HampiTheme.deepNavy,
          ),
    );
  }

  Widget _buildRoomManagementCard(
    BuildContext context, {
    required String roomType,
    required double price,
    required int available,
    required bool isBlocked,
    required PricingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: HampiTheme.sandstone.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HampiTheme.deepNavy.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Header: Room Type & Status
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roomType,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
                ),
                Switch(
                  value: !isBlocked,
                  onChanged: (val) => controller.toggleBlockStatus(roomType),
                  activeColor: HampiTheme.mutedGold,
                  activeTrackColor: HampiTheme.mutedGold.withOpacity(0.3),
                  inactiveThumbColor: HampiTheme.deepNavy.withOpacity(0.4),
                  inactiveTrackColor: HampiTheme.deepNavy.withOpacity(0.1),
                ),
              ],
            ),
          ),
          
          Divider(height: 1, color: HampiTheme.deepNavy.withOpacity(0.1)),
          
          // Controls: Price and Inventory
          Padding(
            padding: const EdgeInsets.all(20),
            child: Opacity(
              opacity: isBlocked ? 0.5 : 1.0,
              child: Row(
                children: [
                  // Pricing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nightly Rate',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: HampiTheme.deepNavy.withOpacity(0.6),
                              ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: isBlocked ? null : () => _showEditPriceDialog(context, roomType, price, controller),
                          child: Row(
                            children: [
                              Text(
                                '₹${price.toInt()}',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      color: HampiTheme.mutedGold,
                                      fontSize: 22,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit, size: 16, color: HampiTheme.mutedGold),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Inventory
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Available Rooms',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: HampiTheme.deepNavy.withOpacity(0.6),
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildCounterButton(
                              icon: Icons.remove,
                              onPressed: (isBlocked || available <= 0)
                                  ? null
                                  : () => controller.updateAvailability(roomType, available - 1),
                            ),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text(
                                '$available',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 22),
                              ),
                            ),
                            _buildCounterButton(
                              icon: Icons.add,
                              onPressed: isBlocked
                                  ? null
                                  : () => controller.updateAvailability(roomType, available + 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (available == 0 && !isBlocked)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: HampiTheme.clayRed,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Text(
                'SOLD OUT',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: HampiTheme.warmIvory,
                      letterSpacing: 2,
                    ),
              ),
            ).animate().fadeIn(),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildCounterButton({required IconData icon, required VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: onPressed == null ? Colors.transparent : HampiTheme.warmIvory,
          shape: BoxShape.circle,
          border: Border.all(
            color: onPressed == null ? HampiTheme.deepNavy.withOpacity(0.1) : HampiTheme.mutedGold.withOpacity(0.5),
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onPressed == null ? HampiTheme.deepNavy.withOpacity(0.3) : HampiTheme.deepNavy,
        ),
      ),
    );
  }

  Widget _buildBulkActionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HampiTheme.deepNavy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flash_on, color: HampiTheme.mutedGold),
              const SizedBox(width: 12),
              Text(
                'Bulk Actions',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: HampiTheme.warmIvory,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Apply seasonal pricing or block out dates for multiple days at once.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: HampiTheme.warmIvory.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HampiTheme.mutedGold,
                foregroundColor: HampiTheme.deepNavy,
              ),
              onPressed: () {},
              child: const Text('SETUP SEASONAL RULES'),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  void _showEditPriceDialog(BuildContext context, String roomType, double currentPrice, PricingController controller) {
    // A simple mock dialog for editing price.
    // In a full app, this would use a TextEditingController.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: HampiTheme.warmIvory,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            'Edit Price',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          content: Text(
            'Change price for $roomType.\n(Mock Dialog - Increases price by ₹1,000 for demo)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: HampiTheme.deepNavy)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: HampiTheme.mutedGold),
              onPressed: () {
                controller.updatePrice(roomType, currentPrice + 1000);
                Navigator.pop(context);
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }
}
