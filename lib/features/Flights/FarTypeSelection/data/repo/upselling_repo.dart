import 'package:flights/features/Flights/FarTypeSelection/data/api/upselling_api.dart';
import 'package:flights/features/Flights/FarTypeSelection/data/models/upselling_model.dart';

class UpsellingRepo {
  final UpsellingApi upsellingApi;

  UpsellingRepo({required this.upsellingApi});

  Future<UpsellingResponse> getUpsellingData(
      Map<String, dynamic> flightOffer, int offerId) async {
    return upsellingApi.getUpsellingData(flightOffer, offerId);
  }
}
