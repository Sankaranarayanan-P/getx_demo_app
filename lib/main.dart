import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo_app/controller/products/product_controller.dart';
import 'package:getx_demo_app/view/home/home_screen.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Get.lazyPut(() => ProductController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
