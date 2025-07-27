import 'package:ecommerce_app/widgets/image_uploader.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedImagePath;
  Product? editingProduct;
  int? editingIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    if (args != null && args['product'] != null) {
      editingProduct = args['product'] as Product;
      editingIndex = args['index'] as int?;

      nameController.text = editingProduct!.name;
      categoryController.text = editingProduct!.category;
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
        title: Center(child: Text('Add Product')),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFF3F47FD),
          iconSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageUploader(
                onImageSelected: (path) {
                  selectedImagePath = path;
                },
              ),

              Text('name'),
              TextField(
                controller: nameController,
                decoration: inputDecoration,
              ),
              Text('catagory'),
              TextField(
                controller: categoryController,
                decoration: inputDecoration,
              ),
              Text('price'),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration,
              ),

              Text('description'),
              TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: inputDecoration,
              ),
              SizedBox(height: 6),
              Center(
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final product = Product(
                            name: nameController.text,
                            category: categoryController.text,
                            price: double.tryParse(priceController.text) ?? 0.0,
                            description: descriptionController.text,
                            imagePath: selectedImagePath == null
                                ? 'images/shoes.jpg'
                                : selectedImagePath!,
                          );
                          Navigator.pop(context, {
                            'product': product,
                            'index': editingIndex,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3F47FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          editingProduct != null ? 'UPDATE' : 'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text(
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
