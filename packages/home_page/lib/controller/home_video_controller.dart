import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_video_bean.dart';
import 'package:services/provider/home_provider.dart';

///首页星秀controller
class HomeVideoController extends GetXBaseController
    with StateMixin<List<HomeVideoBean>?> {
  /// 有更多数据
  var hasMoreData = false.obs;

  /// 页码
  RxInt pageNum = 1.obs;

  /// 视频列表数据
  RxList<HomeVideoBean> videData = RxList.empty();

  var searchTime = DateTime.now().millisecondsSinceEpoch / 1000;

  @override
  void onInit() {
    getSearchVideo();
    super.onInit();
  }

  ///根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  getSearchVideo({String title = ""}) async {
    Map<String, dynamic> params = {
      "pageSize": AppConstant.pageSize,
      "pageNum": pageNum.value,
      "searchTime": searchTime
    };
    //标题
    if (GetUtils.isNullOrBlank(title) == false) {
      params["title"] = title;
    }

    HomeProvider.getSearchVideo(params).then((value) {
      if (pageNum.value == 1) {
        videData.clear();
      }
      //是否有更多数据
      hasMoreData = RxBool((value ?? []).isNotEmpty);
      videData.addAll(value ?? []);
      change(videData, status: RxStatus.success());
    },
        onError: (err) =>
            {change(null, status: RxStatus.error(err.toString()))});
  }
}
