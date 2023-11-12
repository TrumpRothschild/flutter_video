part of 'live_game_center_page.dart';

class LiveGameCenterController extends GetXBaseController {
  final List<GameTabModel?> gameTabs;

  LiveGameCenterController(this.gameTabs);

  static LiveGameCenterController get to => Get.find();

  int tabIndex = 0;

  List<LiveGameModel?> games = [];

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  void onTab(int index) async {
    if (index != tabIndex) {
      tabIndex = index;
      _getData();
    }
  }

  void _getData() {
    OLEasyLoading.showLoading('');
    LiveProvider.getLiveGameList(code: gameTabs[tabIndex]?.code ?? '').then(
      (list) {
        games = list;
        update();
      },
    ).whenComplete(
      () => OLEasyLoading.dismiss(),
    );
  }

  void onItemTap(LiveGameModel? model) {
    if (model?.isThird ?? false) {
      Get.toNamed(
        AppRoutes.gameWeb,
        arguments: {
          'gameType': model?.gameCode,
          'categoryId': model?.categoryId,
        },
      );
      return;
    }
    Get.bottomSheet(
      LiveGamePage(
        gameName: TicketUtils.getTicketName(model?.gameCode),
        headerImgUrl: model?.iconUrl,
        ticketId: TicketUtils.getTicketId(model?.gameCode),
      ),
    );
  }
}
