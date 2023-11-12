import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelConfirmSheet extends StatefulWidget {
  const CancelConfirmSheet({
    Key? key,
    required this.customTheme,
    required this.selectedItem,
    required this.items,
    required this.onConfirm,
  }) : super(key: key);

  final CustomTheme customTheme;
  final String selectedItem;
  final List<String> items;
  final ValueChanged<String> onConfirm;

  @override
  State<CancelConfirmSheet> createState() => _CancelConfirmSheetState();
}

class _CancelConfirmSheetState extends State<CancelConfirmSheet> {
  late String _selectedItem;

  _onConfirm() {
    widget.onConfirm(_selectedItem);
  }

  _onItemTap(String newItem) {
    if (_selectedItem == newItem) return;
    _selectedItem = newItem;
    setState(() {});
  }

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.customTheme.colors0xFFFFFF,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32)
                  .copyWith(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: Get.back,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: widget.customTheme.colors0x000000,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _onConfirm,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '确定',
                        style: TextStyle(
                          color: widget.customTheme.colors0x000000,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.items.length,
                    (index) {
                      final item = widget.items[index];
                      final isSelected = _selectedItem == item;
                      return InkWell(
                        onTap: () {
                          _onItemTap(item);
                        },
                        child: Container(
                          width: double.infinity,
                          color: isSelected
                              ? widget.customTheme.colors0xECECEC
                              : null,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: widget.customTheme.colors0x000000,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
