import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class LoginController extends GetxController {
  TextEditingController? emailCtrl, passCtrl;

  final storage = GetStorage();

  var togglePassword = false.obs;
  var isLoading = false.obs;

  final form = LoginForm();
  final _errors = <String, String>{}.obs;

  String? getErrorMessage(String key) {
    if (_errors.containsKey(key)) {
      return _errors[key];
    }
    return null;
  }

  removeErrorMessage(String key) {
    if (_errors.containsKey(key)) {
      return _errors.remove(key);
    }
  }

  updateValue(String key, String value) {
    removeErrorMessage(key);
    switch (key) {
      case LoginForm.EMAIL:
        form.email = value;
        break;
      case LoginForm.PASSWORD:
        form.password = value;
        break;
    }
  }

  bool validate() {
    _errors.clear();
    var valid = true;
    var email = form.email ?? '';
    var password = form.password ?? '';

    if (email.isEmpty) {
      valid = false;
      _errors[LoginForm.EMAIL] = 'Email cannot be empty';
    }

    if (password.isEmpty) {
      valid = false;
      _errors[LoginForm.PASSWORD] = 'Password cannot be empty';
    }

    return valid;
  }

  doLogin() {
    if (validate()) {
      if (storage.hasData(kAuthToken)) {
        isLoading(true);
        var data = jsonDecode(storage.read(kAuthToken));

        for (var element in data) {
          if (element['email'] == form.email && element['password'] == form.password) {
            Future.delayed(Duration(seconds: 1), () {
              isLoading(false);
              storage.write(kLastLogin, element['email']);
              Get.offAllNamed(homeRoute);
            });
          } else {
            showSnackBar('Wrong email or password');
          }
        }
      }else{
        showSnackBar('Email is not registered');
      }
    }
  }
}

class LoginForm {
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  String? password, email;

  RegisterForm() {
    email = '';
    password = '';
  }

  Map<String, dynamic> login() {
    Map<String, dynamic> map = {PASSWORD: password, EMAIL: email};

    return map;
  }
}
