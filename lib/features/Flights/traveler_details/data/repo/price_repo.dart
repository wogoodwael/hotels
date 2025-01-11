import '../api/price_api.dart';
import '../models/pricing_model.dart';

class PriceRepo {
  final PriceApi priceApi;

  PriceRepo({required this.priceApi});

  Future<PricingModel> getPrice(Map<String, dynamic> flightOffer) async {
    return await priceApi.getPrice(flightOffer);
  }
}
