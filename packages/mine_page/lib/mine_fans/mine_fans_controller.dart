import 'package:base/bases/get_base_controller.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';

import '../models/page_model.dart';

class MineFansController extends GetXBaseController {
  late final RefreshController refreshController;

  List<UserDetailModel> get fansUsers => _fansUsers;
  final _fansUsers = <UserDetailModel>[].obs;

  int _pageNum = 1;
  int _total = 0;

  void onTapItem(UserDetailModel user) {}

  void onRefresh() async {
    _pageNum = 1;
    _getFocusList();
  }

  void onLoading() async {
    _pageNum += 1;
    _getFocusList();
  }

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    refreshController.requestRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  _getFocusList() async {
    UserDetailModel? userDetail = UserManagerCache.shared.getUserDetail();

    if (userDetail?.id == null) {
      return;
    }
    try {
      BaseResponse res = await CommonApis.of().getFansList(
        pageNum: _pageNum,
        userId: userDetail?.id ?? 0,
        pageSize: 15,
      );
      if (GetUtils.isNull(res.data) == true) {
        if (_pageNum == 1) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
        return;
      }
      final dataJson = res.data as Map<String, dynamic>;

      if (dataJson['list'] != null && dataJson['list'] is List) {
        final list = dataJson['list'] as List;
        final listModel = list
            .map(
              (e) => UserDetailModel.fromJson(e),
            )
            .toList();
        dataJson['list'] = listModel;
      }
      PageModel<UserDetailModel> pageModel =
          PageModel<UserDetailModel>.fromJson(dataJson);
      _total = pageModel.total;
      if (_pageNum == 1) {
        _fansUsers.clear();
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else {
        refreshController.loadComplete();
      }
      _fansUsers.addAll(pageModel.list);
      if (fansUsers.length >= _total) {
        refreshController.loadNoData();
      }
    } catch (e) {
      if (_pageNum == 1) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    }
  }
}
