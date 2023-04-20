
import 'package:machine_test/model/weather_model.dart';
import 'package:machine_test/services/auth_api_client.dart';

class AuthRepository {
  final String _apiKey= '/api/login';
  final AuthApiClient _authApiClient= AuthApiClient();
  Future<dynamic> login(String email,String password) async {
    final response = await _authApiClient.postLogin(_apiKey,{"email": email, "password":password});
    return response;
  }

  Future<WeatherResponse?> fetchKochiWeather() => _authApiClient.fetchWeather();

}
