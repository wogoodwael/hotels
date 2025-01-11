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

late final UpsellingController upsellingController;
late final PriceController priceController;
late final OrderController orderController; 
late final OffersController offersController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('flightData');
  await Hive.openBox('travelerDetails');

  upsellingController = Get.put(UpsellingController(
    upsellingRepo: UpsellingRepo(upsellingApi: UpsellingApi())));
  priceController = Get.put(PriceController(
    priceRepo: PriceRepo(priceApi: PriceApi())));
  orderController = Get.put(OrderController(
    orderRepo: OrderRepo(orderApi: OrderApi())));
  offersController = Get.put(OffersController(
    offersRepo: OffersRepo(offersApi: OffersApi())));

  runApp(const SearchFlightsApp());
}
