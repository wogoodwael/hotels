import 'package:get/get.dart';
import '../data/models/nearest_model.dart';
import '../data/repo/nearest_repo.dart';

class NearestController extends GetxController {
  final NearestRepo nearestRepo;

  NearestController({required this.nearestRepo});

  final _isLoading = false.obs;
  final _nearestAirports = Rxn<NearestModel>();
  final _error = ''.obs;

  bool get isLoading => _isLoading.value;
  NearestModel? get nearestAirports => _nearestAirports.value;
  String get error => _error.value;

  Future<void> getNearestAirports({
    double? latitude,
    double? longitude,
  }) async {
    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await nearestRepo.getNearestAirports(
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      );
      _nearestAirports.value = result;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getNearestAirportsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await nearestRepo.getNearestAirportsWithRadius(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      _nearestAirports.value = result;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
