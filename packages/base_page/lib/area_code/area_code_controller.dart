import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:services/models/res/login/country_code_bean.dart';
import 'package:services/provider/user_provider.dart';

/// 选择区域
class AreaCodeController extends GetXBaseController {
  List<CountryCodeBean> _codeListData = <CountryCodeBean>[];

  /// 搜索结果
  RxList<CountryCodeBean> searchCodeListData = <CountryCodeBean>[].obs;

  ///当前选择的区域
  Rx<CountryCodeBean> currentCode = CountryCodeBean().obs;

  @override
  void onInit() {
    _queryAllCountry();
    var arg = Get.arguments;
    if (arg != null && arg is CountryCodeBean) {
      currentCode.value = arg;
    }
    super.onInit();
  }

  ///国家编号
  _queryAllCountry() async {
    UserProvider.queryAllCountry().then((value) {
      if (value == null || value.isEmpty) {
        return;
      }
      _codeListData = value;
      search();
    });
  }

  /// 搜索
  search({String keyword = ""}) {
    if (keyword.isEmpty) {
      searchCodeListData.value = _codeListData;
    } else {
      searchCodeListData.value = _codeListData
          .where((element) => element.name?.contains(keyword) ?? false)
          .toList();
    }

    for (var element in searchCodeListData) {
      if (element.areaCode == currentCode.value.areaCode) {
        element = element.copyWith(checked: true);
      }
    }
  }
}
