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
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    late Widget Function(
      BuildContext,
      Animation<double>,
      Animation<double>,
      Widget,
    )
    transition;
    Duration duration = const Duration(milliseconds: 1000); 
    switch (settings.name) {
      case '/':
        page = const HomePage();
        transition = (context, animation, _, child) {
          const begin = Offset(-1.0, 0.0); 
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        };
        break;

      case '/add':
        page = const AddPage();
        transition = (context, animation, _, child) {
          const begin = Offset(0.0, 1.0); 
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        };
        break;

      case '/details':
        page = const DetailsPage();
        transition = (context, animation, _, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          ); 
        };
        break;

      case '/search':
        page = const SearchPage();
        transition = (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        };
        break;

      default:
        page = const HomePage();
        transition = (context, animation, _, child) => child;
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionDuration: duration,
      transitionsBuilder: transition,
    );
  }
}
