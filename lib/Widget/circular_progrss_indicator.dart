import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Styles/my_colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white.withOpacity(0.5),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class ServerError extends StatelessWidget {
  const ServerError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Server error"));
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("No data found!"));
  }
}

SnackbarController snackBar({String? title}) {
  return Get.showSnackbar(GetSnackBar(
    messageText: Text(
      '$title',
      style: TextStyle(color: Colors.red),
    ),
    icon: Image.asset(
      'assets/images/warning.png',
      height: 25,
      width: 25,
      color: Colors.red,
    ),
    backgroundColor: Colors.white,

    ///blue_3d56f0
    duration: Duration(seconds: 5),
    snackPosition: SnackPosition.BOTTOM,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(15),
    borderRadius: 15,
    borderColor: Colors.red,
  ));

  // Get.snackbar('', '$title',
  //   snackPosition: SnackPosition.BOTTOM,
  //   colorText: Colors.white,
  //   backgroundColor: red_dc3642);
}
