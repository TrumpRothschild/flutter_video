import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_detail/models/transaction_type_bean.dart';

class TransactionFilter extends StatefulWidget {
  const TransactionFilter({
    Key? key,
    required this.onConfirm,
    required this.transactionTypes,
    required this.selectedTransactionTypes,
  }) : super(key: key);

  final List<TransactionTypeBean> transactionTypes;
  final List<TransactionTypeBean> selectedTransactionTypes;
  final ValueChanged<List<TransactionTypeBean>> onConfirm;

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  late final List<TransactionTypeBean> _selectedTransactionTypes;

  void _onTapItem(TransactionTypeBean bean) {
    if (_selectedTransactionTypes.map((e) => e.code).contains(bean.code)) {
      _selectedTransactionTypes
          .removeWhere((element) => element.code == bean.code);
    } else {
      _selectedTransactionTypes.add(bean);
    }
    setState(() {});
  }

  void _onConfirm() {
    if (_selectedTransactionTypes.isEmpty) {
      OLEasyLoading.showToast('请先选择交易类型');
      return;
    }
    Get.back();
    widget.onConfirm(_selectedTransactionTypes);
  }

  @override
  void initState() {
    _selectedTransactionTypes = [];
    _selectedTransactionTypes.addAll(widget.selectedTransactionTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 17),
              InkWell(
                onTap: Get.back,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _onConfirm();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '确定',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 17),
            ],
          ),
          const Divider(color: Color(0xFFEEEEEE)),
          Flexible(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 95 / 35,
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
              ),
              itemCount: widget.transactionTypes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final type = widget.transactionTypes[index];
                final isSelected = _selectedTransactionTypes.contains(type);
                return InkWell(
                  onTap: () {
                    _onTapItem(type);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF9F44FF).withOpacity(0.1)
                              : null,
                          border: Border.all(
                            color: const Color(0xFF9F44FF),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            type.value,
                            style: const TextStyle(
                              color: Color(0xFF9F44FF),
                            ),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Align(
                          alignment: Alignment.topRight,
                          child: Transform.translate(
                            offset: const Offset(5, -5),
                            child: const Icon(
                              Icons.check_circle,
                              color: Color(0xFF9F44FF),
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 21),
            child: Text(
              '（可多选）',
              style: TextStyle(
                color: Color(0xFF9F9F9F),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
