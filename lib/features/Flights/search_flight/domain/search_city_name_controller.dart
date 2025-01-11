import 'package:get/get.dart';
import '../data/models/nearest_model.dart';
import '../data/repo/search_city_name_repo.dart';

class SearchCityNameController extends GetxController {
  final SearchCityNameRepo searchCityNameRepo;
  final searchResults =Rxn<NearestModel>();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  SearchCityNameController({required this.searchCityNameRepo});

  Future<void> searchCityName(String keyword) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final result = await searchCityNameRepo.searchCityName(keyword);
      searchResults.value = result;
      
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
