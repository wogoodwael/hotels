import 'package:flights/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale initialLang = sharedPreferences.getString("lang") == null
      ? Get.deviceLocale!
      : Locale(sharedPreferences.getString("lang")!);
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    sharedPreferences.setString("lang", codeLang);
    Get.updateLocale(locale);
    update();
  }
}
