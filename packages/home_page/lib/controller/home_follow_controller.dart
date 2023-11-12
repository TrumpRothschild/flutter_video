import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/provider/home_provider.dart';

/// 首页关注controller
class HomeFollowController extends GetXBaseController
    with StateMixin<List<HomeLiveBean>?> {
  /// 有更多数据
  var hasMoreData = false.obs;

  /// 关注主播列表数据
  RxList<HomeLiveBean> liveData =<HomeLiveBean>[].obs;

  /// 关注推荐
  RxList<HomeLiveBean> focusRecommendData =<HomeLiveBean>[].obs;

  @override
  onInit() {
    getLiveFocusList();
    getLiveFocusRecommendList();
    super.onInit();
  }

  /// 关注的直播房间列表
  getLiveFocusList({String studioNum = ""}) async {
    Map<String, dynamic> params = {"pageSize": AppConstant.pageSize};
    //标题
    if (GetUtils.isNullOrBlank(studioNum) == false) {
      params["studioNum"] = studioNum;
    }

    HomeProvider.getLiveFocusList(params).then((value) {
      if (GetUtils.isNullOrBlank(studioNum) == true) {
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

  /// 关注页推荐的直播房间列表,不包含已经关注的房间
  getLiveFocusRecommendList() async {
    HomeProvider.getLiveFocusRecommendList().then((value) {
      focusRecommendData.value=value??[];
    });
  }

  /// 获取最后一条房间号
  String getLastStudioNum() {
    var len = liveData.length;
    return liveData[len - 1].studioNum ?? "";
  }
}
