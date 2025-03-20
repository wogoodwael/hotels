import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final currentIndex = 0.obs;

  void updateCurrentIndex(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(currentIndex, (value) => print("Current index updated to: $value"));
  }
}
