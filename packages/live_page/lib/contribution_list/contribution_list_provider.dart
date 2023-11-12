import 'package:get/get.dart';
import 'package:live_page/contribution_list/models/contribution_user_bean.dart';
import 'package:services/api/live_apis.dart';
import 'package:services/models/res/base_response.dart';

class ContributionListProvider extends GetConnect {
  /// 获取直播间推荐直播
  static Future<List<ContributionUserBean>> getContributionList({
    required int dateType,
  }) async {
    BaseResponse response = await LiveApis.of().getContributionList(
      dateType: dateType,
    );
    if (GetUtils.isNull(response.data) == true) {
      return [];
    }

    final dataArr = response.data as List;
    return dataArr
        .map((e) => ContributionUserBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
