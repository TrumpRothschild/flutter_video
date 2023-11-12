import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/user/bank_model.dart';

class ItemBank extends StatefulWidget {
  final CustomTheme customTheme;
  final BankModel item;
  final VoidCallback? onDelete;

  const ItemBank({
    Key? key,
    required this.customTheme,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ItemBank> createState() => _ItemBankState();
}

class _ItemBankState extends State<ItemBank> {
  late final ValueNotifier<bool> _showDelete;

  @override
  void initState() {
    _showDelete = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _showDelete.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showDelete,
      builder: (BuildContext context, bool showDelete, Widget? child) {
        return GestureDetector(
          onTap: () {
            _showDelete.value = false;
          },
          onLongPress: () {
            _showDelete.value = true;
          },
          child: Container(
            padding: const EdgeInsets.all(10).copyWith(left: 24),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: showDelete ? widget.customTheme.colors0x000000_30 : null,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: widget.customTheme.colors0x9F9F9F),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          widget.item.bankLogo ?? '',
                          height: 28,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                    Text(
                      widget.item.bankAccountNo ?? '',
                      style: TextStyle(
                        color: widget.customTheme.colors0x000000,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                if (showDelete)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: widget.onDelete,
                      child: Container(
                        height: 25,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.customTheme.colors0xFFFFFF,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          '删除',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.customTheme.colors0x000000,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
