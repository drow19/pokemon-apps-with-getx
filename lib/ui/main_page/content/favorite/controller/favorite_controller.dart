import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';

class FavoriteController extends GetxController {
  final _provider = Get.find<PokemonProvider>();

  var storage = GetStorage();

  var pokemonName = ''.obs;
  var isLoading = false.obs;

  var listData = <PokemonData>[].obs;

  getData(){
    if(storage.hasData(savedItem)){
      String data = storage.read(savedItem);
      List<dynamic> decode = jsonDecode(data) ?? [];
      listData.value = decode.map((e) => PokemonData.fromJson(e)).toList();
      print(decode);
    }
    print('object');
  }

  @override
  void onInit() {
    super.onInit();

    if(storage.hasData(savedItem)){
      pokemonName.value = storage.read(savedItem);
      getData();
    }
  }
}