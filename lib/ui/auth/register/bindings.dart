import 'package:get/get.dart';
import 'package:pokedex/ui/auth/register/controller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}