import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/utils/bindings.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var route = '';
    if(storage.hasData(kLastLogin)){
      route = homeRoute;
    }else{
      route = loginRoute;
    }

    return GetMaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(kBlueColor1),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      getPages: routes,
      initialRoute: route,
      initialBinding: InitialBinding(),
    );
  }
}
