import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      getPages: [
        GetPage(name: '/home', page: () => MyHomePage()),
      ],
      initialRoute: '/home',
    );
  }
}
