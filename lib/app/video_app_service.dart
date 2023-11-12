import 'package:base/app_config.dart';

import 'base_app_service.dart';

/// 做一些初始化操作
class VideoAppService extends BaseAppService {
  Future<VideoAppService> init() async {
    // 当前为视频类型
    AppConfig.setAppType(EnvApp.video);
    super.onInit();
    return this;
  }
}
