import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/auth/register/controller/register_controller.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            //LOGO
            Center(child: Image.asset(pokemonLogo, height: 150, width: 150)),
            const SizedBox(height: kDefaultPadding / 2),

            //FORM
            _SectionForm(),
            const SizedBox(height: kDefaultPadding),

            //BUTTON
            _SectionButton(),
          ],
        ),
      ),
    );
  }
}

class _SectionForm extends GetView<RegisterController> {
  const _SectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //USERNAME
          Text(
            'Username',
            style: kTextPoppinsMed12.copyWith(fontSize: 13),
          ),
          const SizedBox(height: kDefaultPadding / 5),
          Obx(
            () => TextField(
              controller: controller.nameCtrl,
              style: kTextPoppinsReg12,
              onChanged: (val) {
                controller.updateValue(RegisterForm.USERNAME, val);
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Please input your name',
                hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                errorText: controller.getErrorMessage(RegisterForm.USERNAME),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: kBlackColor1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          //EMAIL
          Text(
            'Email',
            style: kTextPoppinsMed12.copyWith(fontSize: 13),
          ),
          const SizedBox(height: kDefaultPadding / 5),
          Obx(
            () => TextField(
              controller: controller.emailCtrl,
              style: kTextPoppinsReg12,
              onChanged: (val) {
                controller.updateValue(RegisterForm.EMAIL, val);
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Please input your email',
                hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                errorText: controller.getErrorMessage(RegisterForm.EMAIL),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: kBlackColor1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          //PASSWORD
          Text(
            'Password',
            style: kTextPoppinsMed12.copyWith(fontSize: 13),
          ),
          const SizedBox(height: kDefaultPadding / 5),
          Obx(
            () => Stack(
              children: [
                TextField(
                  controller: controller.passCtrl,
                  style: kTextPoppinsReg12,
                  obscureText: !controller.togglePassword.value,
                  onChanged: (val) {
                    controller.updateValue(RegisterForm.PASSWORD, val);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Please input your password',
                    hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                    errorText: controller.getErrorMessage(RegisterForm.PASSWORD),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: kBlackColor1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () => controller.togglePassword.toggle(),
                    icon: controller.togglePassword.isTrue
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : const Icon(Icons.remove_red_eye, color: steelColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionButton extends GetView<RegisterController> {
  const _SectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          //LOGIN
          ElevatedButton(
            onPressed: () => controller.doRegister(),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Get.width, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'REGISTER',
              style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          Text(
            '- Or -\n- already have an account ? -',
            style: kTextPoppinsReg12.copyWith(color: kBlackColor1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kDefaultPadding / 5 * 2),

          //REGISTER
          ElevatedButton(
            onPressed: () => Get.toNamed(loginRoute),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Get.width, 40),
              backgroundColor: steelColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'LOGIN',
              style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
