import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time/bloc_observer.dart';
import 'package:world_time/main_cubit.dart';
import 'package:world_time/splash.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.edgeToEdge,
    //   overlays: [],
    // );
    return BlocProvider(
      create: (_) => MainCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'World Time',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
