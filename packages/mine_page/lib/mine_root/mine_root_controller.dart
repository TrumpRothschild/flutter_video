import 'package:base/assets.gen.dart';
import 'package:get/get.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:services/api/mine_msg_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/provider/user_provider.dart';

class MineRootPageController extends GetXBaseController {
  static MineRootPageController get to => Get.find();

  RxBool hasUnReadMsg = false.obs;

  Rx<UserDetailModel> info = UserDetailModel().obs;

  var isNeedRefresh= false;

  var arryWalletDic = [
    {
      "title": "钱包",
      "icon": Assets.minePage.mineQianbao.path,
    },
    {
      "title": "提现",
      "icon": Assets.minePage.mineTiXiang.path,
    },
    {
      "title": "活动中心",
      "icon": Assets.minePage.mineHuoDong.path,
    },
    {
      "title": "专属客服",
      "icon": Assets.minePage.mineKefu.path,
    },
  ];

  var arryDic = [
    {
      "title": "交易明细",
      "icon": Assets.minePage.mineMingXi.path,
    },
    {
      "title": "游戏记录",
      "icon": Assets.minePage.mineGameRecord.path,
    },
    {
      "title": "手机认证",
      "icon": Assets.minePage.minePhone.path,
    },
    {
      "title": "等级",
      "icon": Assets.minePage.mineLevel.path,
    },
    {
      "title": "粉丝交流群",
      "icon": Assets.minePage.mineFanGroup.path,
    },
    {
      "title": "设置",
      "icon": Assets.minePage.mineSet.path,
    },
  ];

  @override
  void onReady() {
    isNeedRefresh = true;
    // 调用
    getUnReadMsgNum();
    _getUserInfo();
  }

  _getUserInfo() async {
    UserProvider.getUserInfo().then((value) {
      if (value != null) {
        printInfo(info: "头像数据   ${info.value.avatar}");


        info.value = value;
      }
      UserManagerCache.shared.setUserDetail(value);
    });
  }

  getUnReadMsgNum() async {
    BaseResponse response = await MineMsgApis.of.getUnReadMsgNum();
    if (GetUtils.isNull(response.data) == true) {
      return;
    }
    final data = response.data as Map<String, dynamic>;
    hasUnReadMsg.value = (data['num'] as int? ?? 0) > 0;
  }
}
