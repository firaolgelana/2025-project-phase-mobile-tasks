import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Component extends StatelessWidget {
  final String name, category, imagePath;
  final double rating, price;
  const Component({
    super.key,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.rating,
    required this.price,
  });
  Widget buildProductImage(String imagePath) {
    if (kIsWeb) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      if (imagePath.startsWith('images/')) {
        return Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      } else {
        return Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: buildProductImage(imagePath),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('\$$price', style: TextStyle(color: Colors.black)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(category, style: TextStyle(color: Colors.grey)),
              Spacer(),
              Icon(Icons.star, color: Colors.orangeAccent, size: 18),
              SizedBox(width: 4),
              Text('($rating)', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
