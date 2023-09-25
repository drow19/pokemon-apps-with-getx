import 'package:get/get.dart';
import 'package:pokedex/model/filter_type_res.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/model/pokemon_flavour_text_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/model/pokemon_type_res.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/network/error_res.dart';
import 'package:pokedex/utils/network/interceptor.dart';

class PokemonProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    allowAutoSignedCert = true;
    httpClient.baseUrl = kBaseUrl;
    httpClient.timeout = const Duration(milliseconds: kConnectionTimeout);
    httpClient.addRequestModifier((request) {
      return requestInterceptor(request);
    });
    httpClient.addResponseModifier((request, response) {
      return responseInterceptor(request, response);
    });
  }

  Future<PokemonRes> getPokemon({int page = 0}) async {
    var params = {'offset': '$page', 'limit': '5'};

    final response = await get('/pokemon', query: params);

    try {
      return PokemonRes.fromJson(response.body);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<PokemonDetailRes> getPokemonDetail(String name) async {
    final response = await get('/pokemon/$name');

    try {
      return PokemonDetailRes.fromJson(response.body);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<FlavorTextRes> getPokemonDescription(String name) async {
    final response = await get('/pokemon-species/$name');

    try {
      return FlavorTextRes.fromJson(response.body);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<FilterTypeRes> getFilterType() async {
    final response = await get('/type');

    try {
      return FilterTypeRes.fromJson(response.body);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<PokemonTypeRes> getPokemonFilter(String type) async {
    final response = await get('/type/$type');

    try {
      return PokemonTypeRes.fromJson(response.body);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }
}
