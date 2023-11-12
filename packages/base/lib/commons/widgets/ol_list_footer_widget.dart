
import 'package:base/commons/utils/screen.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

class ListFooterWidget extends StatelessWidget {

  ListFooterWidget({Key? key});

  Widget _getFooter() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            videoPageTranslations['up_loading_more'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text(
            videoPageTranslations['loading_failed_try_again'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(videoPageTranslations['release_loading_more'].toString(),
              style:
              TextStyle(color: const Color(0xff999999), fontSize: sp(28)));
        } else {
          body = Text(
            videoPageTranslations['loading_no_data'].toString(),
            style: TextStyle(color: const Color(0xff999999), fontSize: sp(28)),
          );
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getFooter();
  }
}