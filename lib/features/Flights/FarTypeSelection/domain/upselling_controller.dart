import 'package:get/get.dart';
import 'package:flights/features/Flights/FarTypeSelection/data/repo/upselling_repo.dart';
import 'package:flights/features/Flights/FarTypeSelection/data/models/upselling_model.dart';

class UpsellingController extends GetxController {
  final UpsellingRepo upsellingRepo;

  UpsellingController({required this.upsellingRepo});

  var upsellingResponse = UpsellingResponse().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchUpsellingData(
      Map<String, dynamic> flightOffer, int offerId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      upsellingResponse.value =
          await upsellingRepo.getUpsellingData(flightOffer, offerId);
      print(upsellingResponse.value.data);
    } catch (e) {
      if (e.toString().contains("No upsell offer")) {
        errorMessage.value = "No upsell offers available for this flight.";
      } else if (e.toString().contains("Network")) {
        errorMessage.value = "Network error. Please check your connection.";
      } else {
        errorMessage.value = "Unable to retrieve upsell offer: ${e.toString()}";
      }
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
