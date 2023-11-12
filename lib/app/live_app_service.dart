import 'package:base/app_config.dart';
import 'package:live_page/agora/rtc_utils.dart';
import 'package:live_page/agora/rtm_utils.dart';

import 'base_app_service.dart';

/// 做一些初始化操作
class LiveAppService extends BaseAppService {
  Future<LiveAppService> init() async {
    // 当前为直播类型
    AppConfig.setAppType(EnvApp.live);
    super.onInit();
    // 初始化IM
    await RTMUtils.initRtm();
    // 初始化RTC
    await RTCUtils.initRtc();
    return this;
  }
}
