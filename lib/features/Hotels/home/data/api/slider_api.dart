import 'dart:convert';

import 'package:flights/features/Hotels/home/data/models/slider_model/slider_model.dart';
import 'package:flights/utils/constants/strings.dart';
import 'package:http/http.dart' as http;

class SliderApi {
  Future<SliderModel> getSliders() async {
    final response = await http.get(Uri.parse("$baseUrl/slider"));
    if (response.statusCode == 200) {
      print("response success ${response.body}");
      return SliderModel.fromJson(jsonDecode(response.body));
    } else {
      print("failed to fetch sliders ${response.statusCode}");
      throw Exception("Failed to get slider");
    }
  }
}
