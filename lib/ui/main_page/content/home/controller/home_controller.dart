import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/favorite.dart';
import 'package:pokedex/model/filter_type_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:pokedex/ui/main_page/content/favorite/controller/favorite_controller.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';

class HomeController extends GetxController {
  final _provider = Get.find<PokemonProvider>();

  var searchCtrl = TextEditingController();

  var storage = GetStorage();

  var isLoading = false.obs;
  var isLoadingType = false.obs;
  final isFavorite = false.obs;

  var listData = <PokemonData>[].obs;
  var listFilter = <ResultsType>[].obs;

  var page = 0.obs;
  var hasNext = false.obs;
  var search = ''.obs;
  var filter = {}.obs;

  getInitData() {
    isLoading(true);
    _provider.getPokemon(page: page.value).then((value) {
      isLoading(false);
      if (value.results != null || value.results!.isNotEmpty) {
        if (value.results != null) {
          listData.addAll(value.results!);
        }

        if (value.next != null) {
          hasNext(true);
        } else {
          hasNext(false);
        }

        for (var element in listData) {
          var index = listData.indexOf(element);
          getPokemonDetail(element.name!, index);
          getPokemonDescription(element.name!, index);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar('Something went wrong! Please, try again later');
    });
  }

  getFilterType() {
    isLoadingType(true);
    _provider.getFilterType().then((value) {
      isLoadingType(false);
      if (value.results != null) {
        listFilter.value = value.results!;
        listFilter.insert(0, ResultsType(name: 'All type', url: ''));
      }
    }).onError((error, stackTrace) {
      isLoadingType(false);
      showSnackBar('Something went wrong! Please, try again later');
    });
  }

  getSearchPokemon() {
    listData.clear();
    listData.add(PokemonData());
    listData.refresh();

    _provider.getPokemonDetail(search.value).then((value) {
      if (value.name != null && value.name!.isNotEmpty) {
        listData.first.name = search.value;
        listData.first.detail = value;
        getPokemonDescription(search.value, 0);
      }
    }).onError((error, stackTrace) {
      listData.first.isLoadingType = false;
      listData.refresh();
      print(error.toString());
      showSnackBar('Something went wrong! Please, try again later');
    });
  }

  getPokemonDetail(String name, int index) {
    listData[index].isLoadingType = true;
    listData.refresh();

    _provider.getPokemonDetail(name).then((value) {
      listData[index].isLoadingType = false;
      if (value.name != null && value.name!.isNotEmpty) {
        listData[index].detail = value;
        listData.refresh();
      }
    }).onError((error, stackTrace) {
      listData[index].isLoadingType = false;
      listData.refresh();
      print('asu2 : $error');
      showSnackBar('Something went wrong! Please, try again later');
    });
  }

  getPokemonDescription(String name, int index) {
    listData[index].isLoadingType = true;
    listData.refresh();

    _provider.getPokemonDescription(name).then((value) {
      listData[index].isLoadingType = false;
      if (value.flavorTextEntries != null &&
          value.flavorTextEntries!.isNotEmpty) {
        listData[index].textRes = value;
        listData.refresh();
      }
    }).onError((error, stackTrace) {
      listData[index].isLoadingType = false;
      listData.refresh();
    });
  }

  getDataFromFilter() {
    listData.clear();
    isLoading(true);

    _provider.getPokemonFilter(filter['type']).then((value) {
      isLoading(false);
      if (value.pokemon != null || value.pokemon!.isNotEmpty) {
        for (var element in value.pokemon!) {
          var index = value.pokemon!.indexOf(element);
          listData.add(PokemonData(
            name: element.pokemon!.name,
            url: element.pokemon!.url,
          ));
          getPokemonDetail(element.pokemon!.name!, index);
          getPokemonDescription(element.pokemon!.name!, index);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);
    });
  }

  Future<void> onRefresh() async {
    page.value = 0;
    listData.clear();
    getInitData();
    search.value = '';
    searchCtrl.clear();
  }

  addToFavorite(PokemonData data) {
    String _data = storage.read(savedItem) ?? '';
    List<PokemonData> pokemonData = [];
    if (_data.isNotEmpty) {
      List<dynamic> json = jsonDecode(_data) ?? [];
      pokemonData = json.map((e) => PokemonData.fromJson(e)).toList();


      var find = pokemonData.firstWhereOrNull((element) {
        return element.name == data.name;
      });

      if(find != null){
        pokemonData.removeWhere((element) {
          return element.name == data.name;
        });
      }else{
        pokemonData.add(data);
      }
      List<dynamic> encode = pokemonData.map((e) => e.toJson()).toList();
      storage.write(savedItem, jsonEncode(encode));

    } else {
      pokemonData.add(data);
      List<dynamic> encode = pokemonData.map((e) => e.toJson()).toList();
      storage.write(savedItem, jsonEncode(encode));
    }
    listData.refresh();
    Get.find<FavoriteController>().onInit();
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

  @override
  void onInit() {
    super.onInit();

    searchCtrl = TextEditingController();

    getFilterType();
    getInitData();
  }
}
