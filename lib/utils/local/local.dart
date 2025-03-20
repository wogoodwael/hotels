import 'package:flights/utils/constants/arabic.dart';
import 'package:flights/utils/constants/english.dart';
import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar":arabicMap,
        "en": englishMap
      };
}
