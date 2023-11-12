class UserOccupationModel {
  final int id;
  final String occupationCode;
  final String occupationName;

  UserOccupationModel({
    this.id = 0,
    this.occupationCode = '',
    this.occupationName = '',
  });

  factory UserOccupationModel.fromJson(Map<String, dynamic> json) =>
      UserOccupationModel(
        id: json['id'] as int? ?? 0,
        occupationCode: json['occupationCode']?.toString() ?? '',
        occupationName: json['occupationName']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'occupationCode': occupationCode,
        'occupationName': occupationName,
      };
}
