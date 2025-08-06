import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToAddPage(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add');

    if (result != null && result is Map<String, dynamic>) {
      // Trigger re-fetch of products after adding
      if(!context.mounted) return;
      context.read<ProductBloc>().add(const LoadAllProductEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is LoadedAllProductState) {
            final products = state.products;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'July 14, 2023',
                              style: TextStyle(color: Colors.grey),
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Hello, ',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: 'Yohannes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(
                                Icons.notifications_none,
                                size: 28,
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 12,
                              child: Container(
                                width: 7,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Section Title
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Available Products',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/search');
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product List
                  Column(
                    children: products.asMap().entries.map((entry) {
                      final product = entry.value;

                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: {
                              'product': product,
                              'id': product.id,
                              'products': products,
                            },
                          );

                          if (result != null && result is Map<String, dynamic>) {
                            final action = result['action'] as String?;

                            if (action == 'delete' || action == 'update') {
                              // Re-fetch after update or delete
                              if(!context.mounted) return;
                              context.read<ProductBloc>().add(const LoadAllProductEvent());
                            }
                          }
                        },
                        child: Component(
                          id: product.id,
                          name: product.name,
                          description: product.description,
                          imageUrl: product.imageUrl,
                          price: product.price,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }

          // Default fallback
          return const Center(child: Text('No products available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPage(context),
        backgroundColor: Colors.blue,
        shape: const CircleBorder(side: BorderSide(color: Colors.blue, width: 2)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
