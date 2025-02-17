import 'package:get/get.dart';
import '../data/models/nearset_hotels_model.dart';
import '../data/models/search_city_model.dart';
import '../data/repo/nearest_repo.dart';

class NearestHotelsController extends GetxController {
  final NearestHotelsRepo nearestHotelsRepo;

  NearestHotelsController({required this.nearestHotelsRepo});

  final _isLoading = false.obs;
  final _error = ''.obs;
  final _hotels = Rx<NearestHotelsModel?>(null);
  final _hotelPhotos = Rx<List<String>?>(null);
  final _searchResults = Rx<SearchCityModel?>(null);

  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  NearestHotelsModel? get hotels => _hotels.value;
  List<String>? get hotelPhotos => _hotelPhotos.value;
  SearchCityModel? get searchResults => _searchResults.value;
  void setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> getNearestHotels({
    required double latitude,
    required double longitude,
    required int radius,
    String radiusUnit = 'KM',
    List<String> amenities = const ['SWIMMING_POOL'],
  }) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final result = await nearestHotelsRepo.getNearestHotels(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        radiusUnit: radiusUnit,
        amenities: amenities,
      );

      _hotels.value = result;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getNearestHotelsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final result = await nearestHotelsRepo.getNearestHotelsWithRadius(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      _hotels.value = result;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> fetchHotelPhotos(
      String baseUrl, String hotelId, double latitude, double longitude) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      final photos = await nearestHotelsRepo.fetchHotelPhotos(
        baseUrl: baseUrl,
        hotelId: hotelId,
        latitude: latitude,
        longitude: longitude,
      );
      _hotelPhotos.value = photos;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> searchHotelsByCity(String cityCode) async {
    try {
      _isLoading.value = true;
      _error.value = '';
      final result =
          await nearestHotelsRepo.searchHotelsByCity(cityCode: cityCode);
      _searchResults.value = result;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
