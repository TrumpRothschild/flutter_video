import 'dart:async';

import 'package:base/app_event_bus.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/caches/ol_cache_manager.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base_page/common/notice_dialog_widget.dart';
import 'package:base_page/common/update_page.dart';
import 'package:base_page/constant/notice_type.dart';
import 'package:base_page/utils/app_version_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/apis.dart';
import 'package:services/models/event/video_paly_event.dart';
import 'package:services/models/event/video_personalized_event.dart';
import 'package:services/models/res/notice/notice_bean.dart';
import 'package:services/models/res/video/notice_content_bean.dart';
import 'package:services/models/res/video/notice_list_bean.dart';
import 'package:services/models/res/video/video_bean.dart';
import 'package:services/models/res/video/video_category_model.dart';
import 'package:services/models/res/video/video_page_list_bean.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/video_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoHomeController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  /// 分类列表
  RxList<VideoCategoryModel> tabListData = <VideoCategoryModel>[].obs;

  /// 当前页面的数据
  RxList<VideoPageListBean> curPageData = <VideoPageListBean>[].obs;
  RxBool buttonShow = false.obs;
  RxBool isCurrentVideo = false.obs;

  // ListView 拆分组装数据
  List<VideoPageListBean> get handleCurPageData {
    List<VideoPageListBean> newList = [];
    List<VideoBean> videos = [];
    num curColumnNum = -1;
    for (var i = 0; i < curPageData.length; i++) {
      final item = curPageData[i];
      final columnNum = item.columnNum ?? 0;
      if (item.refrenceType == 4 && columnNum > 1) {
        if (curColumnNum == -1) {
          // 记录需要的 数量
          curColumnNum = columnNum;
        }

        videos.add(item.video ?? VideoBean());

        // 达到 columnNum
        if (videos.length == curColumnNum) {
          newList.add(item..videos = List.from(videos));
          videos.clear();
          curColumnNum = -1;
        }
      } else {
        newList.add(item..videos = [item.video ?? VideoBean()]);
        videos.clear();
        curColumnNum = -1;
      }
    }
    return newList;
  }

  /// 存放页面的数据
  /// 存放分类ID与请求的数据 {'16':{},'17':{}}
  Map<String, dynamic> homePageCacheData = {};

  /// 默认选中的tab
  RxInt indexNum = 0.obs;

  /// 页码
  RxInt pageNum = 1.obs;

  //RxInt pageNum = 1.obs;
  /// 刷新和加载更多
  Map<String, RefreshController> controllers = {};

  /// 页码集合
  Map<String, dynamic> pageNums = {};

  RxInt videoId = 0.obs;
  RxString title = "".obs;
  RxString cover = "".obs;

  /// 当前选择的频道ID
  var curCategoryId = 0.obs;

  late final StreamSubscription<VideoPlayEvent> _videoSubscription;

  late final StreamSubscription<VideoPersonalizedEvent>
      _videoPersionSubscription;

  /// tab控制器
  TabController? tabController;

  @override
  void onInit() {
    _getVideoCategoryList();
    super.onInit();
  }

  @override
  void onReady() {
    // 公告弹框
    _getAdvNotice();

    getCurrentVideo();

    /// 播放
    _videoSubscription = eventBus.on<VideoPlayEvent>().listen((event) {
      title.value = event.videoTitle;
      cover.value = event.videoCover;
      videoId.value = event.videoId;
      isCurrentVideo.value = true;
    });

    /// 个性化定制
    _videoPersionSubscription =
        eventBus.on<VideoPersonalizedEvent>().listen((event) {
      _getVideoCategoryList();
      getCurrentVideo();
    });
  }

  @override
  void onClose() {
    _videoPersionSubscription.cancel();
    _videoSubscription.cancel();
  }

  /// 版本更新
  _checkNewVersion() async {
    CommonProvider.queryAppVersion("彩狐视频").then((value) async {
      if (value == null) {
        return;
      }
      int result = await AppVersionUtil.isUpdate(value.showVersion);
      if (1 == result || 2 == result) {
        Get.dialog(
            UpdatePage(
              controller: this,
              bean: value,
              isForce: 2 == result,
            ),
            // 设置背景透明是为了解决两个弹框背景重叠黑色加深问题
            barrierColor: Colors.transparent,
            barrierDismissible: 1 == result);
      }
    });
  }

  closeVideo() async {
    isCurrentVideo.value = false;
  }

  jumpVideo() {
    Get.toNamed(AppRoutes.videoDetailPage, arguments: {"id": videoId.value});
  }

  getCurrentVideo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    videoId.value = preferences.getInt("videoId") ?? 0;
    title.value = preferences.getString("videoTitle") ?? "";
    cover.value = preferences.getString("videoCover") ?? "";
    if (videoId.value > 0) {
      isCurrentVideo.value = true;
    } else {
      isCurrentVideo.value = false;
    }
  }

  Future<Map<String, dynamic>> _getVideoCategoryListCache() async {
    final data = await OLCacheManager.shared.getData(Apis.videoCategoryList);
    return data;
  }

  /// 获取分类数据
  _getVideoCategoryList() async {
    //Map<String, dynamic> data = await _getVideoCategoryListCache();
    VideoProvider.getVideoCategoryList().then((value) {
      if (value == null || value.isEmpty) {
        return;
      }
      /*var tmpData=[];
      if (data.isNotEmpty) {// 取并集
        final dataList = data["videoCategoryList"];
        List<VideoCategoryModel> saveList = [];
        for (var map in dataList) {
          VideoCategoryModel m = VideoCategoryModel.fromJson(map);
          for (var element in value) {
            if(element.id==m.id){
              tmpData.add(value);
            }
          }
        }
      } else {
        // 取接口bing
        tmpData=value;
      }*/
      tabController = TabController(
          length: value.length, vsync: this, initialIndex: indexNum.value);
      tabController?.addListener(() {
        ///避免addListener调用2次
        if (tabController?.index == tabController?.animation?.value) {
          indexNum.value = tabController?.index ?? 0;
          getCurrentPageData();
        }
      });
      tabListData.value = value;

      // 添加多个refreshController、添加多个页码集合
      controllers.clear();
      pageNums.clear();
      for (var i = 0; i < value.length; i++) {
        VideoCategoryModel model = value[i];
        RefreshController refreshController =
            RefreshController(initialRefresh: false);
        controllers[model.id.toString()] = refreshController;
        pageNums[model.id.toString()] = 1.obs;
      }

      _loadAllPageData(value);
    });
  }

  /// 全局公告,一条数据
  _getAdvNotice() {
    CommonProvider.getAdvNotice(NoticeType.homeNotice).then((value) {
      _showNoticeDialog(value);
    }).whenComplete(() {
      // 延迟0.5秒检测升级
      Future.delayed(const Duration(milliseconds: 500), () {
        _checkNewVersion();
      });
    });
  }

  /// 展示公告dialog
  _showNoticeDialog(NoticeBean? bean) {
    String noticeContent = bean?.noticeContent ?? "";
    if (noticeContent.isEmpty) {
      return;
    }
    // Get.dialog(NoticeDialogWidget(controller: this, bean: bean));
  }

  /// 获取当前页面的数据
  getCurrentPageData({bool isRefresh = false, bool isUpRefresh = false}) {
    var categoryId = tabListData[indexNum.value].id ?? 0;
    curCategoryId.value = categoryId;
    // 缓存key
    var key = categoryId.toString();
    if (homePageCacheData.isEmpty || !homePageCacheData.containsKey(key)) {
      _getVideoIndexPanel(categoryId);
    } else {
      if (isRefresh && !isUpRefresh) {
        // 下拉刷新清除缓存，重新加载数据
        homePageCacheData.remove(key);
        _getVideoIndexPanel(categoryId);
      } else if (isUpRefresh && !isRefresh) {
        // 上拉加载更多
        _getVideoIndexPanel(categoryId, isUpLoad: true);
      } else {
        curPageData.value = homePageCacheData[key];
        update([curCategoryId.value]);
      }
    }
  }

  /// 加载所有tab对应页面的数据，并存入缓存
  _loadAllPageData(List<VideoCategoryModel> categories) {
    if (categories.isEmpty) {
      return;
    }

    /// 当前分类ID
    curCategoryId.value = tabListData[indexNum.value].id ?? 0;
    for (var value in categories) {
      _getVideoIndexPanel(value.id ?? 0, isFirstLoad: true);
    }
  }

  /// 获取频道的数据
  _getVideoIndexPanel(int categoryId,
      {bool isFirstLoad = false, bool isUpLoad = false}) {
    final pageNum = pageNums[categoryId.toString()];
    const count = 5;
    Map<String, dynamic> params = {
      "categoryId": categoryId,
      "pageNum": pageNum,
      "pageSize": count,
    };
    // 切换清掉之前的数据
    VideoProvider.getVideoIndexPanel(params).then((value) {
      var data = value ?? [];
      // 数据加载完成
      RefreshController refreshController =
          controllers[categoryId.toString()] ??
              RefreshController(initialRefresh: false);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (data.length < count) {
        refreshController.loadNoData();
      }
      if (isFirstLoad) {
        homePageCacheData[categoryId.toString()] = data;
        if (curCategoryId.value == categoryId) {
          curPageData.value = data;
          update([curCategoryId.value]);
        }
      } else {
        List<VideoPageListBean> cacheData = data;
        if (isUpLoad) {
          cacheData = homePageCacheData[categoryId.toString()];
          cacheData.addAll(data);
        }
        homePageCacheData[categoryId.toString()] = cacheData;
        if (curCategoryId.value == categoryId) {
          curPageData.value = cacheData;
          update([curCategoryId.value]);
        }
      }
    });
  }

  /// 通过点击事件
  onclickNotice(NoticeListBean? item) {
    if (null != item) {
      NoticeContentBean bean =
          NoticeContentBean.fromJson(item.extraParam ?? "");
      if ("1" == bean.type) {
        /// 第三方游戏
        _onTapItem(bean.gameType, bean.categoryId);
      }
    }
  }

  _onTapItem(String? gameType, String? categoryId) {
    if (null == gameType || null == categoryId) {
      OLEasyLoading.showToast("数据有误，请重试！");
      return;
    }
    Get.toNamed(
      AppRoutes.gameWeb,
      arguments: {
        'gameType': gameType,
        'categoryId': int.parse(categoryId),
      },
    );
  }
}
