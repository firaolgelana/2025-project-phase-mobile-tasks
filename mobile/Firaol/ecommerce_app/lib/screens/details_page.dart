import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/size_selector.dart';
import '../models/product.dart';
import 'package:flutter/foundation.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final index = args['index'];
    var product = args['product'];
    final products = args['products'];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  buildProductImage(product.imagePath),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF3F47FD),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.category,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.orangeAccent, size: 18),
                        SizedBox(width: 4),
                        Text(
                          '(${product.rating})',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const SizeSelector(),
                    const SizedBox(height: 24),
                    Text(product.description),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              products.removeAt(index);
                              Navigator.pop(context, {
                                'products': products,
                                'action': 'delete',
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product deleted'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'DELETE',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                '/add',
                                arguments: {'product': product, 'index': index},
                              );
                              if (result != null && result is Map) {
                                final updated = result['product'] as Product;
                                final updatedIndex = result['index'] as int;

                                setState(() {
                                  products[updatedIndex] = updated;
                                  product = updated;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context, {
                                  'products': products,
                                  'action': 'update',
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3F47FD),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
    );
  }
}
