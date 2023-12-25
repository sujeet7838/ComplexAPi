import 'package:flutter/material.dart';
import 'package:flutter_project_structure/features/category_page.dart';
import 'package:flutter_project_structure/features/combo_categ.dart';
import 'package:flutter_project_structure/features/home_page.dart';
import 'package:flutter_project_structure/features/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Rest Api Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: Scaffold(
          appBar: AppBar(
              // title: const Text("API Test Demo"),
              ),
          body: const ComboCategory(),
          //onst CategoryPage(),
          //const UserPage(),
          //const HomePage(),
        ));
  }
}
