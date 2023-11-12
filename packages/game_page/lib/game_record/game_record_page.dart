import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/utils/app_date_utils.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'game_record_controller.dart';
import '../widgets/tab_indicator.dart';

/// GameRecord
class GameRecordPage extends GetBaseView<GameRecordController> {
  const GameRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xF6F5FB,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: controller.currentCustomThemeData().colors0x000000),
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "游戏记录",
          style: TextStyle(
              color: controller.currentCustomThemeData().colors0x000000,
              fontSize: 16),
        ),
      ),
      body: controller.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color:
                            controller.currentCustomThemeData().colors0xD9D9D9),
                  )),
              child: TabBar(
                indicatorColor:
                    controller.currentCustomThemeData().colors0xFFFFFF,
                labelColor: controller.currentCustomThemeData().colors0x000000,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor:
                    controller.currentCustomThemeData().colors0xA5A5A5,
                isScrollable: false,
                indicator: const TabBarIndicator(height: 3),
                tabs: controller.tabs.mapIndexed((item, index) {
                  return Tab(
                    child: Text(controller.tabs[index]),
                  );
                }).toList(),
                controller: controller.tabController, // 记得要带上tabController
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.5),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '携带量总金额：${NumberUtil.formatNum(state?.totalBetAmount?.toDouble() ?? 0.00, 2) }',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xAFA8CF,
                    ),
                    textAlign: TextAlign.start,
                  )),
                  Expanded(
                      child: Text(
                    '盈利总金额：${NumberUtil.formatNum(state?.totalWinAmount?.toDouble() ?? 0.00, 2)}',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xAFA8CF,
                    ),
                    textAlign: TextAlign.end,
                  )),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: List.generate(
                  controller.tabs.length,
                  (index) => ListView.separated(
                    itemCount: state?.list?.length ?? 0,
                    itemBuilder: (_, int index) {
                      final item = state?.list?[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                _RecordItem(
                                  name: '投注时间：',
                                  value: AppDateUtils.apiTime(AppDateUtils.timestampToDate(item?.netAt?.toInt() ?? 0))
                                ),
                                _RecordItem(
                                  name: '携带量：',
                                  value: NumberUtil.formatNum(item?.betAmount?.toDouble() ?? 0.00, 2),
                                  valueColor: Colors.red,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _RecordItem(
                                  name: '游戏名称：',
                                  value: '${item?.gameName}',
                                ),
                                _RecordItem(
                                  name: '用户盈利：',
                                  value: NumberUtil.formatNum(item?.winAmount?.toDouble() ?? 0.00, 2),
                                  valueColor: Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final String name;
  final String value;
  final Color valueColor;

  const _RecordItem({
    required this.name,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(color: Color(0xffB1B1B1), fontSize: 14),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
