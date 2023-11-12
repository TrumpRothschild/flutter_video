import 'package:get/get.dart';

import 'invite_friends_controller.dart';

class InviteFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteFriendscontroller());
  }
}
