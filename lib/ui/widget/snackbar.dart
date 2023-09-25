import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/network/error_res.dart';

showSnackBar(
  message, {
  String? textButton,
  Function()? onClick,
  Duration duration = const Duration(seconds: 3),
}) {
  String errorMessage = '';
  int errorCode = 0;

  if (message is ErrorRes) {
    errorMessage = message.message;
    errorCode = message.code;
  } else {
    errorMessage = message;
  }

  Get.snackbar(
    '',
    '',
    titleText: const SizedBox(),
    padding: EdgeInsets.zero,
    messageText: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.GROUNDED,
    margin: EdgeInsets.zero,
    backgroundColor: kColorBlack,
    colorText: Colors.white,
    duration: duration,
  );
}
