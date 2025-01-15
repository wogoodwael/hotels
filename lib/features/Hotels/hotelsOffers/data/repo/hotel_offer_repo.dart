import '../api/hotel_offers_api.dart';
import '../models/hotel_offers_model.dart';

class HotelsOfferRepo {
  final HotelOffersApi hotelsOfferApi;

  HotelsOfferRepo({required this.hotelsOfferApi});
  Future<HotelOffersModel> getHotelOffers(
      {required String hotelId,
      required int adults,
      required String checkInDate,
      required String checkOutDate}) async {
    return await hotelsOfferApi.getHotelOffers(
        hotelId: hotelId,
        adults: adults,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate);
  }
}
