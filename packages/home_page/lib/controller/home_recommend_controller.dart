import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base_page/constant/banner_code.dart';
import 'package:base_page/constant/notice_type.dart';
import 'package:get/get.dart';
import 'package:services/models/res/banner/banner_bean.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/models/res/home/home_top_game_bean.dart';
import 'package:services/models/res/home/home_video_bean.dart';
import 'package:services/models/res/notice/notice_bean.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/home_provider.dart';

/// 首页推荐controller
class HomeRecommendController extends GetXBaseController {
  /// 查询时间
  Rx<num> searchTime = 0.obs;

  /// 页码
  RxInt pageNum = 1.obs;

  /// 有更多数据
  var hasMoreData = false.obs;

  /// 推荐列表顶部游戏
  RxList<HomeTopGameBean> topGameData = RxList.empty();

  /// 直播列表数据
  RxList<HomeLiveBean> liveData = RxList.empty();

  /// 推荐列表数据
  RxList<HomeLiveBean> recommendLiveData = RxList.empty();

  /// 热门视频列表数据
  RxList<HomeVideoBean> hotVideData = RxList.empty();

  /// 轮播图数据
  RxList<BannerBean> bannerData = RxList.empty();

  /// 循环公告
  Rx<NoticeBean?> noticeBeanData = NoticeBean().obs;

  @override
  void onInit() {
    _getTopGameList();
    _getAdvNotice();
    _getHotVideoList();
    getLiveList();
    _getBannerList();
    super.onInit();
  }

  ///获取首页tab数据
  getLiveList() async {
    Map<String, dynamic> params = {
      "pageNum": pageNum.value,
      "pageSize": AppConstant.pageSize,
    };
    if (pageNum.value > 1 && searchTime > 0) {
      params["searchTime"] = searchTime;
    }
    HomeProvider.getLiveList(params).then((value) {
      searchTime.value = value?.searchTime ?? 0;
      if (pageNum.value == 1) {
        liveData.clear();
        recommendLiveData.clear();
      }
      var tmpData = value?.list ?? [];
      //是否有更多数据
      hasMoreData = RxBool(tmpData.isNotEmpty);
      if (tmpData.length <= 4) {
        recommendLiveData.value = tmpData;
      } else {
        tmpData.asMap().forEach((key, value) {
          if (key < 4) {
            recommendLiveData.add(value);
          } else {
            liveData.add(value);
          }
        });
      }
    });
  }

  /// 首页推荐列表顶部游戏
  _getTopGameList() {
    HomeProvider.getTopGameList().then((value) {
      topGameData.value = value ?? [];
    });
  }

  /// 轮播图广告位查询，根据code
  _getBannerList() {
    CommonProvider.getBannerList(BannerCode.index).then((value) {
      bannerData.value = value ?? [];
    });
  }

  /// 全局公告,一条数据
  /// type 3循环公告
  _getAdvNotice() {
    CommonProvider.getAdvNotice(NoticeType.marquee).then((value) {
      noticeBeanData.value = value;
    });
  }

  ///热门视频 获取10个视频(随机)
  _getHotVideoList() async {
    HomeProvider.getHotVideoList().then((value) {
      hotVideData.value = value ?? [];
    });
  }
}
