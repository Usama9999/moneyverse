import 'package:get/get.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/utils/login_details.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController(), fenix: true);
    Get.lazyPut(() => UserDetail(), fenix: true);
  }
}
