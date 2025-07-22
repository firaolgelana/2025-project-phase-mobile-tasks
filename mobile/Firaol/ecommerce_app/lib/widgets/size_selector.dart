import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSize = 41;
  List<int> sizes = [39, 40, 41, 42, 43, 44];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size: ', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 24),
        Wrap(
          spacing: 12,
          children: sizes.map((size) {
            bool isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF3F47FD) : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(size.toString()),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
