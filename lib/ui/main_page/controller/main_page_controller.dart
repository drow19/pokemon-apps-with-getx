import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/favorite/favorite_screen.dart';
import 'package:pokedex/ui/main_page/content/home/home_screen.dart';
import 'package:pokedex/ui/main_page/content/profile/profile_screen.dart';

class MainPageController extends GetxController {
  var listMenu = [0, 1, 2];
  var currentMenu = 0.obs;

  int selectedMenu(value) => currentMenu.value = value;

  Widget getContentBody() {
    switch (currentMenu.value) {
      case 0:
        return const HomeScreen();
      case 1:
        return const FavoriteScreen();
      case 2:
        return const ProfileScreen();
      default:
        return Container();
    }
  }

  dynamic iconMenu(int menu) {
    switch (menu) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.favorite;
      case 2:
        return Icons.account_circle;
      default:
        return '';
    }
  }

  String titleMenu(int menu) {
    switch (menu) {
      case 0:
        return 'Home';
      case 1:
        return 'Favorite';
      case 2:
        return 'Profile';
      default:
        return '';
    }
  }
}