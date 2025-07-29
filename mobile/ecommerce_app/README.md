#  Flutter eCommerce App (Clean Architecture)

A modular and testable eCommerce Flutter app built with **Clean Architecture**, **Mockito**, and **Dartz**, following best practices for scalability, separation of concerns, and maintainability.

---

##  Architecture Overview

This project follows the **Clean Architecture** pattern to divide responsibilities and ensure testability:

###  Layers


- **Domain Layer**  
  Business logic, entities, repository interfaces, and use cases.

- **Data Layer**  
  Data models, API/database implementations, and data source logic.

- **Core Layer**  
  Common/shared code across the app, like constants and error handling.

---

## 📁 Project Structure

```bash
lib
┣ 📂core
┃ ┗ 📂error
┃   ┗ 📜failure.dart
┣ 📂features
┃ ┗ 📂products
┃   ┣ 📂data
┃   ┃ ┗ 📂models
┃   ┃   ┗ 📜product_model.dart
┃   ┗ 📂domain
┃     ┣ 📂entities
┃     ┃ ┗ 📜product.dart
┃     ┣ 📂repositories
┃     ┃ ┗ 📜product_repository.dart
┃     ┗ 📂usecases
┃       ┣ 📜create_product.dart
┃       ┣ 📜delete_product.dart
┃       ┣ 📜update_product.dart
┃       ┣ 📜view_all_products.dart
┃       ┗ 📜view_specific_product.dart
┗ 📜main.dart
```

```bash
test
┣ 📂core
┣ 📂features
┃ ┗ 📂products
┃   ┣ 📂data
┃   ┃ ┗ 📂models
┃   ┃   ┗ 📜product_model_test.dart
┃   ┗ 📂domain
┃     ┗ 📂usecases
┃       ┣ 📜create_product_test.dart
┃       ┣ 📜delete_product_test.dart
┃       ┣ 📜update_product_test.dart
┃       ┣ 📜view_all_products_test.dart
┃       ┗ 📜view_product_test.dart

┗ 📜widget_test.dart

```
