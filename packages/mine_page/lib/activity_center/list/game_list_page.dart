import 'package:base/app_routes.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/live/live_action_bean.dart';

class GameListPage extends StatefulWidget {
  final CustomTheme customTheme;
  final List<LiveActionBean> list;

  const GameListPage({
    Key? key,
    required this.customTheme,
    required this.list,
  }) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage>
    with AutomaticKeepAliveClientMixin {


  String formatDate(String inputDateString) =>
      DateFormat("yyyy-MM-dd").format(
          DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(inputDateString));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: widget.list.length,
      itemBuilder: (_, int index) {
        final item = widget.list[index];
        return InkWell(
          onTap: () {
            if (item.link?.isNotEmpty ?? false) {
              if(item.permanent ?? false) {
                Get.toNamed(
                  AppRoutes.activityCenterWeb,
                  arguments: item.link,
                );
              } else {
                if(null != item.startDate) {
                  if(!isStartTime(item.startDate!)) {
                    OLEasyLoading.showToast("活动于${formatDate(item.startDate!)} 开始，谢谢！");
                    return;
                  }
                  Get.toNamed(
                    AppRoutes.activityCenterWeb,
                    arguments: item.link,
                  );
                }
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: widget.customTheme.colors0xFFFFFF,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 338 / 125,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: OLImage(
                      imageUrl: item.imgUrl ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.activityName ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.customTheme.colors0x9F44FF,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.customTheme.colors0x6129FF,
                            widget.customTheme.colors0xD96CFF,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        item.permanent ?? false
                            ?  '活动时间：永久有效'
                            : (isStartTime(item.startDate??'')
                              ? '活动时间：${formatDate(item.startDate??'')}-${formatDate(item.endDate??'')}' : '活动时间：还未开始' ),
                        style: TextStyle(
                          color: widget.customTheme.colors0xFFFFFF,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }

  @override
  bool get wantKeepAlive => true;


  /// 比较time时间是不是在当前时间之前
  bool isStartTime(String time) {
    try {
      var now = DateTime.now();
      var item = DateTime.parse(time);
      return now.isAfter(item);
    } catch (e) {
      print(e);
    }
    return true;
  }
}
