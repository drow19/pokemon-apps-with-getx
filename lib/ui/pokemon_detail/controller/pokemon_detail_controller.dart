import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/model/pokemon_flavour_text_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/utils/commons/constan.dart';

class PokemonDetailController extends GetxController {

  var storage = GetStorage();
  var isExist = false.obs;

  PokemonData data = Get.arguments['data'];

  PokemonDetailRes get detail {
    return data.detail!;
  }

  FlavorTextRes get description {
    return data.textRes!;
  }
  
  addToFavorite(){
    update();
    Get.find<HomeController>().addToFavorite(data);
  }

  bool isDataExist(PokemonData data){
    String _data = storage.read(savedItem) ?? '';
    List<PokemonData> pokemonData = [];
    if(_data.isNotEmpty){
      List<dynamic> json = jsonDecode(_data) ?? [];
      pokemonData = json.map((e) => PokemonData.fromJson(e)).toList();

      var find = pokemonData.firstWhereOrNull((element) {
        return element.name == data.name;
      });

      if(find != null){
        return true;
      }else{
        return false;
      }
    }

    return false;
  }
}