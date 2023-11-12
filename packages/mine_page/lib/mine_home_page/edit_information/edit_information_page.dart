import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_home_page/edit_information/models/info_cell_model.dart';
import 'package:services/image/ol_image.dart';

import 'edit_information_controller.dart';

class EditInformationPage extends GetView<EditInformationController> {
  EditInformationPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.backBlack.path,
            width: 10,
            height: 20,
          ),
        ),
        title: Text(
          "编辑个人资料",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: GetBuilder<EditInformationController>(
        builder: (controller) => ListView.separated(
          itemCount: controller.cells.length,
          separatorBuilder: (BuildContext context, int index) {
            return index == 4
                ? Divider(
                    color: controller.currentCustomThemeData().colors0xEBEAEA,
                    thickness: 10,
                  )
                : Divider(
                    color:
                        controller.currentCustomThemeData().colors0x000000_20,
                    thickness: 0.5,
                  );
          },
          itemBuilder: (BuildContext context, int index) {
            final model = controller.cells[index];
            Log.d(model.value);
            return InkWell(
              onTap: () {
                controller.onTap(model);
              },
              child: Container(
                height: 69,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        model.value == 'null' ? '' : model.value,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xAAAAAA,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _buildTrailing(model),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTrailing(InfoCellModel cell) {
    switch (cell.cellType) {
      case InfoCellType.avatar:
        return ClipOval(
          child: OLImage(
            imageUrl: cell.avatar,
            width: 40,
            height: 40,
          ),
        );
      case InfoCellType.valueOnly:
        return const SizedBox(width: 8);
      case InfoCellType.valuArrow:
        return Icon(
          Icons.navigate_next,
          color: controller.currentCustomThemeData().colors0xD9D9D9,
        );
    }
  }
}
