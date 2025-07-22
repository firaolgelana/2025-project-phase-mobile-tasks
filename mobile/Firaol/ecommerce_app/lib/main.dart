import 'package:flutter/material.dart';
import 'screens/add_page.dart';
import 'screens/details_page.dart';
import 'screens/home_page.dart';
import 'screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/home',
      routes: {
        '/add': (context) => const AddPage(),
        '/details': (context) => const DetailsPage(),
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
