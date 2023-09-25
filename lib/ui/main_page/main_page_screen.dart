import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/controller/main_page_controller.dart';
import 'package:pokedex/ui/main_page/widget/custom_navigation_bar.dart';
import 'package:pokedex/utils/commons/colors.dart';

class MainPageScreen extends GetView<MainPageController> {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.getContentBody()),
      bottomNavigationBar: Obx(() => CustomBottomNavAppBar(
        color: kWhiteColor,
        selectedColor: kBlueColor1,
        onTabSelected: controller.selectedMenu,
        selectedIndex: controller.currentMenu.value,
        items: controller.listMenu
            .map((menu) => CustomBottomAppBarItem(
            title: controller.titleMenu(menu),
            iconData: controller.iconMenu(menu)))
            .toList(),
      )),
    );
  }
}