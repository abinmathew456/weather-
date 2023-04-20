import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:machine_test/blocs/weather/weather_.dart';
import 'package:machine_test/blocs/weather/weather__bloc.dart';
import 'package:machine_test/main.dart';
import 'package:machine_test/model/weather_model.dart';
import 'package:machine_test/services/timeConversion.dart';
import 'package:machine_test/ui/pages/splash.dart';

class Weather extends StatelessWidget {
  Weather({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    weatherBloc.fetcnWeather();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  logoutApp(context);
                 // _weatherBloc!.add(WeatherLoad());
                },
                child: Icon(
                    Icons.power_settings_new
                ),
              )
          ),
        ],
      ),
      body:StreamBuilder(
          stream: weatherBloc.weather,
          builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {
            if (snapshot.hasData) {
              return _weatherScreen(context,snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
Container _weatherScreen(BuildContext ctx,WeatherResponse data){
    List<bool> _selections = List.generate(2, (_) => false);
    return  Container(
      width: MediaQuery.of(ctx).size.width,
      height:MediaQuery.of(ctx).size.height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/weather.jpg"),
          fit: BoxFit.cover,
        ),

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.location!.name!,
                  style: const TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),
                ),

                BlocBuilder<Weather_Bloc, WeatherState>(
                builder: (context, state) {
                  return ToggleButtons(
                  children: <Widget>[
                    Text("°C"),
                    Text("°F"),
                  ],
                  isSelected: state.position==1?[true,false]:[false,true],
                  color: Colors.white,
                  borderColor: Colors.white,
                  selectedColor: Colors.white ,
                  fillColor: Colors.green,
                  onPressed: (int index) {
                    print(_selections);
                    ctx.read<Weather_Bloc>().add(StatusChange());
                 /*   setState(() {
                      _selections[index] = !_selections[index];
                    });*/
                  },
                );})
              ],
            ),
            Text(DateFormat('dd MMM yyyy  hh:mm a').format(DateTime.parse(data.location!.localtime!.toString())).toString()

              ,
              style: const TextStyle(color: Colors.grey,fontSize: 11),
            ),
            Spacer(),
          BlocBuilder<Weather_Bloc, WeatherState>(
            builder: (context, state) {
             return  Text(
               state.position==1?data.current!.tempC!.toString()+" °C":data.current!.tempF!.toString()+" °F",
              style: const TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),
            );}),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  'https:'+ data.current!.condition!.icon!,
                  width: 25.0,
                ),
                SizedBox(width: 5,),
                Text(
                  data.current!.condition!.text!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(width: MediaQuery.of(ctx).size.width,height: .2,color: Colors.grey.shade100,),
            ),

            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Wind',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      data.current!.windKph!.toString()+" km/h",
                      style: const TextStyle(color: Colors.white),
                    ),

                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'Rain',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      data.current!.cloud!.toString()+" %",
                      style: const TextStyle(color: Colors.white),
                    ),

                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'Humidity',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      data.current!.humidity!.toString()+" %",
                      style: const TextStyle(color: Colors.white),
                    ),

                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
}
  logoutApp(BuildContext context) {
    return showDialog(
      context: context,
       builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout!!'),
          content: Text('Do you want to logout this application?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<Weather_Bloc>().add(Logout());
                logout(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
       },
    );
  }
  void logout(ctx) {
    Navigator.pushAndRemoveUntil(
        ctx,
        MaterialPageRoute(
            builder: (context) => MyApp()
        ),
        ModalRoute.withName("/MyApp")
    );
  }
 Future<String> convertTime(String time) async {
    DateTime dt1 = DateTime.parse(time);
    String formattedDate = DateFormat('dd MMM yyyy  hh:mm a').format(DateTime.parse(time)).toString();
    print(formattedDate);
    return formattedDate;
  }
}