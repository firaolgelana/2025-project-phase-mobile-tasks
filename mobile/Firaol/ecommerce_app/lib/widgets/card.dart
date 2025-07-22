import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  const Component({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // Add padding inside the card
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // Outer spacing if needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Shadow color
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // X, Y offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'images/shoes.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Derby Leather Shoes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('\$120', style: TextStyle(color: Colors.black)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Text("Men's Shoe", style: TextStyle(color: Colors.grey)),
              Spacer(),
              Icon(Icons.star, color: Colors.orangeAccent, size: 18),
              SizedBox(width: 4),
              Text('(4.0)', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
