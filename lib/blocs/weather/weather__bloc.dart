import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'weather__event.dart';
part 'weather__state.dart';

class Weather_Bloc extends Bloc<WeatherEvent, WeatherState> {
  Weather_Bloc() : super(WeatherInitial()) {
    on<StatusChange>((event, emit) {
      final currentstateValue=state.position;
      if(currentstateValue==1){
        return emit(WeatherState(position: 2));
      }else{
        return emit(WeatherState(position: 1));
      }


    });

    on<Logout>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    });
  }
}
