import 'package:get/get.dart';
import 'package:pokedex/ui/auth/login/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}