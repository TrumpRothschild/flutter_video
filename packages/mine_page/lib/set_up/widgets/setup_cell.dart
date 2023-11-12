import 'package:base/res/app_dimens.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mine_page/set_up/set_up_controller.dart';

class SetupCell extends StatelessWidget {
  const SetupCell({
    Key? key,
    required this.customTheme,
    this.onTap,
    required this.cellModel,
  }) : super(key: key);

  final CustomTheme customTheme;
  final ValueChanged<SetupCellModel>? onTap;
  final SetupCellModel cellModel;

  void _onCellTap() {
    if (cellModel.cellType != SetupCellType.onOff) {
      onTap?.call(cellModel);
    }
  }

  void _onSwitchChanged(value) {
    onTap?.call(cellModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onCellTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.h_12).copyWith(left: AppDimens.w_25),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: customTheme.colors0xF5F5F5 ?? Colors.transparent,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cellModel.title,
              style: TextStyle(
                color: customTheme.colors0x000000,
                fontSize: 16,
              ),
            ),
            Builder(
              builder: (context) {
                switch (cellModel.cellType) {
                  case SetupCellType.arrow:
                    return Icon(
                      Icons.navigate_next,
                      color: customTheme.colors0xA0A0A0,
                      size: 22,
                    );
                  case SetupCellType.subtitle:
                    assert(cellModel.subtitle.isNotEmpty, 'must set subtitle');
                    if (cellModel.subtitle.isNotEmpty) {
                      return Text(
                        cellModel.subtitle,
                        style: TextStyle(
                          color: customTheme.colors0x000000,
                          fontSize: 16,
                        ),
                      );
                    }
                    return const SizedBox();
                  case SetupCellType.onOff:
                    return Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: cellModel.isOn,
                        onChanged: _onSwitchChanged,
                      ),
                    );
                  case SetupCellType.grident:
                    assert(cellModel.subtitle.isNotEmpty, 'must set subtitle');
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            customTheme.colors0x6129FF,
                            customTheme.colors0xD96CFF,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        cellModel.subtitle,
                        style: TextStyle(
                          color: customTheme.colors0xFFFFFF,
                          fontSize: 16,
                        ),
                      ),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
