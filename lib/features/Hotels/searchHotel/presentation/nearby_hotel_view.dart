import 'package:flights/features/Hotels/hotelsOffers/presentation/rooms_view.dart';
import 'package:flights/features/Hotels/searchHotel/presentation/widgets/hotel_card.dart';
import 'package:flights/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../hotelsOffers/domain/hotels_offer_controller.dart';
import 'widgets/properity_type_chip.dart';

class NearByHotelView extends StatefulWidget {
  const NearByHotelView({super.key, required this.isOffers});
  final bool isOffers;

  @override
  State<NearByHotelView> createState() => _NearByHotelViewState();
}

class _NearByHotelViewState extends State<NearByHotelView> {
  String locationName = 'Unknown location';
  final nearestHotelsController = Get.find<NearestHotelsController>();
  DateTime? checkInDate;
  DateTime? checkOutDate;
  final hotelsOfferController = Get.find<HotelsOfferController>();

  @override
  void initState() {
    super.initState();
    String hotelId = Hive.box('hotelData').get('hotelId', defaultValue: '');
    print("Current hotelId: $hotelId");
    print("offers controller: ${hotelsOfferController.error.value}");

    if (widget.isOffers) {
    } else {
      _getLocationName();
    }

    String? checkInString =
        Hive.box('hotelData').get('checkInDate', defaultValue: null);
    String? checkOutString =
        Hive.box('hotelData').get('checkOutDate', defaultValue: null);

    if (checkInString != null) {
      checkInDate = DateTime.parse(checkInString);
    }
    if (checkOutString != null) {
      checkOutDate = DateTime.parse(checkOutString);
    }
  }

  Future<void> _getNearbyHotels() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await nearestHotelsController.getNearestHotels(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 100,
      );
    } catch (e) {
      debugPrint('Error getting nearby hotels: $e');
    }
  }

  Future<void> _getLocationName() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        locationName = placemarks.first.locality ?? 'loading... location';
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isOffers
                  ? Hive.box('hotelData')
                      .get('cityName', defaultValue: locationName)
                  : locationName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      String hotelId = Hive.box('hotelData')
                          .get('hotelId', defaultValue: '');
                      print("Current hotelId: $hotelId");
                    },
                    child: Icon(Icons.person_outline,
                        size: 20, color: Colors.grey[600])),
                const SizedBox(width: 2),
                Text(
                    Hive.box('hotelData')
                        .get('adults', defaultValue: 2)
                        .toString(),
                    style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                const SizedBox(width: 5),
                Text(
                    '${DateFormat('dd MMM').format(checkInDate ?? DateTime.now())} - ${DateFormat('dd MMM').format(checkOutDate ?? DateTime.now())}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: Colors.grey),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.swap_vert_rounded, size: 20)),
                const SizedBox(width: 8),
                Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.tune, size: 20)),
                const SizedBox(width: 4),
                const SizedBox(width: 8),
                Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Property rating'.tr),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20, color: Colors.teal),
                      ],
                    )),
                const SizedBox(width: 8),
                Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Guest rating'.tr),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20, color: Colors.teal),
                      ],
                    )),
              ],
            ),
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                PropertyTypeChip(
                  icon: Icons.house,
                  label: 'Chalet and Istiraha',
                ),
                SizedBox(width: 8),
                PropertyTypeChip(
                  icon: Icons.apartment,
                  label: 'Apartment',
                ),
                SizedBox(width: 8),
                PropertyTypeChip(
                  icon: Icons.hotel,
                  label: 'Hotel',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (widget.isOffers) {
                if (hotelsOfferController.error.value.isNotEmpty) {
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bed_outlined, size: 40, color: Colors.red),
                        Text("No hotel offers found.".tr),
                      ],
                    ),
                  );
                }

                final hotelsOffers =
                    hotelsOfferController.hotelOffers.value?.data.data;
                if (hotelsOffers == null || hotelsOffers.isEmpty) {
                  return  Center(child: Text("No hotel offers found.".tr));
                }
                return _buildHotelList(hotelsOffers.length,
                    hotelsOffers: hotelsOffers);
              } else {
                final hotels = nearestHotelsController.hotels?.data.data;
                if (hotels == null || hotels.isEmpty) {
                  return  Center(child: Text("No hotels found.".tr));
                }
                return _buildHotelList(hotels.length, hotels: hotels);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelList(int itemCount, {var hotels, var hotelsOffers}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final hotelData =
            widget.isOffers ? hotelsOffers[index].hotel : hotels[index];
        return FutureBuilder(
          future: nearestHotelsController.fetchHotelPhotos(
            baseUrl,
            hotelData.hotelId,
            widget.isOffers ? hotelData.latitude : hotelData.geoCode.latitude,
            widget.isOffers ? hotelData.longitude : hotelData.geoCode.longitude,
          ),
          builder: (context, snapshot) {
            Widget imageWidget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              imageWidget = const Center(child: CircularProgressIndicator());
            } else {
              imageWidget = Image.network(
                nearestHotelsController.hotelPhotos != null &&
                        nearestHotelsController.hotelPhotos!.length > index
                    ? nearestHotelsController.hotelPhotos![index]
                    : 'https://via.placeholder.com/150',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }
            return GestureDetector(
              onTap: () {
                if (widget.isOffers &&
                    hotelsOffers != null &&
                    hotelsOffers[index].offers.isNotEmpty) {
                  final offer = hotelsOffers[index].offers.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomsView(
                        hotelId: hotelData.hotelId,
                        hotelName: offer.room.type ?? '',
                        hotelDescription: offer.room.description?.text ?? '',
                        hotelRating: widget.isOffers ? 5 : hotelData.rating,
                        hotelImage:
                            nearestHotelsController.hotelPhotos?[index] ??
                                'https://via.placeholder.com/150',
                        roomsLength: hotelsOffers[index].offers.length,
                        adults: offer.guests.adults ?? 2,
                        bedType:
                            offer.room.typeEstimated?.bedType ?? 'King Size',
                        price: double.tryParse(offer.price.total.toString()) ??
                            0.0,
                      ),
                    ),
                  );
                }
              },
              child: HotelCard(
                imageWidget: imageWidget,
                name: hotelData.name,
                location: widget.isOffers
                    ? hotelData.type
                    : hotelData.address.countryCode,
                rating: widget.isOffers ? 5 : hotelData.rating,
              ),
            );
          },
        );
      },
    );
  }
}
