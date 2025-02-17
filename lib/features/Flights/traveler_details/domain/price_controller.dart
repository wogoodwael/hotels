import 'package:get/get.dart';

import '../data/models/pricing_model.dart';
import '../data/repo/price_repo.dart';

class PriceController extends GetxController {
  final PriceRepo priceRepo;
  RxBool isLoading = false.obs;
  Rxn<PricingModel> pricingModel = Rxn<PricingModel>();
  Rxn<String> errorMessage = Rxn<String>();

  PriceController({required this.priceRepo});

  Future<void> getPrice(Map<String, dynamic> flightOffer) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      pricingModel.value = await priceRepo.getPrice(flightOffer);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
