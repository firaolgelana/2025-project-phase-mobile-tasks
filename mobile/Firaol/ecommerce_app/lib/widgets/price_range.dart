import 'package:flutter/material.dart';

class PriceRange extends StatefulWidget {
  const PriceRange({super.key});

  @override
  State<PriceRange> createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  RangeValues _currentRangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      min: 0,
      max: 100,
      activeColor: Color(0xFF3F47FD),
      inactiveColor: Colors.grey.shade300,
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
