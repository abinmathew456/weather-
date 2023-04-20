import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/blocs/splash/splash_bloc.dart';
import 'package:machine_test/ui/pages/home.dart';
import 'package:machine_test/ui/pages/login.dart';
import 'package:machine_test/ui/pages/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(SetSplash());
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) async {
          if (state is SplashLoadedState) {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            if(prefs.getBool('lodinStatus')==null){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Onboard()));
            }else if(prefs.getBool('lodinStatus')==false) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }else
        {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }



          }
        },
        builder: (context, state) {
          if (state is SplashLoadingState) {
            return Container(

              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),

              ),
              child: Center(
                child: Container(

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset('assets/logo.png',width: 100,),
                )),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}