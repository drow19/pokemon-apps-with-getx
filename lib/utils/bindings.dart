import 'package:get/get.dart';
import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:pokedex/ui/main_page/content/favorite/controller/favorite_controller.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/ui/main_page/content/profile/controller/profile_controller.dart';
import 'package:pokedex/ui/main_page/controller/main_page_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    //PROVIDERS
    Get.lazyPut(() => PokemonProvider(), fenix: true);

    Get.lazyPut(() => MainPageController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}