import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../live_page.dart';

/// 举报
class LiveReport extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();

  final List<String> reasons;

  LiveReport(this.reasons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimens.w_10),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: _decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _reasonWidget(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: AppDimens.h_10, bottom: AppDimens.h_30),
          decoration: _decoration,
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Text(
                '取消',
                style: TextStyle(
                  color: _controller.currentCustomThemeData().colors0x777777,
                  fontSize: FontDimens.fontSp20,
                ),
              )),
        )
      ],
    );
  }

  /// 举报原因
  List<Widget> _reasonWidget() {
    return reasons
        .map(
          (reason) => InkWell(
            onTap: () {
              Get.back();
              OLEasyLoading.showToast('感谢您的举报，我们会尽快作出处理');
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppDimens.h_16),
              decoration: reason != reasons.last
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _controller
                              .currentCustomThemeData()
                              .colors0xEBEBEB,
                        ),
                      ),
                    )
                  : null,
              child: Text(
                reason,
                style: TextStyle(
                  color: _controller.currentCustomThemeData().colors0x9F44FF,
                  fontSize: FontDimens.fontSp24,
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
