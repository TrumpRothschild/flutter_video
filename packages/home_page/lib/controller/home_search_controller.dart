import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/models/res/home/home_search_bean.dart';
import 'package:services/models/res/home/home_video_bean.dart';
import 'package:services/provider/home_provider.dart';

///首页搜索controller
class HomeSearchController extends GetXBaseController {
  /// 搜索框控制器
  final TextEditingController searchTec = TextEditingController();

  /// 关注推荐
  RxList<HomeLiveBean> focusRecommendData = <HomeLiveBean>[].obs;

  /// 搜索历史
  RxList<HomeLiveBean> historyData = <HomeLiveBean>[].obs;

  /// 搜索主播信息
  RxList<AnchorList> searchData = <AnchorList>[].obs;

  /// 搜索直播信息
  RxList<HomeLiveBean> searchLiveData = <HomeLiveBean>[].obs;

  /// 视频列表数据
  RxList<HomeVideoBean> videData = RxList.empty();

  /// 是否触发了搜索
  RxBool isSearch = false.obs;

  var searchTime = DateTime.now().millisecondsSinceEpoch / 1000;

  @override
  void onInit() {
    _getBrowseHistory();
    getLiveFocusRecommendList();
    super.onInit();
  }

  /// 关注页推荐的直播房间列表,不包含已经关注的房间
  getLiveFocusRecommendList() async {
    HomeProvider.getLiveFocusRecommendList().then((value) {
      focusRecommendData.value = value ?? [];
    });
  }

  /// 获取最近浏览
  _getBrowseHistory() async {
    HomeProvider.getBrowseHistory().then((value) {
      historyData.value = value ?? [];
    });
  }

  /// 获取直播搜索
  _getLiveSearch(String context) async {
    Map<String, dynamic> params = {"context": context};
    HomeProvider.getLiveSearch(params).then((value) {
      searchData.value = value?.anchorList ?? [];
      searchLiveData.value = value?.studioList ?? [];
    });
  }

  ///搜索视频
  _getSearchVideo(String title) async {
    Map<String, dynamic> params = {
      "pageSize": AppConstant.pageSize,
      "pageNum": 1,
      "searchTime": searchTime,
      "title": title
    };
    HomeProvider.getSearchVideo(params).then((value) {
      videData.value = value ?? [];
    });
  }

  /// 处理搜索逻辑
  handleSearch(String tabCode, String context) {
    if (GetUtils.isNull(context) || context.isEmpty) {
      return;
    }
    isSearch.value = true;
    if (tabCode == "star") {
      // 星秀
      _getSearchVideo(context);
    } else {
      // 直播
      _getLiveSearch(context);
    }
  }
}
