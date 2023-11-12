import 'package:url_launcher/url_launcher.dart';
import 'package:base/app_routes.dart';
import 'package:get/get.dart';

// 广告位置
enum OLAdType {
  unKnow,
  normal,
  game,
  video,
  live,
}

enum OLAdSkipType {
  unKnow,
  normal,
  link,
  videoDetail,
  liveRoom,
  imageUrl,
  ui,
}

class OLAdController {
  static final OLAdController shared = OLAdController();

  void click(int adType, int skipModel, String skipValue, String extra) async {
    if (adType == OLAdType.video.index) {
      Get.toNamed(AppRoutes.videoDetailPage,
          arguments: {"id": int.tryParse(skipValue)});
    } else if (adType == OLAdType.game.index) {
      if (skipModel == OLAdSkipType.ui.index) {
        Get.toNamed(
          AppRoutes.gameWeb,
          arguments: {
            "categoryId": 0,
            'extra': extra,
          },
        );
      }
    } else if (adType == OLAdType.normal.index) {
      if (skipModel == OLAdSkipType.link.index ||
          skipModel == OLAdSkipType.imageUrl.index) {
        if (skipValue.isNotEmpty) {
          await launch(skipValue);
        }
      }
    } else {
      if (skipModel == OLAdSkipType.normal.index) {
        await launch(skipValue);
      }
    }
  }

  void clickGameBanner(
      int adType, int skipModel, String skipValue, String extra) async {
    if (adType == OLAdType.video.index) {
      Get.toNamed(AppRoutes.videoDetailPage,
          arguments: {"id": int.tryParse(skipValue)});
    } else if (adType == OLAdType.game.index) {
      if (skipModel == OLAdSkipType.ui.index) {
        Get.toNamed(
          AppRoutes.gameWeb,
          arguments: {
            "categoryId": 0,
            'extra': extra,
          },
        );
      }
    } else if (adType == OLAdType.normal.index) {
      if (skipValue.isNotEmpty) {
        await launch(skipValue);
      }
    } else {
      if (skipModel == OLAdSkipType.normal.index) {
        await launch(skipValue);
      }
    }
  }
}
