import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(
      name: "Derby Leather Shoes",
      category: "Men's shoe",
      description: "description.....",
      price: 120,
      rating: 4.0,
      imagePath: 'images/shoes.jpg',
      size: 41,
    ),
  ];
void _navigateToAddPage() async {
  final result = await Navigator.pushNamed(context, '/add');

  if (result != null && result is Map<String, dynamic>) {
    final newProduct = result['product'];
    final index = result['index'];

    if (newProduct != null && newProduct is Product) {
      setState(() {
        if (index == null) {
          products.add(newProduct);
        } else {
          products[index] = newProduct;
        }
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.only(top: 24, bottom: 8),
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
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'July 14, 2023',
                        style: TextStyle(color: Colors.grey),
                      ),
                      RichText(
                        text: TextSpan(
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
                  Spacer(),
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
                        child: Icon(
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
                          decoration: BoxDecoration(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: products.asMap().entries.map((entry) {
                final index = entry.key;
                final product = entry.value;

                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: {
                        'product': products[index],
                        'index': index,
                        'products': products,
                      },
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      final updatedProducts = result['products'] as List<Product>?;
                      final action = result['action'] as String?;

                      if (updatedProducts != null && (action == 'delete' || action == 'update')) {
                        setState(() {
                          products = updatedProducts;
                        });
                      }
                    }

                  },
                  child: Component(
                    name: product.name,
                    category: product.category,
                    imagePath: product.imagePath,
                    rating: product.rating,
                    price: product.price,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddPage();
        },
        backgroundColor: Colors.blue,
        shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 2)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
