import 'dart:io';

import 'package:flutter/material.dart';

bool isNetworkConnection = true;
Future<void> internetConection(context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isNetworkConnection = true;
    }
  } on SocketException catch (_) {
    isNetworkConnection = false;
    showSnackBar(context, 'Please Check Your Internet');
    // showTopSnackBar(
    //     context,
    //     const CustomSnackBar.success(
    //       backgroundColor: Colors.red,
    //       message: 'Please Check Your Internet',
    //       // icon: Icon(null),
    //     ),
    //   );
  }
}

showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )));
}
