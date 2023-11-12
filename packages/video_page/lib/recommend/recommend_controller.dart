import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/models/req/video/video_search_param.dart';
import 'package:services/models/res/video/video_bean.dart';
import 'package:services/provider/video_provider.dart';

class RecommendPageController extends GetXBaseController
    with StateMixin<List<VideoBean>?> {
  /// 标题
  RxString title = "".obs;

  /// 搜索关键字
  var keyword = "";
  int sortType = 0;

  /// 有更多数据
  var hasMoreData = false.obs;

  ///第几页
  RxInt pageNum = 1.obs;

  /// 视频列表数据
  RxList<VideoBean> videoData = RxList.empty();

  @override
  void onInit() {
    title.value = Get.arguments?["title"] ?? '';
    sortType = Get.arguments?["sortType"] ?? 0;
    videoSearch();
    super.onInit();
  }

  videoSearch() async {
    VideoSearchParam param = VideoSearchParam(
      pageNum: pageNum.value,
      pageSize: 20, //AppConstant.pageSize,
      // mosaicFlag: -1,
      // subtitleFlag: -1,
      sortType: sortType,
    );
    VideoProvider.videoSearch(param).then((value) {
      if (pageNum.value == 1) {
        // 第一页
        videoData.clear();
      }
      //是否有更多数据
      hasMoreData = RxBool((value ?? []).isNotEmpty);
      videoData.addAll(value ?? []);
      change(videoData, status: RxStatus.success());
    }, onError: (err) {
      Log.e("视频搜索失败【${err.toString()}】");
    });
  }
}
