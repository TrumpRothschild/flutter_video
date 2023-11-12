import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/purchased_movies/purchased_movies_controller.dart';

class PurchasedMoviesPage extends GetView<PurchasedMoviesController> {
  const PurchasedMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          leading: AppBarBackButton(),
          title: AppBarCenterTitle(title: "purchased_movies", controller: controller),
          actions: [
            InkWell(
                child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: width(30)),
              child: Text(videoPageTranslations['edit'].toString(),
                  style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x7A7A7A,
                      fontSize: sp(28),
                      fontWeight: FontWeight.w400)),
            ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: width(28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: width(12),
                    runSpacing: width(18),
                    children: [
                      SizedBox(
                        width: width(340),
                        child: Column(
                          children: [
                            const CardView(
                              flag: false,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: width(10), bottom: width(48)),
                              child: Text(
                                "名字可以很长很长很长很长很长很长很长很长",
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x000000,
                                    fontSize: sp(24)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width(340),
                        child: Column(
                          children: [
                            const CardView(
                              flag: false,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: width(10), bottom: width(48)),
                              child: Text(
                                "名字可以很长很长很长很长很长很长很长很长",
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x000000,
                                    fontSize: sp(24)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width(340),
                        child: Column(
                          children: [
                            const CardView(
                              flag: false,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: width(10), bottom: width(48)),
                              child: Text(
                                "名字可以很长很长很长很长很长很长很长很长",
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x000000,
                                    fontSize: sp(24)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
            Divider(
              color: controller.currentCustomThemeData().colors0xF4F4F4,
            ),
            SizedBox(
              height: width(80),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          videoPageTranslations['select_all'].toString(),
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x000000,
                              fontSize: sp(28),
                              fontWeight: FontWeight.w400)),
                    ),
                  )),
                  Container(
                    width: width(1),
                    height: width(30),
                    color: controller.currentCustomThemeData().colors0xF4F4F4,
                  ),
                  Expanded(
                      child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          videoPageTranslations['delete'].toString() + '(1)',
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xF82D2D,
                              fontSize: sp(28),
                              fontWeight: FontWeight.w400)),
                    ),
                  )),
                ],
              ),
            )
          ],
        ));
  }
}
