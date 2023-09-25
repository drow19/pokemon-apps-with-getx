import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/auth/login/controller/login_controller.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            const _SectionForm(),
            const SizedBox(height: kDefaultPadding),

            //BUTTON
            const _SectionButton(),
          ],
        ),
      ),
    );
  }
}

class _SectionForm extends GetView<LoginController> {
  const _SectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //EMAIL
          Text(
            'Email',
            style: kTextPoppinsMed12.copyWith(fontSize: 13),
          ),
          const SizedBox(height: kDefaultPadding / 5),
          Obx(
            () => TextField(
              style: kTextPoppinsReg12,
              onChanged: (val) {
                controller.updateValue(LoginForm.EMAIL, val);
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Please input your email',
                hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                errorText: controller.getErrorMessage(LoginForm.EMAIL),
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
                  style: kTextPoppinsReg12,
                  obscureText: !controller.togglePassword.value,
                  onChanged: (val) {
                    controller.updateValue(LoginForm.PASSWORD, val);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Please input your password',
                    hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                    errorText: controller.getErrorMessage(LoginForm.PASSWORD),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionButton extends GetView<LoginController> {
  const _SectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          //LOGIN
          Obx(() => ElevatedButton(
                onPressed: controller.isLoading.isFalse
                    ? () => controller.doLogin()
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: normalColor,
                  minimumSize: Size(Get.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: controller.isLoading.isFalse
                    ? Text(
                        'LOGIN',
                        style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: kWhiteColor,
                              strokeWidth: 2,
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding),
                          Text(
                            'Loading . . .',
                            style:
                                kTextPoppinsMed12.copyWith(color: kWhiteColor),
                          ),
                        ],
                      ),
              )),
          const SizedBox(height: kDefaultPadding / 2),

          Text(
            '- or -\n- you dont have any account ? -',
            style: kTextPoppinsReg12.copyWith(color: kBlackColor1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kDefaultPadding / 5 * 2),

          //REGISTER
          Obx(() => ElevatedButton(
                onPressed: controller.isLoading.isFalse
                    ? () => Get.toNamed(registerRoute)
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width, 40),
                  backgroundColor: steelColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'REGISTER',
                  style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
                ),
              )),
        ],
      ),
    );
  }
}
