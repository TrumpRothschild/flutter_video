import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:services/models/res/live/live_gift_bean.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/common_image.dart';
import '../gift_list_page.dart';

/// 选中礼物回调
typedef SelectCallback = Function(LiveGiftBean bean);

class GiftSwiper extends StatefulWidget {
  const GiftSwiper({
    Key? key,
    required this.giftList,
    required this.callback,
  }) : super(key: key);

  final List<LiveGiftBean> giftList;
  final SelectCallback callback;

  @override
  State<GiftSwiper> createState() => _GiftSwiperState();
}

class _GiftSwiperState extends State<GiftSwiper> {
  late ValueNotifier<int> _activeIndex;
  late final SwiperController _swiperController;

  late int _swiperCount;
  final int _itemCountPerSwiper = 8;
  late int _itemCountOfLastSwiper = 8;

  @override
  void initState() {
    _activeIndex = ValueNotifier(0);
    _swiperController = SwiperController();
    // 总的礼物数据
    int total = widget.giftList.length;
    _swiperCount = total ~/ _itemCountPerSwiper;
    if (total % _itemCountPerSwiper > 0) {
      _swiperCount += 1;
      _itemCountOfLastSwiper = _swiperCount % _itemCountPerSwiper;
    }
    super.initState();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    _activeIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Swiper(
            layout: SwiperLayout.DEFAULT,
            key: UniqueKey(),
            itemCount: _swiperCount,
            loop: false,
            autoplay: false,
            onIndexChanged: (index) {
              _activeIndex.value = index ?? 0;
            },
            itemBuilder: (BuildContext context, int index) {
              // 每页集合大小
              List<LiveGiftBean> curGiftList = widget.giftList
                  .skip(index * _itemCountPerSwiper)
                  .take(_itemCountPerSwiper)
                  .toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 76 / 85,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                ),
                itemCount: index == _swiperCount - 1
                    ? _itemCountOfLastSwiper
                    : _itemCountPerSwiper,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  LiveGiftBean bean = curGiftList[index];
                  return InkWell(
                    onTap: () => widget.callback(bean),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonImage(
                            width: 65, height: 65, imageUrl: bean.imageUrl),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              bean.giftName ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.livePage.giftDiamond.image(
                                  width: 21,
                                  height: 14,
                                ),
                                Text(
                                  (bean.price ?? 0).toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _activeIndex,
          builder: (BuildContext context, int activeIndex, Widget? child) =>
              AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: _swiperCount,
            onDotClicked: (index) {},
            effect: ExpandingDotsEffect(
              spacing: 4,
              dotWidth: 5,
              dotHeight: 5,
              expansionFactor: 1.0000001,
              dotColor: Colors.white.withOpacity(0.4),
              activeDotColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
