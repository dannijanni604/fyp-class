import 'package:flutter/material.dart';
import 'package:get/get.dart';

ksucessSnackbar({String message = " SUCCESS"}) {
  return Get.snackbar(
    "SUCESS",
    message,
    backgroundColor: Colors.green.withOpacity(0.5),
    duration: const Duration(seconds: 2),
    dismissDirection: DismissDirection.down,
  );
}

kerrorSnackbar({String message = " ERROR"}) {
  return Get.snackbar(
    "ERROR",
    message,
    backgroundColor: Colors.red.withOpacity(0.5),
    duration: const Duration(seconds: 2),
    dismissDirection: DismissDirection.down,
  );
}

sendAlert(String message) async {
  Get.snackbar("Successful", message,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP);
}
