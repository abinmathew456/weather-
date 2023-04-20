import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machine_test/constants/constant.dart';
import 'package:machine_test/model/weather_model.dart';
class AuthApiClient {
  Future<dynamic> postLogin(String url, dynamic body) async {
    final response = await http.post(Uri.parse(apiUrl + url), body: body);
    var responseJson = getApiResponse(response);
    return responseJson;
  }
  Future<WeatherResponse> fetchWeather() async {
    final response = await http.get(Uri.parse(weatherUrl));
     print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
  getApiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson["token"];
      case 400:
        var responseError = jsonDecode(response.body.toString());
        return responseError["error"];
      default:
        return Exception('Error:${response.statusCode.toString()}');
    }
  }
}
