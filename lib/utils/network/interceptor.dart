import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/utils/commons/constan.dart';

requestInterceptor(Request request){

  if (kDebugMode) {
    var message = {
      'REQUEST URL:': request.url,
      'REQUEST HEADER:': request.headers,
      'REQUEST METHOD:': request.method,
    };
    debugPrint('$message');
  }
  return request;
}

responseInterceptor(Request request, Response response,
    [bool redirect = true]) {
  /*DateTime dateTime = DateTime.now();
  request.headers['timezone'] = dateTime.timeZoneName;*/
  var message = <String, dynamic>{
    'RESPONSE URL:': request.url,
    'RESPONSE CODE:': response.statusCode,
    'RESPONSE MESSAGE:': response.statusText,
    'RESPONSE BODY:': response.body,
    'RESPONSE UNAUTHORIZED:': response.unauthorized,
  };
  debugPrint('$message');
  if (redirect && response.unauthorized) {
    GetStorage().remove(kToken);
    // Get.toNamed(loginRoute);
  }
  return response;
}