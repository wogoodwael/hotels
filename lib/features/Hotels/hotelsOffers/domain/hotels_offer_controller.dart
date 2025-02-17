import 'package:get/get.dart';
import '../data/models/hotel_offers_model.dart';
import '../data/repo/hotel_offer_repo.dart';

class HotelsOfferController extends GetxController {
  final HotelsOfferRepo hotelsOfferRepo;

  HotelsOfferController({required this.hotelsOfferRepo});

  final Rx<HotelOffersModel?> hotelOffers = Rx<HotelOffersModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> getHotelOffers({
    required String hotelId,
    required int adults,
    required String checkInDate,
    required String checkOutDate,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await hotelsOfferRepo.getHotelOffers(
        hotelId: hotelId,
        adults: adults,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
      );

      if (result.data.data.isEmpty && result.errors.isNotEmpty) {
        final errorDetail = result.errors.first;
        error.value = '${errorDetail.title}: ${errorDetail.detail}';
        return;
      }

      hotelOffers.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
