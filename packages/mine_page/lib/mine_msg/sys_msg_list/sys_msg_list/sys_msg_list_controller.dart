part of 'sys_msg_list_page.dart';

class SysMsgListController extends GetXBaseController {
  late final RefreshController refreshController;

  List<MineMsgBean> get sysMsgs => _sysMsgs;
  final _sysMsgs = <MineMsgBean>[].obs;

  int _pageNum = 1;
  int _total = 0;

  void clearMsg() {
    _emptyMsg().then((succ) {
      if (succ) {
        _sysMsgs.clear();
      }
    });
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
    _sysMsgs.close();
    super.onClose();
  }

  _getMsgList() async {
    try {
      BaseResponse response = await MineMsgApis.of.getMessageList(
        msgType: 1,
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
        _sysMsgs.clear();
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else {
        refreshController.loadComplete();
      }
      _sysMsgs.addAll(msgPageBean.list);
      if (sysMsgs.length >= _total) {
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
}
