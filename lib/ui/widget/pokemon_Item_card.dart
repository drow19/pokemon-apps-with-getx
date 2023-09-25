import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/ui/widget/pokemon_image_card.dart';
import 'package:pokedex/ui/widget/pokemon_type_card.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';

class PokemonItemCard extends StatelessWidget {
  const PokemonItemCard({Key? key, required this.data}) : super(key: key);

  final PokemonData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      padding: const EdgeInsets.only(left: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  'Nº0${data.detail!.gameIndices!.last.gameIndex}',
                  style: kTextPoppinsMed12,
                ),
                Text(
                  '${data.name}'.capitalizeFirst!,
                  style: kTextPoppinsMed16.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),

                //ABILITY
                PokemonTypeCard(data: data.detail!),
              ],
            ),
          ),

          //CARD IMAGE
          _CardImage(data: data),
        ],
      ),
    );
  }
}

class _CardImage extends GetView<HomeController> {
  const _CardImage({Key? key, required this.data}) : super(key: key);

  final PokemonData data;

  @override
  Widget build(BuildContext context) {
    if (data.detail != null) {
      return Stack(
        children: [
          PokemonImageCard(data: data.detail!),
          Positioned(
            top: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
            child: InkWell(
              onTap: () {
                controller.addToFavorite(data);
              },
              child: Obx(() {
                var x = controller.isLoading.value;

                return Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: kWhiteColor),
                  ),
                  child: controller.isDataExist(data)
                      ? const Icon(
                          Icons.favorite,
                          size: 20,
                          color: kWhiteColor,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: kWhiteColor,
                        ),
                );
              }),
            ),
          ),
        ],
      );
    }

    return Container();
  }
}
