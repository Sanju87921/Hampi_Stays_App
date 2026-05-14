import 'package:flutter/material.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

class OwnerOnboardingScreen extends StatefulWidget {
  const OwnerOnboardingScreen({super.key});

  @override
  State<OwnerOnboardingScreen> createState() => _OwnerOnboardingScreenState();
}

class _OwnerOnboardingScreenState extends State<OwnerOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 6) {
      _pageController.nextPage(duration: const Duration(milliseconds: 600), curve: HampiTheme.luxuryCurve);
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 600), curve: HampiTheme.luxuryCurve);
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HampiTheme.warmIvory,
      appBar: AppBar(
        title: Text(
          'Register Property',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentStep > 0 
          ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: _previousStep)
          : null,
      ),
      body: Column(
        children: [
          // 📏 Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / 7,
              backgroundColor: HampiTheme.sandstone,
              valueColor: const AlwaysStoppedAnimation<Color>(HampiTheme.mutedGold),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep(context, 'Basic Details', 'Enter your property name and location.', [
                  _buildTextField(context, 'Property Name', 'e.g. Hampi Heritage Resort'),
                  _buildTextField(context, 'Exact Location', 'e.g. Near Virupaksha Temple'),
                  _buildTextField(context, 'Contact Email', 'e.g. owner@hampi.com'),
                ]),
                _buildStep(context, 'Media Gallery', 'Upload high-resolution photos of your sanctuary.', [
                  _buildMediaPlaceholder(context),
                ]),
                _buildStep(context, 'Amenities', 'Select the luxury offerings at your property.', [
                  _buildAmenitiesGrid(context),
                ]),
                _buildStep(context, 'Room Inventory', 'Define your available room types and pricing.', [
                  _buildTextField(context, 'Room Type Name', 'e.g. Heritage Suite'),
                  _buildTextField(context, 'Price per Night (₹)', 'e.g. 42000'),
                ]),
                _buildStep(context, 'House Rules', 'Set the policies for your guests.', [
                  _buildTextField(context, 'Check-in Time', 'e.g. 12:00 PM'),
                  _buildTextField(context, 'Check-out Time', 'e.g. 10:00 AM'),
                ]),
                _buildStep(context, 'Verify Documents', 'Upload legal ownership and identity proofs.', [
                  _buildTextField(context, 'GST Number', 'Enter GSTIN'),
                  _buildMediaPlaceholder(context, label: 'Upload ID Proof'),
                ]),
                _buildStep(context, 'Final Review', 'Verify your details before submitting for approval.', [
                  const Text('All details look perfect. Your property will be verified by our team within 24 hours.'),
                ]),
              ],
            ),
          ),

          // 🔘 Action Buttons
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _currentStep == 6 ? () => Navigator.pop(context) : _nextStep,
                child: Text(_currentStep == 6 ? 'SUBMIT FOR APPROVAL' : 'SAVE & CONTINUE'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String title, String description, List<Widget> children) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
          const SizedBox(height: 8),
          Text(description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: HampiTheme.deepNavy.withOpacity(0.6))),
          const SizedBox(height: 40),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildMediaPlaceholder(BuildContext context, {String label = 'Upload Photos'}) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: HampiTheme.sandstone.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HampiTheme.mutedGold, style: BorderStyle.none), // Placeholder for dashed border
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload_outlined, color: HampiTheme.mutedGold, size: 48),
          const SizedBox(height: 12),
          Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: HampiTheme.mutedGold)),
        ],
      ),
    );
  }

  Widget _buildAmenitiesGrid(BuildContext context) {
    final amenities = ['Private Pool', 'Heritage View', 'Spa', 'Fine Dining', 'WiFi', 'Gym'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: amenities.map((a) => FilterChip(
        label: Text(a),
        onSelected: (v) {},
        backgroundColor: HampiTheme.sandstone.withOpacity(0.3),
        selectedColor: HampiTheme.mutedGold.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )).toList(),
    );
  }
}
