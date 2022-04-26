import 'package:flutter/material.dart';
import 'package:movie_catalog/screens/catalog-screen.dart';
import 'package:movie_catalog/screens/movie-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: CatalogScreen.id, routes: {
      CatalogScreen.id: (context) => CatalogScreen(),
      MovieScreen.id: (context) => MovieScreen(),
    });
  }
}
