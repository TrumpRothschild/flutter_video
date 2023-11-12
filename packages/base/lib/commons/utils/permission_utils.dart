import 'package:permission_handler/permission_handler.dart';

/// 权限管理相关utils
class PermissionUtils {
  static PermissionUtils of() => PermissionUtils();

  // 直播间权限获取
  Future<void> livePerms() async {
    await [Permission.microphone, Permission.camera].request();
  }
}
