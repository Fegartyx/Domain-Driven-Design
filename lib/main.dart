import 'package:domain_driven_design/presentation/ui/home/home_page.dart';
import 'package:domain_driven_design/presentation/ui/search/search_page.dart';
import 'package:domain_driven_design/presentation/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/search': (context) => const SearchPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
