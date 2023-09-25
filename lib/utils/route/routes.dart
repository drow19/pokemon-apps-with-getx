import 'package:get/get.dart';
import 'package:pokedex/ui/auth/login/bindings.dart';
import 'package:pokedex/ui/auth/login/login.dart';
import 'package:pokedex/ui/auth/register/bindings.dart';
import 'package:pokedex/ui/auth/register/register_screen.dart';
import 'package:pokedex/ui/main_page/main_page_screen.dart';
import 'package:pokedex/ui/pokemon_detail/bindings.dart';
import 'package:pokedex/ui/pokemon_detail/pokemon_detail_screen.dart';

const loginRoute = '/login';
const registerRoute = '/register';
const homeRoute = '/';
const detailRoute = '/pokemon/detail';

final routes = [
  GetPage(
    name: homeRoute,
    page: () => const MainPageScreen(),
  ),

  //LOGIN
  GetPage(
    name: loginRoute,
    page: () => const LoginScreen(),
    binding: LoginBindings(),
  ),

  //REGISTER
  GetPage(
    name: registerRoute,
    page: () => const RegisterScreen(),
    binding: RegisterBindings(),
  ),

  //DETAIL
  GetPage(
    name: detailRoute,
    page: () => const PokemonDetailScreen(),
    binding: PokemonDetailBindings(),
  ),
];
