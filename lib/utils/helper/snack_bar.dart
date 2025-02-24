import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackBar(String title, String message) {
  final snackBar = SnackBar(
    elevation: 0,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(Get.context!).size.height - 20,
        right: 10,
        left: 10),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}

void showErrorSnackBar(String title, String message) {
  final snackBar = SnackBar(
    elevation: 0,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(Get.context!).size.height - 90,
        right: 10,
        left: 10),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
