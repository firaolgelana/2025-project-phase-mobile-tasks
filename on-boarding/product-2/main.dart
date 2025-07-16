import 'ProductManager.dart';
import 'dart:io';

void main() {
  ProductManager manager = ProductManager();

  while (true) {
    print('''
    ========= eCommerce App =========
    1. Add Product
    2. View All Products
    3. View Single Product
    4. Edit Product
    5. Delete Product
    6. Exit
    ''');
    var out = stdout.write;
    out('choose an option: ');
    String? choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        out("Enter product name: ");
        String? name = stdin.readLineSync();
        out("Enter description: ");
        String? desc = stdin.readLineSync();
        out("Enter price: ");
        double? price = double.tryParse(stdin.readLineSync() ?? '');
        if (name != null && desc != null && price != null) {
          manager.addProduct(name, desc, price);
        } else {
          print("Invalid input!");
        }
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        out("Enter product index (1-${manager.productCount}): ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          manager.viewSingleProduct(index - 1);
        } else {
          print("Invalid input!");
        }
        break;

      case '4':
        out("Enter product index to edit (1-${manager.productCount}): ");
        int? idx = int.tryParse(stdin.readLineSync() ?? '');
        if (idx != null) {
          out("Enter new name: ");
          String? newName = stdin.readLineSync();
          out("Enter new description: ");
          String? newDesc = stdin.readLineSync();
          out("Enter new price: ");
          double? newPrice = double.tryParse(stdin.readLineSync() ?? '');
          if (newName != null && newDesc != null && newPrice != null) {
            manager.editProduct(idx - 1, newName, newDesc, newPrice);
          } else {
            print("Invalid input!");
          }
        }
        break;

      case '5':
        out("Enter product index to delete (1-${manager.productCount}): ");
        int? delIdx = int.tryParse(stdin.readLineSync() ?? '');
        if (delIdx != null) {
          manager.deleteProduct(delIdx - 1);
        } else {
          print("Invalid input!");
        }
        break;

      case '6':
        print("Exiting application...");
        return;

      default:
        print("Invalid choice. Try again.");
    }
  }
}
