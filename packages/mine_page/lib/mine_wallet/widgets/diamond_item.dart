import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:mine_page/mine_wallet/mine_wallet_page.dart';
import 'package:mine_page/mine_wallet/widgets/stadium_border_button.dart';
import 'package:mine_page/transaction_detail/transaction_detail_controller.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

class DiamondItem extends StatelessWidget {
  const DiamondItem({
    Key? key,
    required this.controller,
    required this.wallet,
  }) : super(key: key);

  CustomTheme get _customTheme => controller.currentCustomThemeData();
  final MineWalletController controller;
  final UserWalletModel wallet;

  Widget getDiamondWidget() {
    final isVideo = AppConfig.app == EnvApp.video;
    return isVideo
        ? Row(
            children: [
              Text(
                '钻石',
                style: TextStyle(
                  color: _customTheme.colors0xFFFFFF,
                  fontSize: 19,
                ),
              ),
              const SizedBox(width: 52),
              Text(
                wallet.silverBean ?? '',
                style: TextStyle(
                  color: _customTheme.colors0xFFFFFF,
                  fontSize: 25,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget getSendDiamondWidget() {
    final isVideo = AppConfig.app == EnvApp.video;
    return isVideo
        ? Row(
            children: [
              Text(
                '送出钻石',
                style: TextStyle(
                  color: _customTheme.colors0xFFFFFF,
                  fontSize: 19,
                ),
              ),
              const SizedBox(width: 13),
              Text(
                NumberUtil.formatNum(double.parse(wallet.sumGiveSilverBean ?? '0.00'), 2),
                style: TextStyle(
                  color: _customTheme.colors0xFFFFFF,
                  fontSize: 25,
                ),
              ),
              const Spacer(),
              StadiumBorderButton(customTheme: _customTheme, title: '兑换钻石'),
            ],
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = AppConfig.app == EnvApp.live;
    return isVideo
        ? AspectRatio(
            aspectRatio: 355 / 170,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Assets.minePage.diamondBg.image(fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              controller
                                  .toTransferList(TransactionPageType.diamond);
                            },
                            child: Text(
                              '交易明细>',
                              style: TextStyle(
                                color: _customTheme.colors0xFFFFFF,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      getDiamondWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: SizedBox(
                          width: 108,
                          child: Divider(
                            color: _customTheme.colors0xFFFFFF_20,
                          ),
                        ),
                      ),
                      getSendDiamondWidget(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
