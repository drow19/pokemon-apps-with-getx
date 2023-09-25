import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/ui/widget/bottom_sheet_filter.dart';
import 'package:pokedex/ui/widget/pokemon_Item_card.dart';
import 'package:pokedex/ui/widget/shimmer_loading.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paddingTop = Get.mediaQuery.padding.top;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: RefreshIndicator(
          color: kBlueColor1,
          displacement: 10,
          onRefresh: controller.onRefresh,
          notificationPredicate: (ScrollNotification scroll) {
            if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
              if (controller.isLoading.isFalse && controller.hasNext.isTrue) {
                controller.page + 10;
                controller.getInitData();
              }
            }
            return true;
          },
          child: Column(
            children: [
              SizedBox(height: paddingTop),

              //SEARCH BAR
              _SearchBar(),

              //FILTER
              _FilterType(),

              //ITEMS
              Flexible(child: _ListItem()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends GetView<HomeController> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kWhiteColor,
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kBlackColor1),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_sharp, size: 20),
                const SizedBox(width: kDefaultPadding / 2),


                //TEXT FIELD
                Expanded(
                  child: TextField(
                    controller: controller.searchCtrl,
                    style: kTextPoppinsReg12,
                    onSubmitted: (val){
                      if(val.length >= 3){
                        controller.search.value = val;
                        controller.getSearchPokemon();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Pokemon',
                      hintStyle: kTextPoppinsReg12.copyWith(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: kDefaultPadding,
          bottom: 0,
          child: Obx(
            () => controller.search.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controller.search.value = '';
                      controller.searchCtrl.clear();
                      controller.getInitData();
                      controller.listData.clear();
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    color: Colors.red,
                    icon: const Icon(Icons.clear),
                  )
                : Container(),
          ),
        )
      ],
    );
  }
}

class _FilterType extends GetView<HomeController> {
  const _FilterType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.bottomSheet(const BottomSheetFilterType()).then((value){
          if(value != null){
            if(value['name'] == 'All type'){
              controller.listData.clear();
              controller.getInitData();
            }else{
              controller.getDataFromFilter();
            }
          }
        });
      },
      child: Obx(() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: cardColor(controller.filter['name'] ?? ''),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.filter['name'] ?? 'All type',
              style: kTextPoppinsMed14.copyWith(
                color: kWhiteColor,
              ),
            ),
            const SizedBox(width: kDefaultPadding / 5),
            const Icon(Icons.arrow_drop_down_outlined, color: kWhiteColor),
          ],
        ),
      )),
    );
  }
}

class _ListItem extends GetView<HomeController> {
  const _ListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue && controller.hasNext.isFalse) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          children: List.generate(3, (index) => const ShimmerLoading()),
        );
      }

      return ListView.builder(
        itemCount: controller.listData.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        itemBuilder: (context, index) {
          if (controller.listData[index].detail == null) {
            return const ShimmerLoading();
          }

          return InkWell(
              onTap: () {
                Get.toNamed(
                  detailRoute,
                  arguments: {'data': controller.listData[index]},
                );
              },
              child: PokemonItemCard(data: controller.listData[index]));
        },
      );
    });
  }
}
