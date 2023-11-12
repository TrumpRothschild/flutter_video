import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:super_tooltip/super_tooltip.dart';

class GiftFooter extends StatefulWidget {
  const GiftFooter(this.userWallet, {Key? key, required}) : super(key: key);

  final UserWalletModel? userWallet;

  @override
  State<GiftFooter> createState() => _GiftFooterState();
}

class _GiftFooterState extends State<GiftFooter> {
  late final ValueNotifier<double> _arrowTurns;
  late final SuperTooltip _tooltip;

  final Map<int, String> _quickGifts = {
    1314: '一生一世',
    520: '我爱你',
    188: '要抱抱',
    66: '六六大顺',
    30: '想你',
    10: '十全十美',
    1: '一心一意',
  };

  late final ValueNotifier<int> _selectedQuickGift;

  void _rotateArrow(BuildContext context) {
    _arrowTurns.value += 0.5;
    if (_tooltip.isOpen) {
      _tooltip.close();
      return;
    }
    _tooltip.show(context);
  }

  void _onQuickGiftChanged(int newGiftKey) {
    _selectedQuickGift.value = newGiftKey;
    _tooltip.close();
  }

  void _sendGift() {
    OLEasyLoading.showToast("赠送礼物");
  }

  @override
  void initState() {
    _arrowTurns = ValueNotifier(0);
    _selectedQuickGift = ValueNotifier(1);

    _tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      arrowTipDistance: 15,
      borderColor: const Color(0xFFECECEC),
      borderWidth: 1,
      shadowColor: const Color(0x1A000000),
      shadowBlurRadius: 30,
      shadowSpreadRadius: 0,
      onClose: () {
        _arrowTurns.value += 0.5;
      },
      content: Material(
        child: SizedBox(
          width: 125,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: _quickGifts.keys.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final key = _quickGifts.keys.toList()[index];
              return InkWell(
                onTap: () {
                  _onQuickGiftChanged(key);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30 / 14 / 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFF1F1F1),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$key',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${_quickGifts[key]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9F44FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    if(_tooltip!=null){
      _tooltip.close();
    }
    _selectedQuickGift.dispose();
    _arrowTurns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserWalletModel? wallet = widget.userWallet;
    return Container(
      color: Colors.black.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '钻石：',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: wallet?.silverBean ?? "0.0",
                          style: const TextStyle(
                            color: Color(0xFFFFE601),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '余额：',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: wallet?.balance ?? "0.0",
                          style: const TextStyle(
                            color: Color(0xFFFFE601),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.livePage.anchorUnfollowBg.path,
                    ),
                  ),
                ),
                child: const Text(
                  '兑换钻石',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(1),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFCC60FF),
                      Color(0xFF5420C2),
                    ],
                  ),
                ),
                child: Builder(
                  builder: (ctx) => Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        _rotateArrow(ctx);
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          ValueListenableBuilder(
                            valueListenable: _selectedQuickGift,
                            builder: (BuildContext context, int giftKey,
                                Widget? child) {
                              return Text(
                                '$giftKey',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _arrowTurns,
                            builder: (BuildContext context, double turns,
                                    Widget? child) =>
                                AnimatedRotation(
                              duration: const Duration(milliseconds: 200),
                              turns: turns,
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _sendGift,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 12,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      Assets.livePage.anchorUnfollowBg.path),
                                ),
                              ),
                              child: const Text(
                                '赠送',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SafeArea(
            top: false,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
