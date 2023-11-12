part of 'email_msg_list_page.dart';

class EmailMsgListController extends GetXBaseController {
  late final RefreshController refreshController;

  List<MineMsgBean> get emailMsgs => _emailMsgs;
  final _emailMsgs = <MineMsgBean>[].obs;

  int _pageNum = 1;
  int _total = 0;

  void clearMsg() {
    _emptyMsg().then((succ) {
      if (succ) {
        _emailMsgs.clear();
      }
    });
  }

  void onTapMsg(MineMsgBean msg) {
    _readMessage([msg.id]).then((succ) {
      if (succ && !isClosed) {
        msg.isRead = true;
        _emailMsgs.refresh();
      }
    });
    // Get.toNamed(
    //   AppRoutes.onlineService,
    //   arguments: AppConstant.keFuUrl,
    // );
    // Get.toNamed(
    //   AppRoutes.emailMsgDetail,
    //   arguments: msg,
    // );
  }

  onRefresh() async {
    _pageNum = 1;
    _getMsgList();
  }

  onLoad() async {
    _pageNum += 1;
    _getMsgList();
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
    _emailMsgs.close();
    super.onClose();
  }

  _getMsgList() async {
    try {
      BaseResponse response = await MineMsgApis.of.getMessageList(
        msgType: 2,
        pageNum: _pageNum,
      );
      if (GetUtils.isNull(response.data) == true) {
        if (_pageNum == 1) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
        return;
      }
      final dataJson = response.data as Map<String, dynamic>;
      MsgPageBean msgPageBean = MsgPageBean.fromJson(dataJson);
      _total = msgPageBean.total;
      if (_pageNum == 1) {
        _emailMsgs.clear();
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else {
        refreshController.loadComplete();
      }
      _emailMsgs.addAll(msgPageBean.list);
      if (emailMsgs.length >= _total) {
        refreshController.loadNoData();
      }
    } catch (e) {
      if (_pageNum == 1) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
      OLEasyLoading.dismiss();
    }
  }

  Future<bool> _emptyMsg() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse response = await MineMsgApis.of.emptyMessage(
        msgType: 1,
      );
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

  Future<bool> _readMessage(List<int> ids) async {
    BaseResponse response = await MineMsgApis.of.readMessage(ids: ids);
    if (GetUtils.isNull(response.data) == true) {
      return false;
    }

    return response.data == true;
  }
}
