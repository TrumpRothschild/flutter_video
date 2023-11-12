import 'dart:developer';
import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'area_code_controller.dart';

/// 选择区域页面
class AreaCodePage extends GetView<AreaCodeController> {
  AreaCodePage({Key? key}) : super(key: key);

  final TextEditingController searchKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            log("返回");
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.backBlack.path,
            width: 10,
            height: 20,
          ),
        ),
        title: Text(
          "选择分区号",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: controller.currentCustomThemeData().colors0x7032FF,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    padding: EdgeInsets.zero,
                    height: 30,
                    onPressed: () {
                      controller.search(keyword: searchKey.text);
                    },
                    child: Image.asset(
                      Assets.basePage.phoneSearch.path,
                      width: 15,
                      height: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.search(keyword: searchKey.text);
                      },
                      onSubmitted: (value) {
                        controller.search(keyword: searchKey.text);
                      },
                      controller: searchKey,
                      // maxLength: 15,
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                        // labelText: "手机号",
                        border: InputBorder.none,
                        // 去掉下滑线
                        counterText: '',
                        // 去除输入框底部的字符计数
                        hintText: "请输入国家",
                        hintStyle: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000_20,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        // prefix: prefix,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "当前选择",
              // textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                color: controller.currentCustomThemeData().colors0x000000,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    "${controller.currentCode.value.name ?? ""}(${controller.currentCode.value.areaCode})",
                    style: TextStyle(
                      fontSize: 12,
                      color: controller.currentCustomThemeData().colors0x000000,
                    ),
                  );
                }),
                Expanded(child: Container()),
                Image.asset(
                  Assets.basePage.dagou.path,
                  width: 12,
                  height: 9,
                ),
              ],
            ),
            SizedBox(
              height: 29,
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: controller.searchCodeListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return item(index);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(int index) {
    var item = controller.searchCodeListData[index];
    return InkWell(
      onTap: () {
        log("点击了");
        controller.currentCode.value = item;
        Get.back(result: controller.currentCode.value);
      },
      child: SizedBox(
        height: 30,
        child: Text(
          "${item.name ?? ""}(${item.areaCode})",
          style: TextStyle(
            fontSize: 12,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
    );
  }
}
