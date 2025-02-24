import 'package:flights/features/Flights/FarTypeSelection/data/api/upselling_api.dart';
import 'package:flights/features/Flights/FarTypeSelection/data/repo/upselling_repo.dart';
import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';
import 'package:flights/features/Flights/offers/data/api/offers_api.dart';
import 'package:flights/features/Flights/offers/data/repo/offers_repo.dart';
import 'package:flights/features/Flights/offers/domain/offers_controller.dart';
import 'package:flights/features/Flights/search_flight/data/api/nearest_api.dart';
import 'package:flights/features/Flights/search_flight/data/api/search_city_name.dart';
import 'package:flights/features/Flights/search_flight/data/repo/nearest_repo.dart';
import 'package:flights/features/Flights/search_flight/data/repo/search_city_name_repo.dart';
import 'package:flights/features/Flights/search_flight/domain/search_city_name_controller.dart';
import 'package:flights/features/Flights/traveler_details/data/api/order_api.dart';
import 'package:flights/features/Flights/traveler_details/data/api/price_api.dart';
import 'package:flights/features/Flights/traveler_details/data/repo/order_repo.dart';
import 'package:flights/features/Flights/traveler_details/data/repo/price_repo.dart';
import 'package:flights/features/Flights/traveler_details/domain/order-controller.dart';
import 'package:flights/features/Flights/traveler_details/domain/price_controller.dart';
import 'package:flights/features/Hotels/home/data/api/slider_api.dart';
import 'package:flights/features/Hotels/home/data/repo/slider_repo.dart';
import 'package:flights/features/Hotels/home/domain/slider_controller.dart';
import 'package:flights/features/Hotels/hotelsOffers/data/api/hotel_offers_api.dart';
import 'package:flights/features/Hotels/hotelsOffers/data/repo/hotel_offer_repo.dart';
import 'package:flights/features/Hotels/hotelsOffers/domain/hotels_offer_controller.dart';
import 'package:flights/features/Hotels/searchHotel/data/api/nearest_hotels_api.dart';
import 'package:flights/features/Hotels/searchHotel/data/api/search_city.dart';
import 'package:flights/features/Hotels/searchHotel/data/repo/nearest_repo.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';
import 'package:get/get.dart';

import '../../features/Flights/search_flight/domain/nearest_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NearestController(nearestRepo: NearestRepo(nearestApi: NearestApi())),
    );
    Get.put(
      SearchCityNameController(
        searchCityNameRepo:
            SearchCityNameRepo(searchCityNameApi: SearchCityNameApi()),
      ),
    );
    Get.put(UpsellingController(
        upsellingRepo: UpsellingRepo(upsellingApi: UpsellingApi())));

    Get.put(PriceController(priceRepo: PriceRepo(priceApi: PriceApi())));
    Get.put(OrderController(orderRepo: OrderRepo(orderApi: OrderApi())));
    Get.put(OffersController(offersRepo: OffersRepo(offersApi: OffersApi())));
    Get.put(NearestHotelsController(
        nearestHotelsRepo: NearestHotelsRepo(
            nearestHotelsApi: NearestHotelsApi(),
            searchCityApi: SearchCityApi())));
    Get.put(HotelsOfferController(
        hotelsOfferRepo: HotelsOfferRepo(hotelsOfferApi: HotelOffersApi())));
    Get.put(SliderController(sliderRepo: SliderRepo(sliderApi: SliderApi())));
  }
}
