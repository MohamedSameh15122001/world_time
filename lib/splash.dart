import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Color.fromARGB(255, 68, 70, 84),
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return SplashView(
      // logo: const FlutterLogo(),
      loadingIndicator: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SpinKitHourGlass(
          color: Colors.blue,
          size: 30.0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 68, 70, 84),
      bottomLoading: false,
      showStatusBar: true,
      title: Image.asset(
        'lib/assets/time-zones.png',
        width: 100,
        height: 100,
      ),

      // gradient: const LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[Colors.green, Colors.blue]),
      done: Done(
        const Home(),
        animationDuration: const Duration(seconds: 2),
        // curve: Curves.easeInOut,
      ),
    );
  }
}
