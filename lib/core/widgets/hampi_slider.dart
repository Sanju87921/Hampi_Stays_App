import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hampi_stays/core/theme/hampi_theme.dart';

class HampiSlider extends StatefulWidget {
  final String text;
  final VoidCallback onCompleted;
  final double width;
  final double height;

  const HampiSlider({
    super.key,
    required this.text,
    required this.onCompleted,
    this.width = 300,
    this.height = 60,
  });

  @override
  State<HampiSlider> createState() => _HampiSliderState();
}

class _HampiSliderState extends State<HampiSlider> with SingleTickerProviderStateMixin {
  double _dragPercentage = 0.0;
  bool _isCompleted = false;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: HampiTheme.luxuryCurve),
    );
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;

    setState(() {
      _dragPercentage += details.primaryDelta! / (widget.width - widget.height);
      _dragPercentage = _dragPercentage.clamp(0.0, 1.0);
    });

    if (_dragPercentage >= 0.95 && !_isCompleted) {
      _isCompleted = true;
      HapticFeedback.lightImpact();
      widget.onCompleted();
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_isCompleted) return;

    _resetAnimation = Tween<double>(
      begin: _dragPercentage,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: HampiTheme.luxuryCurve,
    ));

    _resetController.reset();
    _resetController.forward();
    
    _resetController.addListener(() {
      setState(() {
        _dragPercentage = _resetAnimation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: HampiTheme.warmIvory,
        borderRadius: BorderRadius.circular(widget.height / 2),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 30,
            color: Color(0x1A020617),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Track Text
          Center(
            child: Text(
              widget.text.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: HampiTheme.deepNavy.withOpacity(0.4),
                  ),
            ),
          ),

          // Gradient Fill
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: widget.height + (widget.width - widget.height) * _dragPercentage,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: HampiTheme.luxuryGoldGradient,
                ),
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
          ),

          // Handle
          Positioned(
            left: (widget.width - widget.height) * _dragPercentage,
            child: GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Container(
                width: widget.height,
                height: widget.height,
                decoration: const BoxDecoration(
                  color: HampiTheme.deepNavy,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: HampiTheme.warmIvory,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
