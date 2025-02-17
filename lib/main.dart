import 'package:flights/features/Hotels/home/data/api/slider_api.dart';
import 'package:flights/features/Hotels/home/data/repo/slider_repo.dart';
import 'package:flights/features/Hotels/home/domain/slider_controller.dart';
import 'package:flights/features/Hotels/hotelsOffers/domain/hotels_offer_controller.dart';
import 'package:flights/features/Hotels/searchHotel/data/api/nearest_hotels_api.dart';
import 'package:flights/features/Hotels/searchHotel/data/api/search_city.dart';
import 'package:flights/features/Hotels/searchHotel/data/repo/nearest_repo.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';
import 'package:flights/search_flight_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import 'features/Flights/FarTypeSelection/data/api/upselling_api.dart';
import 'features/Flights/FarTypeSelection/data/repo/upselling_repo.dart';
import 'features/Flights/FarTypeSelection/domain/upselling_controller.dart';

import 'features/Flights/offers/data/api/offers_api.dart';
import 'features/Flights/offers/data/repo/offers_repo.dart';
import 'features/Flights/offers/domain/offers_controller.dart';
import 'features/Flights/traveler_details/data/api/order_api.dart';
import 'features/Flights/traveler_details/data/api/price_api.dart';
import 'features/Flights/traveler_details/data/repo/order_repo.dart';
import 'features/Flights/traveler_details/data/repo/price_repo.dart';
import 'features/Flights/traveler_details/domain/order-controller.dart';
import 'features/Flights/traveler_details/domain/price_controller.dart';
import 'features/Hotels/hotelsOffers/data/api/hotel_offers_api.dart';
import 'features/Hotels/hotelsOffers/data/repo/hotel_offer_repo.dart';

late final UpsellingController upsellingController;
late final PriceController priceController;
late final OrderController orderController;
late final OffersController offersController;
late final NearestHotelsController nearestHotelsController;
late final HotelsOfferController hotelsOfferController;
late final SliderController sliderController;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('flightData');
  await Hive.openBox('travelerDetails');
  await Hive.openBox('hotelData');

  upsellingController = Get.put(UpsellingController(
      upsellingRepo: UpsellingRepo(upsellingApi: UpsellingApi())));
  priceController =
      Get.put(PriceController(priceRepo: PriceRepo(priceApi: PriceApi())));
  orderController =
      Get.put(OrderController(orderRepo: OrderRepo(orderApi: OrderApi())));
  offersController =
      Get.put(OffersController(offersRepo: OffersRepo(offersApi: OffersApi())));
  nearestHotelsController = Get.put(NearestHotelsController(
      nearestHotelsRepo: NearestHotelsRepo(
          nearestHotelsApi: NearestHotelsApi(),
          searchCityApi: SearchCityApi())));
  hotelsOfferController = Get.put(HotelsOfferController(
      hotelsOfferRepo: HotelsOfferRepo(hotelsOfferApi: HotelOffersApi())));
  sliderController =
      Get.put(SliderController(sliderRepo: SliderRepo(sliderApi: SliderApi())));

  runApp(const SearchFlightsApp());
}
