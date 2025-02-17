import 'package:flights/features/Hotels/home/data/api/slider_api.dart';
import 'package:flights/features/Hotels/home/data/models/slider_model/slider_model.dart';

class SliderRepo {
  final SliderApi sliderApi;

  SliderRepo({required this.sliderApi});
  Future<SliderModel> getSlider() async {
    try {
      final res = await sliderApi.getSliders();
      return res;
    } catch (e) {
      throw Exception("Failed to load sliders $e");
    }
  }
}
