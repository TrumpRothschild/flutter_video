/// content : ""
/// id : 0
/// ticketId : 0

class NiuExplainModel {
  NiuExplainModel({
    this.content,
    this.id,
    this.ticketId,
  });

  NiuExplainModel.fromJson(dynamic json) {
    content = json['content'];
    id = json['id'];
    ticketId = json['ticketId'];
  }

  String? content;
  num? id;
  num? ticketId;

  NiuExplainModel copyWith({
    String? content,
    num? id,
    num? ticketId,
  }) =>
      NiuExplainModel(
        content: content ?? this.content,
        id: id ?? this.id,
        ticketId: ticketId ?? this.ticketId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['id'] = id;
    map['ticketId'] = ticketId;
    return map;
  }
}
