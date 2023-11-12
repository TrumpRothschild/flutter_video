part of 'live_end_page.dart';

class LiveEndController extends GetXBaseController {
  List<HomeLiveBean> get lives => _lives.value;
  final RxList<HomeLiveBean> _lives = [
    HomeLiveBean(
      chargeType: 6,
      price: 666,
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      chargeType: 6,
      price: 100,
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      chargeType: 6,
      price: 888,
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
    HomeLiveBean(
      studioThumbImage:
          'https://img.91momo50.vip/picture/2023/01/05/1778195068378228384.w.jpg?auth_key=1677034203546-2a71c7dbaaca45e7a8df84f88aeabae1-0-b4efa759a88204c7db8391b6146fafe4',
    ),
  ].obs;

  Future<bool> onRefresh(_) async {
    return false;
  }

  Future<bool> onLoadMore(_) async {
    return false;
  }
}
