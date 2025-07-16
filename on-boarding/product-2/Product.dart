class Product {
  String name;
  String description;
  double price;
  Product(this.name, this.description, this.price);
  @override
  String toString() {
    return "name: $name,\ndescription: $description,\nprice: $price";
  }
}