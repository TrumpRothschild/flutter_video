import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/widgets/common_image.dart';
import 'package:services/models/res/live/anchor_card_bean.dart';
import 'package:services/models/res/live/live_anchor_bean.dart';

import 'widgets/anchor_wechat.dart';
import 'widgets/card_header.dart';
import 'widgets/card_progress.dart';

/// 主播名片

class AnchorCardDialogPage extends StatelessWidget {
  /// 主播信息
  final LiveAnchorBean? anchorVo;

  /// 主播名片信息
  final AnchorCardBean anchorCardBean;

  const AnchorCardDialogPage(
      {Key? key, required this.anchorVo, required this.anchorCardBean})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300,
      height: 400,
      child: Stack(
        children: [
          Assets.livePage.anchorCardDialogBg.image(
            width: 300,
            height: 400,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardHeader(
                  anchorNickname: anchorVo?.nickName ?? "",
                ),
                Center(
                  child: ClipOval(
                    child: CommonImage(
                      width: 55,
                      height: 55,
                      imageUrl: anchorVo?.avatar,
                    ),
                  ),
                ),
                /* const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          '我是写了签名的哦~真的有写啦。。。。。我可以写很长很长的这么长这么长这么长',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 16.8 / 12,
                          ),
                        ),
                      ),
                    ),*/
                AnchorWechat(
                  account: anchorCardBean.cardContact,
                  onTap: getWechatAccount,
                ),
                CardProgress(
                  anchorCard: anchorCardBean,
                ),
                const Text(
                  '1.添加时请备注昵称避免主播无法区分\n2.联系方式如有虚假可通过客服投诉',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 14.4 / 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void getWechatAccount() {
    if (anchorCardBean.currentAmount < anchorCardBean.maxLimit) {
      OLEasyLoading.showToast('获取名片进度未达到要求');
      return;
    }
  }
}
