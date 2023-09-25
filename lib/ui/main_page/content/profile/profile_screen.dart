import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/profile/controller/profile_controller.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';

const _imageAva =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDtd0soCSRdpo8Y5klekJdABh4emG2P29jwg&usqp=CAU';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kWhiteColor,
        title: Obx(() => Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(_imageAva),
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              controller.userName.value ?? '-',
              style: kTextPoppinsReg12.copyWith(
                fontSize: 13,
                color: kBlackColor1,
              ),
            ),
          ],
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          //PROFILE SECTION
          _ProfileData(),
          Spacer(),

          //LOGOUT BUTTON
          _LogoutButton()
        ],
      ),
    );
  }
}

class _ProfileData extends GetView<ProfileController> {
  const _ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Profile Information',
            style: kTextPoppinsBold16.copyWith(color: kBlackColor1),
          ),
          const SizedBox(height: kDefaultPadding / 5 * 4),

          //NAME
          Obx(() => _sectionRowTitle('Name', controller.userName.value ?? '-')),
          const SizedBox(height: kDefaultPadding / 2),

          //EMAIL
          Obx(() => _sectionRowTitle('Email', controller.email.value ?? '-')),
          const SizedBox(height: kDefaultPadding / 2),

          //PASSWORD
          Obx(() => _sectionRowTitle('Password', controller.password.value ?? '-')),
          const SizedBox(height: kDefaultPadding / 2),
        ],
      ),
    );
  }

  Widget _sectionRowTitle(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TITLE
        Text(
          title,
          style: kTextPoppinsMed14.copyWith(
            color: kBlackColor1,
          ),
        ),

        //SUB-TITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subTitle,
              style: kTextPoppinsReg12.copyWith(
                color: kBlackColor1,
              ),
            ),

            const Icon(Icons.keyboard_arrow_right_outlined, size: 20)
          ],
        ),
      ],
    );
  }
}

class _LogoutButton extends GetView<ProfileController> {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      child: ElevatedButton(
        onPressed: () => controller.doLogout(),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.transparent),
            )),
            minimumSize: MaterialStateProperty.all(Size(Get.width, 45)),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              } else {
                return kRedColor1;
              }
            })),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Logout',
              style: kTextPoppinsBold14.copyWith(
                color: kWhiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
