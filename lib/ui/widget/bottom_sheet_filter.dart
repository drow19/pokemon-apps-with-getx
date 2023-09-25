import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/home/controller/home_controller.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';

class BottomSheetFilterType extends GetView<HomeController> {
  const BottomSheetFilterType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Obx(() {
        if (controller.isLoadingType.isTrue) {
          return Container();
        }

        return ListView.builder(
          itemCount: controller.listFilter.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                var url = controller.listFilter[index].url;
                var name = controller.listFilter[index].name!.capitalizeFirst;
                var length = controller.listFilter[index].url!.length;
                var replace = url!.replaceRange(length - 1, length, '');
                var split = replace.split('/');

                controller.filter.value = {
                  'type': split.last,
                  'name': name,
                };

                Get.back(result: controller.filter);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2,
                    ),
                    child: Text(
                      controller.listFilter[index].name!,
                      style: kTextPoppinsReg12,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
