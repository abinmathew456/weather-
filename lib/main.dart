import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/blocs/auth/auth_bloc.dart';
import 'package:machine_test/blocs/splash/splash_bloc.dart';
import 'package:machine_test/blocs/user_form/user_form_bloc.dart';
import 'package:machine_test/blocs/users/user_bloc.dart';
import 'package:machine_test/blocs/weather/weather_.dart';
import 'package:machine_test/blocs/weather/weather__bloc.dart';
import 'package:machine_test/repositories/UserRepository.dart';
import 'package:machine_test/repositories/auth_repository.dart';
import 'package:machine_test/ui/pages/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(AuthRepository())),
          BlocProvider(create: (context) => UserFormBloc()),
          BlocProvider(create: (context) => UserBloc(UserRepository()),),
          BlocProvider(create: (context) => Weather_Bloc()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.blue,),
          debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (_) => SplashBloc(), child: SplashScreen()),
    ));
  }
}