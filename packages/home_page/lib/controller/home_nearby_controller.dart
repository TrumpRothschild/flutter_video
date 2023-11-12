import 'package:base/app_contant.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/models/res/home/home_location_bean.dart';
import 'package:services/provider/home_provider.dart';

///首页附近controller
class HomeNearbyController extends GetXBaseController {
  /// 有更多数据
  var hasMoreData = false.obs;

  /// 栏目code
  final String _columnCode = "nearby";

  /// 直播列表数据
  RxList<HomeLiveBean> liveData = RxList.empty();

  ///
  Rx<HomeLocationBean?> locationData = HomeLocationBean().obs;

  /// 国家code
  final RxString? countryCode = "".obs;

  /// 省code
  final RxString? provinceCode = "".obs;

  @override
  void onInit() {
    _getCountryProvince();
    super.onInit();
  }

  ///根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  ///国家编码,columnCode = nearby 可以查询其他国家，'other':查询用户当前国家以外的直播间 ，null：不限制国家
  ///省编码,columnCode = nearby 可以查询其他国家，'other':查询用户当前国家以外的直播间 ，null：不限制国家
  getLiveByColumnCode({String studioNum = ""}) async {
    Map<String, dynamic> params = {
      "pageSize": AppConstant.pageSize,
      "columnCode": _columnCode,
      "countryCode": countryCode?.value,
      "provinceCode": provinceCode?.value
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
    });
  }

  /// 获取最后一条房间号
  String getLastStudioNum() {
    var len = liveData.length;
    return liveData[len - 1].studioNum ?? "";
  }

  /// 定位当前国家省
  _getCountryProvince() {
    HomeProvider.getCountryProvince().then((value) {
      locationData.value = value;
      // 获取附近直播信息
      countryCode?.value = value?.countryCode ?? "";
      provinceCode?.value = value?.provinceCode ?? "";
      getLiveByColumnCode();
    });
  }
}
