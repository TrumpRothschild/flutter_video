import 'package:flutter/material.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/capsule_container.dart';
import '../../widgets/common_image.dart';

class ShareSwiper extends StatefulWidget {
  const ShareSwiper({
    Key? key,
    required this.imageList,
    required this.onIndexChanged,
  }) : super(key: key);

  final List<String> imageList;
  final ValueChanged<int?> onIndexChanged;

  @override
  State<ShareSwiper> createState() => _ShareSwiperState();
}

class _ShareSwiperState extends State<ShareSwiper> {
  late ValueNotifier<int> _activeIndex;
  late final SwiperController _swiperController;

  @override
  void initState() {
    _activeIndex = ValueNotifier(0);
    _swiperController = SwiperController();

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
    return SizedBox(
      height: 445,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return _imageSliders[index];
              },
              itemCount: _imageSliders.length,
              viewportFraction: 0.8,
              scale: 0.9,
              onIndexChanged: widget.onIndexChanged,
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder(
            valueListenable: _activeIndex,
            builder: (BuildContext context, int activeIndex, Widget? child) =>
                AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: _imageSliders.length,
              onDotClicked: (index) {},
              effect: const ExpandingDotsEffect(
                spacing: 6.8,
                dotWidth: 10,
                dotHeight: 10,
                expansionFactor: 1.0000001,
                dotColor: Color(0xFFD9D9D9),
                activeDotColor: Color(0xFF656565),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> get _imgList => widget.imageList.isNotEmpty
      ? widget.imageList
      : [
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        ];

  List<Widget> get _imageSliders => _imgList
      .map(
        (item) => AspectRatio(
          aspectRatio: 307 / 445,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              child: Stack(
                children: <Widget>[
                  CommonImage(
                    width: 307,
                    height: 445,
                    imageUrl: item,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CapsuleContainer(
                          radius: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            children: const [
                              Text(
                                '苹果用户需要在：',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '“设置-通用-描述文件与设备管理”中，信任证书请妥善保存此二维码，如遇软件问题，请重新安装',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 14 / 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 17),
                        Container(
                          margin: const EdgeInsets.only(bottom: 22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            width: 65,
                            height: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '我是二维码',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .toList();
}
