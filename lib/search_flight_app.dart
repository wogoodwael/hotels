import 'package:flights/utils/bindings/initial_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/Hotels/home/home.dart';

class SearchFlightsApp extends StatelessWidget {
  const SearchFlightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      home: HomeScreen(),
    );
  }
}
