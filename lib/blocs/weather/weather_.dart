
import 'package:machine_test/model/weather_model.dart';
import 'package:machine_test/repositories/auth_repository.dart';
import 'package:rxdart/subjects.dart';

class WeatherBloc {
  AuthRepository _repository = AuthRepository();

  final _weatherFetcher = PublishSubject<WeatherResponse>();

  Stream<WeatherResponse> get weather => _weatherFetcher.stream;

  fetcnWeather() async {
    WeatherResponse? weatherResponse = await _repository.fetchKochiWeather();
    _weatherFetcher.sink.add(weatherResponse!);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();