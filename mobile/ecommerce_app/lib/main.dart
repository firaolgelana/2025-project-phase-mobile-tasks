import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/pages/add_page.dart';
import 'features/products/presentation/pages/details_page.dart';
import 'features/products/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => di.sl<ProductBloc>()..add(const LoadAllProductEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Product App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/add': (context) => const AddPage(),
          '/details': (context) => const DetailsPage(),
        },
      ),
    );
  }
}
