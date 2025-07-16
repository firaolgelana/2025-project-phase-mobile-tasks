import 'Product.dart';

class ProductManager {
  List<Product> products = [];
  void addProduct(String name, String description, double price) {
    products.add(Product(name, description, price));
    print('Product added successfully');
  }

  void viewAllProducts() {
    if (products.isEmpty) {
      print("No products available.");
      return;
    }
    for (int i = 0; i < products.length; i++) {
      print("Product #${i + 1}");
      print(products[i]);
    }
  }

  void viewSingleProduct(int index) {
    if (index < 0 || index >= products.length) {
      print("Invalid product index.");
      return;
    }
    print(products[index]);
  }

  void editProduct(int index, String name, String desc, double price) {
    if (index < 0 || index >= products.length) {
      print("Invalid product index.");
      return;
    }
    products[index].name = name;
    products[index].description = desc;
    products[index].price = price;
    print('products updated successfully');
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= products.length) {
      print("Invalid product index.");
      return;
    }
    products.removeAt(index);
    print('products deleted successfully');
  }

  int get productCount => products.length;
}
