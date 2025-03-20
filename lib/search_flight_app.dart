import 'package:flights/utils/bindings/initial_bindings.dart';
import 'package:flights/utils/local/local.dart';
import 'package:flights/utils/local/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/Hotels/home/home.dart';

class SearchFlightsApp extends StatelessWidget {
  
   SearchFlightsApp({super.key});
  @override
  Widget build(BuildContext context) {
      final controller = Get.put(LocalController());

    return GetMaterialApp(
      locale: controller.initialLang,
      translations: MyLocal(),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      home: HomeScreen(),
    );
  }
}
