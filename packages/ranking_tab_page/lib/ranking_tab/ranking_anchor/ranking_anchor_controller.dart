part of 'ranking_anchor_page.dart';

class RankingAnchorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  List<RankingUserBean> get users => _list.value;
  final _list = <RankingUserBean>[].obs;

  RankingDateType _dateType = RankingDateType.day;

  List<RankingDateType> dateTypes = [
    RankingDateType.day,
    RankingDateType.week,
    RankingDateType.month,
  ];

  int get itemCount => users.length > 3 ? (users.length - 3) : 0;

  RankingUserBean? get userNo1 => users.isNotEmpty
      ? users[0]
      : RankingUserBean(
          nickName: '虚位以待',
          position: 1,
        );
  RankingUserBean? get userNo2 => users.length > 1
      ? users[1]
      : RankingUserBean(
          nickName: '虚位以待',
          position: 2,
        );
  RankingUserBean? get userNo3 => users.length > 2
      ? users[2]
      : RankingUserBean(
          nickName: '虚位以待',
          position: 3,
        );

  Future<void> toggleFocus(RankingUserBean? user) async {
    if (user == null) return;
    final isFocus = user.isFocus;
    OLEasyLoading.showLoading('');
    final succ = isFocus
        ? await RankingUserProvider.unfocusUser(
            focusUserId: user.userId,
          )
        : await RankingUserProvider.focusUser(
            focusUserId: user.userId,
          );
    OLEasyLoading.dismiss();
    if (succ) {
      user.isFocus = !user.isFocus;
      _list.refresh();
    }
  }

  void _listenTabChange() {
    if (tabController.indexIsChanging) return;
    final index = tabController.index;
    if (index >= dateTypes.length) return;
    final newDateType = dateTypes[index];
    _dateType = newDateType;
    _loadList();
  }

  Future<void> _loadList() async {
    OLEasyLoading.showLoading('');
    final res = await RankingUserProvider.getAnchorList(
      isPrevious: false,
      type: _dateType.index + 1,
    );
    res.add(RankingUserBean(position:0,avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
      fansCount:1,nickName:"李四",distance:1112));
    res.add(RankingUserBean(position:1,avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));
    res.add(RankingUserBean(position:2,avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));
    res.add(RankingUserBean(avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));
    res.add(RankingUserBean(avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));
    res.add(RankingUserBean(avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));

    res.add(RankingUserBean(avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));

    res.add(RankingUserBean(avatar:"https://storage.haihcoudata.top/live/others/2022/11/19/1760793853900600032.png",
        fansCount:1,nickName:"李四",distance:1112));

    _list.addAll(res);
    OLEasyLoading.dismiss();
  }

  @override
  void onInit() {
    tabController = TabController(
      length: dateTypes.length,
      vsync: this,
    )..addListener(_listenTabChange);
    _loadList();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    _list.close();
    super.onClose();
  }
}
