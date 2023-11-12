import 'package:get/get.dart';
import 'package:video_page/personalized_channel/personalized_channel_controller.dart';
class PersonalizedChannelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalizedChannelController>(()=> PersonalizedChannelController());
  }
}
