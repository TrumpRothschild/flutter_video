enum InfoCellType {
  avatar,
  valueOnly,
  valuArrow,
}

enum InfoCellActionType {
  avatar,
  nickname,
  none,
  gender,
  sign,
  birthday,
  emotion,
  hometowm,
  job,
}

class InfoCellModel {
  final String title;
  String value;
  String avatar;
  final InfoCellType cellType;
  final InfoCellActionType cellActionType;

  InfoCellModel({
    required this.title,
    this.value = '',
    this.avatar = '',
    this.cellType = InfoCellType.valuArrow,
    required this.cellActionType,
  });
}
