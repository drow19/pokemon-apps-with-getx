import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class RegisterController extends GetxController {
  TextEditingController? nameCtrl, passCtrl, emailCtrl;

  final storage = GetStorage();

  var togglePassword = false.obs;
  final form = RegisterForm();
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
      case RegisterForm.USERNAME:
        form.username = value;
        break;
      case RegisterForm.EMAIL:
        form.email = value;
        break;
      case RegisterForm.PASSWORD:
        form.password = value;
        break;
    }
  }

  bool validate() {
    _errors.clear();
    var valid = true;
    var email = form.email ?? '';
    var name = form.username ?? '';
    var password = form.password ?? '';

    var regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (name.isEmpty) {
      valid = false;
      _errors[RegisterForm.USERNAME] = 'Username cannot be empty';
    }

    if (email.isEmpty) {
      valid = false;
      _errors[RegisterForm.EMAIL] = 'Email cannot be empty';
    }

    if (password.isEmpty) {
      valid = false;
      _errors[RegisterForm.PASSWORD] = 'Password cannot be empty';
    }

    if(password.isNotEmpty){
      if(password.length <= 8){
        valid = false;
        _errors[RegisterForm.PASSWORD] = 'Password cannot be less than 8 character';
      }else if(!password.contains(RegExp(r'[0-9]'))){
        valid = false;
        _errors[RegisterForm.PASSWORD] = 'Password must contain number';
      }
    }

    if(email.isNotEmpty){
      if(regex.hasMatch(email) == false){
        valid = false;
        _errors[RegisterForm.EMAIL] = 'Invalid email';
      }
    }

    return valid;
  }

  doRegister(){
    if(validate()){
      if(storage.hasData(kAuthToken)){
        var authData = jsonDecode(storage.read(kAuthToken));

        if(authData != null && authData.isNotEmpty){
          for(var element in authData){
            if(element['email'] == form.email){
              showSnackBar('Email is already taken');
            }else{
              var listAuth = [];
              listAuth.add(form.register());
              storage.write(kAuthToken, jsonEncode(listAuth)).then((value){
                Get.offNamed(loginRoute);
              });
            }
          }
        }

      }else{
        var listAuth = [];
        listAuth.add(form.register());
        storage.write(kAuthToken, jsonEncode(listAuth)).then((value){
          form.clearData();
          emailCtrl!.clear();
          passCtrl!.clear();
          nameCtrl!.clear();
          Get.offNamed(loginRoute);
        });
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    nameCtrl = TextEditingController();
    passCtrl = TextEditingController();
    emailCtrl = TextEditingController();
  }
}

class RegisterForm {
  static const String USERNAME = 'username';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  String? username, password, email;

  RegisterForm() {
    username = '';
    email = '';
    password = '';
  }

  clearData(){
    username = '';
    email = '';
    password = '';
  }

  Map<String, dynamic> register() {
    Map<String, dynamic> map = {
      USERNAME: username,
      PASSWORD: password,
      EMAIL: email
    };

    return map;
  }
}