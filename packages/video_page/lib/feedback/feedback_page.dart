import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:video_page/feedback/feedback_controller.dart';

class FeedBackPage extends GetView<FeedBackController> {
  const FeedBackPage({Key? key}) : super(key: key);

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
          title: AppBarCenterTitle(title: "feedback", controller: controller),
        ),
        body: GetBuilder<FeedBackController>(
            init: controller,
            builder: (_) => SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(20)),
                      height: width(80),
                      alignment: Alignment.centerLeft,
                      color: controller.currentCustomThemeData().colors0xF3F3F3,
                      child: Text(
                          videoPageTranslations['feedback_advice'].toString(),
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x979797,
                              fontSize: sp(24),
                              fontWeight: FontWeight.w400)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(20), vertical: width(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("*",
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xFF0000,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  videoPageTranslations[
                                          'please_select_a_question_category']
                                      .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width(16)),
                            child: Wrap(
                              children: [
                                ...controller.list.asMap().keys.map((e) =>
                                    InkWell(
                                      onTap: () {
                                        controller.changeType(e);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: width(48)),
                                        width: width(330),
                                        child: Row(
                                          children: [
                                            controller.questionType.value == e
                                                ? Container(
                                                    width: width(32),
                                                    height: width(32),
                                                    margin: EdgeInsets.only(
                                                        right: width(16)),
                                                    child: Image.asset(
                                                      Assets.videoPage
                                                          .vRadioSelect.path,
                                                      width: width(32),
                                                      height: width(32),
                                                    ),
                                                  )
                                                : Container(
                                                    width: width(32),
                                                    height: width(32),
                                                    margin: EdgeInsets.only(
                                                        right: width(16)),
                                                    child: Image.asset(
                                                      Assets.videoPage.vUn.path,
                                                      width: width(32),
                                                      height: width(32),
                                                    ),
                                                  ),
                                            Text(controller.list[e],
                                                style: TextStyle(
                                                    color: controller
                                                        .currentCustomThemeData()
                                                        .colors0x000000,
                                                    fontSize: sp(28),
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: width(20),
                      color: controller.currentCustomThemeData().colors0xF3F3F3,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(20), vertical: width(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              videoPageTranslations['detailed_description']
                                  .toString(),
                              style: TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0x000000,
                                  fontSize: sp(32),
                                  fontWeight: FontWeight.w600)),
                          Container(
                            height: width(290),
                            margin: EdgeInsets.only(top: width(24)),
                            color: controller
                                .currentCustomThemeData()
                                .colors0xF3F3F3,
                            padding: EdgeInsets.symmetric(horizontal: width(28))
                                .copyWith(bottom: width(12)),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        maxLines: 20,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(200)
                                        ],
                                        keyboardType: TextInputType.text,
                                        cursorColor: controller
                                            .currentCustomThemeData()
                                            .colors0x9F44FF,
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x000000,
                                            fontSize: sp(28)),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "不可为空，上限200字符",
                                          hintStyle: TextStyle(
                                              color: Color(0xff979797),
                                              fontSize: 14.0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                        focusNode: controller.titleFocus,
                                        controller: controller.titleCtr,
                                        onChanged: (String text) {
                                          controller.setTitle(text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: width(0),
                                  bottom: width(0),
                                  child: Text(
                                      controller.description.value
                                              .toString()
                                              .length
                                              .toString() +
                                          "/200",
                                      style: TextStyle(
                                          color: controller
                                              .currentCustomThemeData()
                                              .colors0x979797,
                                          fontSize: sp(24),
                                          fontWeight: FontWeight.w400)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: width(20),
                      color: controller.currentCustomThemeData().colors0xF3F3F3,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(20), vertical: width(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  videoPageTranslations[
                                          'upload_feedback_pictures']
                                      .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  videoPageTranslations['not_required']
                                      .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xD7D7D7,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(
                            height: width(28),
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width(32)),
                            child: Wrap(
                              spacing: width(20),
                              runSpacing: width(20),
                              children: [
                                ...controller.images
                                    .asMap()
                                    .keys
                                    .map((e) => SizedBox(
                                          width: width(200),
                                          height: width(200),
                                          child: Stack(
                                            children: [
                                              OLImage(
                                                imageUrl: controller.images[e]
                                                    .toString(),
                                                width: width(200),
                                                height: width(200),
                                              ),
                                              Positioned(
                                                  right: width(12),
                                                  top: width(12),
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.delImg(e);
                                                    },
                                                    child: Image.asset(
                                                      Assets.videoPage.vClose
                                                          .path,
                                                      width: width(40),
                                                      height: width(40),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )),
                                controller.images.length >= 6
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          controller.getImage();
                                        },
                                        child: Container(
                                          width: width(200),
                                          height: width(200),
                                          // margin: EdgeInsets.only(top: width(28)),
                                          alignment: Alignment.center,
                                          color: controller
                                              .currentCustomThemeData()
                                              .colors0xF7F8F8,
                                          child: Image.asset(
                                            Assets.videoPage.upload.path,
                                            width: width(60),
                                            height: width(60),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.submit();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: width(108)),
                            width: width(440),
                            height: width(80),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(width(40))),
                              color: controller.description.value.isNotEmpty
                                  ? controller
                                      .currentCustomThemeData()
                                      .colors0x9F44FF
                                  : controller
                                      .currentCustomThemeData()
                                      .colors0xD9D9D9,
                            ),
                            child: Text(
                                videoPageTranslations['submit'].toString(),
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xFFFFFF,
                                    fontSize: sp(32),
                                    fontWeight: FontWeight.w400)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width(40),
                    )
                  ],
                ))));
  }
}
