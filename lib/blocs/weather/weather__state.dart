part of 'weather__bloc.dart';

class WeatherState {
  final int position;
  WeatherState({required this.position});
}

class WeatherInitial extends WeatherState {
  WeatherInitial():super(position: 1);
}
class LogoutSuccess extends WeatherState {
  LogoutSuccess():super(position: 1);

}
