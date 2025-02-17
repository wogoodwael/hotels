import 'package:flights/features/Hotels/home/data/models/slider_model/slider_model.dart';
import 'package:flights/features/Hotels/home/data/repo/slider_repo.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  final SliderRepo sliderRepo;
  Rx<SliderModel?> sliders = Rx(null);
  RxBool isLoading = RxBool(false);
  RxString error = RxString("");

  SliderController({required this.sliderRepo});

  Future<void> getSlider() async {
    isLoading.value = true;
    try {
      final sliderRes = await sliderRepo.getSlider();
      sliders.value = sliderRes;
      error.value = "";
    } catch (e) {
      error.value = "$e";
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSlider();
  }
}
