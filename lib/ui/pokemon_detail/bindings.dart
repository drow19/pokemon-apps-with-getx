import 'package:get/get.dart';
import 'package:pokedex/ui/pokemon_detail/controller/pokemon_detail_controller.dart';

class PokemonDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PokemonDetailController());
  }
}