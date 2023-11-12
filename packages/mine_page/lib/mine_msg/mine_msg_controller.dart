part of 'mine_msg_page.dart';

class MineMsgController extends GetXBaseController {
  List<MineMsgBean> get latestNews => _latestNews;
  final _latestNews = <MineMsgBean>[].obs;

  final isAllReaded = false.obs;

  void clearAllUnread() {
    _readAllMessage().then((succ) {
      if (succ) {
        isAllReaded.value = true;
        if (AppConfig.app == EnvApp.video) {
          MineController.to.getUnReadMsgNum();
        } else {
          MineRootPageController.to.getUnReadMsgNum();
        }
      }
    }).whenComplete(() {
      if (AppConfig.app == EnvApp.video) {
        MineController.to.getUnReadMsgNum();
      } else {
        MineRootPageController.to.getUnReadMsgNum();
      }
    });
  }

  void onTapMsg(MineMsgBean msg) {
    _readMessage([msg.id]).then((succ) {
      if (succ && !isClosed) {
        msg.isRead = true;
        _latestNews.refresh();
      }
    }).whenComplete(() {
      if (AppConfig.app == EnvApp.video) {
        MineController.to.getUnReadMsgNum();
      } else {
        MineRootPageController.to.getUnReadMsgNum();
      }
    });
    switch (msg.msgType) {
      case 1:
        Get.toNamed(AppRoutes.sysMsgList);
        break;
      case 2:
        Get.toNamed(AppRoutes.emailMsgList);
        break;
    }
  }

  @override
  void onInit() {
    getLatestNews();
    super.onInit();
  }

  @override
  void onClose() {
    _latestNews.close();
    isAllReaded.close();
    super.onClose();
  }

  getLatestNews() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse response = await MineMsgApis.of.getLatestNews();
      if (GetUtils.isNull(response.data) == true||response.data.length==0) {
        OLEasyLoading.dismiss();
        return;
      }

      final dataList = response.data as List;
      OLEasyLoading.dismiss();
      if (dataList.isEmpty) return;
      _latestNews.clear();
      _latestNews.addAll(dataList.map((e) => MineMsgBean.fromJson(e)));
      OLEasyLoading.dismiss();
    } catch (e) {
      print(e);
      OLEasyLoading.dismiss();
    }
  }

  Future<bool> _readMessage(List<int> ids) async {
    try {
      BaseResponse response = await MineMsgApis.of.readMessage(ids: ids);
      if (GetUtils.isNull(response.data) == true) {
        return false;
      }

      return response.data == true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _readAllMessage() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse response = await MineMsgApis.of.readAllMessage();
      if (GetUtils.isNull(response.data) == true) {
        return false;
      }
      OLEasyLoading.dismiss();
      return response.data == true;
    } catch (e) {
      OLEasyLoading.dismiss();
      return false;
    }
  }
}
