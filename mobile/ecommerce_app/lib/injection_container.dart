import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'core/utils/api_client_helper.dart';
import 'features/products/data/datasources/product_local_data_source.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/create_product.dart';
import 'features/products/domain/usecases/delete_product.dart';
import 'features/products/domain/usecases/update_product.dart';
import 'features/products/domain/usecases/view_all_products.dart';
import 'features/products/domain/usecases/view_specific_product.dart';
import 'features/products/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async{
  sl.registerFactory(() => ProductBloc(
    createProduct: sl(),
    updateProduct: sl(),
    deleteProduct: sl(),
    viewAllProducts: sl(),
    viewSpecificProduct: sl(),
  ));

  //usecase
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl())); 
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));

  //repository

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
  remoteDataSource: sl(),  
  localDataSource: sl(),
  networkInfo: sl(),
  ));

  //datasource

  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImp(
    sharedPreferences: sl(),

  ));
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImp(
    apiHelper: sl(),
  ));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClientHelper(sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());


}