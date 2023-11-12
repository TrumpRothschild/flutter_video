part of 'contribution_list_page.dart';

class ContributionListController extends GetxController {
  List<ContributionUserBean> get users => _list.value;
  final _list = <ContributionUserBean>[].obs;

  RankingDateType _dateType = RankingDateType.day;

  List<RankingDateType> dateTypes = [
    RankingDateType.day,
    RankingDateType.week,
    RankingDateType.month,
  ];

  int get itemCount => users.length > 3 ? (users.length - 3) + 1 : 1;

  ContributionUserBean? get userNo1 => users.isNotEmpty
      ? users[0]
      : ContributionUserBean(
          userName: '虚位以待',
        );
  ContributionUserBean? get userNo2 => users.length > 1
      ? users[1]
      : ContributionUserBean(
          userName: '虚位以待',
        );
  ContributionUserBean? get userNo3 => users.length > 2
      ? users[2]
      : ContributionUserBean(
          userName: '虚位以待',
        );

  void onDateTypeChanged(RankingDateType newDateType) {
    _dateType = newDateType;
    _loadList();
  }

  @override
  void onInit() {
    _loadList();
    super.onInit();
  }

  Future<void> _loadList() async {
    OLEasyLoading.showLoading('');
    final res = await ContributionListProvider.getContributionList(
      dateType: _dateType.index + 1,
    );

    _list.addAll(res);
    OLEasyLoading.dismiss();
  }
}
