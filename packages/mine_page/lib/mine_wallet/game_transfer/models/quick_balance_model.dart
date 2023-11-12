class QuickBalanceModel {
  final String title;
  final int value;
  bool isSelected;

  QuickBalanceModel({
    required this.title,
    required this.value,
    this.isSelected = false,
  });
}
