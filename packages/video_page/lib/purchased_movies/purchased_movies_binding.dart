import 'package:get/get.dart';
import 'package:video_page/purchased_movies/purchased_movies_controller.dart';
class PurchasedMoviesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasedMoviesController>(()=> PurchasedMoviesController());
  }
}
