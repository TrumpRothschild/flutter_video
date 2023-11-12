import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/provider/home_provider.dart';

///首页热门、游戏、附近、星秀、体育controller
class HomeOtherController extends GetXBaseController
    with StateMixin<List<HomeLiveBean>?> {
  /// 有更多数据
  var hasMoreData = false.obs;

  /// 栏目code
  RxString? columnCode = "".obs;

  /// 直播列表数据
  RxList<HomeLiveBean> liveData = RxList.empty();

  ///根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  getLiveByColumnCode({String studioNum = ""}) async {
    Map<String, dynamic> params = {
      "pageSize": AppConstant.pageSize,
      "columnCode": columnCode?.value
    };
    //此房间号后面的直播间，可以为空
    if (GetUtils.isNullOrBlank(studioNum) == false) {
      params["studioNum"] = studioNum;
    }
    HomeProvider.getLiveByColumnCode(params).then((value) {
      if (GetUtils.isNullOrBlank(studioNum) == true) {
        // 第一页
        liveData.clear();
      }
      //是否有更多数据
      hasMoreData = RxBool((value ?? []).isNotEmpty);
      liveData.addAll(value ?? []);
      change(liveData, status: RxStatus.success());
    },
        onError: (err) =>
            {change(null, status: RxStatus.error(err.toString()))});
  }

  /// 获取最后一条房间号
  String getLastStudioNum() {
    var len = liveData.length;
    return liveData[len - 1].studioNum ?? "";
  }
}
