import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class ProfileController extends GetxController {
  var storage = GetStorage();

  var userName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  getDataProfile(){
    var lastLogin = '';
    if(storage.hasData(kLastLogin)){
      lastLogin = storage.read(kLastLogin);
    }

    if(storage.hasData(kAuthToken)){
      List data = jsonDecode(storage.read(kAuthToken));

      for(var element in data){
        if(element['email'] == lastLogin){
          userName.value = element['username'];
          password.value = element['password'];
          email.value = element['email'];
        }
      }
    }
  }

  doLogout(){
    if(storage.hasData(kLastLogin)){
      storage.remove(kLastLogin).then((value) {
        Get.offAllNamed(loginRoute);
      });
    }else{
      Get.offAllNamed(loginRoute);
    }
  }

  @override
  void onInit() {
    super.onInit();

    getDataProfile();
  }
}