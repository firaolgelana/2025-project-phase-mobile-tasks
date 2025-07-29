# Domain Layer – eCommerce App
Designing the domain layer for an eCommerce mobile app using Clean Architecture and Test-Driven Development (TDD) principles.

This layer is independent of any framework or external library and focuses purely on business logic and application rules.

## Features / Use Cases
Each use case is implemented as a callable class. These use cases interact only with abstract repositories and return either domain entities or results.

### InsertProduct
- Adds a new product to the app.

- Accepts a Product entity as input.

- Interacts with the ProductRepository.

### UpdateProduct
- Updates an existing product's details.

- Requires a full Product entity with an existing ID.

- Interacts with the ProductRepository.

### DeleteProduct
- Deletes a product from the list.

- Accepts a int ID to identify the product.

- Interacts with the ProductRepository.

### GetProduct
- Retrieves details of a specific product.

- Accepts a int ID.

- Returns a Product entity if found.

