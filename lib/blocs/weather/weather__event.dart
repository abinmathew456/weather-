part of 'weather__bloc.dart';

@immutable
abstract class WeatherEvent {}
class StatusChange extends WeatherEvent{


}
class Logout extends WeatherEvent{

}