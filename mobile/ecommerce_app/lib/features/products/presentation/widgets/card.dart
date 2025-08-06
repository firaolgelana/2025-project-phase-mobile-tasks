import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  final String id, name, imageUrl, description;
  final double price;
  const Component({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
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
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: buildProductImage(imageUrl),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('\$$price', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
