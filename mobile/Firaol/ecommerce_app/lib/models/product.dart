
class Product {
  String name;
  String category;
  String description;
  double price;
  double rating;
  String imagePath;
  int size;
  Product({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.rating = 4.0,
    this.imagePath = 'images/shoes.jpg',
    this.size = 41,
  });
}
