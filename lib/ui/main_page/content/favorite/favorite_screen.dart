import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/favorite/controller/favorite_controller.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/ui/widget/pokemon_Item_card.dart';
import 'package:pokedex/ui/widget/shimmer_loading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: ListView(
          children: [
            _ContentBody(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody({Key? key, required this.controller}) : super(key: key);

  final FavoriteController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          children: List.generate(3, (index) => const ShimmerLoading()),
        );
      }

      if (controller.listData.isEmpty) {
        return SizedBox(
          height: Get.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(pokeball, height: 100, width: 100),
              const SizedBox(height: kDefaultPadding),
              const Text('Pokeball is empty', style: kTextPoppinsMed16),
            ],
          ),
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.toNamed(
                  detailRoute,
                  arguments: {'data': controller.listData[index]},
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Slidable(
                  key: const ValueKey(0),
                  direction: Axis.horizontal,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Get.find<HomeController>()
                              .addToFavorite(controller.listData[index]);
                        },
                        backgroundColor: cardColor(
                          controller
                              .listData[index].detail!.types!.first.type!.name!,
                        ).withOpacity(.5),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: PokemonItemCard(data: controller.listData[index]),
                ),
              ));
        },
      );
    });
  }
}
