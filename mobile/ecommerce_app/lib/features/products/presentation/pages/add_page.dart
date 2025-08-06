import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/image_uploader.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? selectedImagePath;
  Product? editingProduct;
  String? editingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    if (args != null && args['product'] != null) {
      editingProduct = args['product'] as Product;
      editingId = args['id'] as String?;

      idController.text = editingProduct!.id;
      nameController.text = editingProduct!.name;
      priceController.text = editingProduct!.price.toString();
      descriptionController.text = editingProduct!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      filled: true,
      fillColor: Color(0xFFF2F2F2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('Add Product')),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color(0xFF3F47FD),
          iconSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageUploader(
                onImageSelected: (path) {
                  selectedImagePath = path;
                },
              ),

              const Text('id'),
              TextField(controller: idController, decoration: inputDecoration),
              const Text('name'),
              TextField(
                controller: nameController,
                decoration: inputDecoration,
              ),

              const Text('description'),
              TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: inputDecoration,
              ),
              const Text('price'),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration,
              ),
              const SizedBox(height: 6),
              Center(
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final product = Product(
                            id: nameController.text,
                            name: nameController.text,
                            description: descriptionController.text,
                            price: double.tryParse(priceController.text) ?? 0.0,
                            imageUrl: selectedImagePath!,
                          );
                          Navigator.pop(context, {
                            'product': product,
                            'id': editingId,
                          });
                          if (editingProduct != null) {
                            context.read<ProductBloc>().add(
                              UpdateProductEvent(product, idController.text),
                            );
                          } else {
                            context.read<ProductBloc>().add(
                              CreateProductEvent(product),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F47FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          editingProduct != null ? 'UPDATE' : 'ADD',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
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
