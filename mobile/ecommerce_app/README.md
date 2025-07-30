# Ecommerce Flutter App — Clean Architecture
This project is a sample Ecommerce app built using Flutter and structured following Clean Architecture principles. It demonstrates how to organize your codebase with:

Contracts (Abstract classes/interfaces)

Repository pattern

Local & Remote Data Sources

Dependency Inversion

Network connection checking

## Architecture Layers
### domain/
Defines the contracts and business logic.

entities/ – Plain Dart classes for your core objects (Product).

repositories/ – Abstract class (contract) defining the required repository methods.

usecases/ – Classes for business rules (e.g., GetAllProductsUseCase).

### data/
Contains data sources, models, and the implementation of the repository.

datasources/

remote_product_data_source.dart – Fetches data from APIs.

local_product_data_source.dart – Fetches/saves data locally.

models/ – DTOs used for JSON conversion.

repositories/ – Implements the contract using data sources.

### core/
platform/

network_info.dart – Checks internet connection.

error/

exceptions.dart, failures.dart – Error handling helpers.
