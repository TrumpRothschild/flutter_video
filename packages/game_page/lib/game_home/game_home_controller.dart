import 'dart:async';
import 'package:base/app_event_bus.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/models/event/balance_refresh.dart';
import 'package:services/models/res/game/game_banner_bean.dart';
import 'package:services/models/res/game/game_bean.dart';
import 'package:services/provider/common_provider.dart';

import 'game_home_provider.dart';

class GameHomeController extends GetXBaseController {
  static GameHomeController get to => Get.find();

  /// 跑马灯
  final RxString marqueeContent = ''.obs;

  /// banner
  final RxList<GameSlideData> bannerList = <GameSlideData>[].obs;

  /// 游戏tab
  final RxList<GameBean> gameTabData = <GameBean>[].obs;

  /// 游戏列表
  final RxList<GameList> gameListData = <GameList>[].obs;

  final RxString amount = "0.0".obs;

  ///点击下标
  final RxInt selectedIndex = 0.obs;

  //是否打开标签
  final RxBool _showDialogOpen = false.obs;

  get showDialogOpen => _showDialogOpen.value;

  set showDialogOpen(value) => _showDialogOpen.value = value;

  StreamSubscription? _balanceSubscription;

  @override
  void onInit() {
    _oneKeyRecovery();
    _getBannerList();
    _getAdvNotice();
    _getGameData();
    super.onInit();
    // getUserWallet();
    // 监听刷新余额消息
    _balanceSubscription = eventBus.on<BalanceEvent>().listen((event) {
      Future.delayed(const Duration(seconds: 2), () {
        _oneKeyRecovery();
      });
    });
  }

  /// 一键回收游戏钱包余额
  _oneKeyRecovery() async {
    CommonProvider.oneKeyRecovery().then((value) => {getUserWallet()},
        onError: (error) => {getUserWallet()});
  }

  ///获取游戏页面的list数据
  _getGameData() async {
    GameHomeProvider.getGameData().then(
      (value) {
        if (value == null) {
          return;
        }
        gameTabData.value = value;
        update(["gameTabData"]);
        updateGameList(selectedIndex.value);
      },
    );
  }

  ///获取游戏页面的banner数据
  _getBannerList() async {
    GameHomeProvider.getBannerList().then((value) {
      if (value != null) {
        bannerList.value = value;
        update(["gameBannerData"]);
      }
    });
  }

  ///获取游戏页面的notice数据
  _getAdvNotice() async {
    GameHomeProvider.getAdvNotice().then((value) {
      if (value != null) {
        marqueeContent.value = value.noticeContent ?? '';
        update(["gameNoticeData"]);
      }
    });
  }

  ///获取余额
  getUserWallet() async {
    CommonProvider.getUserWallet().then(
      (value) {
        amount.value = value?.amount ?? "0.0";
        update(["userWalletData"]);
      },
      onError: (err) => {},
    );
  }

  @override
  void onClose() {
    _balanceSubscription?.cancel();
  }

  onTapItem(GameList game) {
    var gameType = _getGameTypeByCode(game.gameCode);
    if (gameType.isEmpty) {
      OLEasyLoading.showToast("数据有误，请重试！");
      return;
    }
    Get.toNamed(
      AppRoutes.gameWeb,
      arguments: {
        'gameType': gameType,
        'categoryId': game.categoryId,
      },
    );
  }

  void toTransactionPage() {
    Get.toNamed(
      AppRoutes.gameTransaction,
    );
  }

  ///通过code获取type
  String _getGameTypeByCode(String? code) {
    if (code == null || code.isEmpty) {
      return "";
    }
    var codes = code.split('_');
    return codes[codes.length - 1];
  }

  /// 更新游戏列表
  void updateGameList(int index) {
    selectedIndex.value = index;
    update(["gameTabData"]);
    var gameList = gameTabData[index].gameList;
    if (gameList != null) {
      gameListData.value = gameList;
      update(["gameListData"]);
    }
  }
}
