/// categoryId : 0
/// gameCode : ""
/// gameId : ""
/// iconUrl : ""
/// id : 0
/// name : ""
/// skipModel : 0
/// skipType : 0
/// skipUrl : ""

class HomeTopGameBean {
  HomeTopGameBean({
    num? categoryId,
    String? gameCode,
    String? gameId,
    String? iconUrl,
    num? id,
    String? name,
    num? skipModel,
    num? skipType,
    String? skipUrl,
  }) {
    //游戏分类ID
    _categoryId = categoryId;
    //游戏code
    _gameCode = gameCode;
    //游戏id
    _gameId = gameId;
    //图标url
    _iconUrl = iconUrl;
    //主键ID
    _id = id;
    //名称
    _name = name;
    //跳转类型 1.链接 2.游戏 3.APP内页面
    _skipModel = skipModel;
    //链接跳转类型 1:原生页面 2:原生H5 3:浏览器
    _skipType = skipType;
    //跳转链接
    _skipUrl = skipUrl;
  }

  HomeTopGameBean.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _gameCode = json['gameCode'];
    _gameId = json['gameId'];
    _iconUrl = json['iconUrl'];
    _id = json['id'];
    _name = json['name'];
    _skipModel = json['skipModel'];
    _skipType = json['skipType'];
    _skipUrl = json['skipUrl'];
  }

  num? _categoryId;
  String? _gameCode;
  String? _gameId;
  String? _iconUrl;
  num? _id;
  String? _name;
  num? _skipModel;
  num? _skipType;
  String? _skipUrl;

  HomeTopGameBean copyWith({
    num? categoryId,
    String? gameCode,
    String? gameId,
    String? iconUrl,
    num? id,
    String? name,
    num? skipModel,
    num? skipType,
    String? skipUrl,
  }) =>
      HomeTopGameBean(
        categoryId: categoryId ?? _categoryId,
        gameCode: gameCode ?? _gameCode,
        gameId: gameId ?? _gameId,
        iconUrl: iconUrl ?? _iconUrl,
        id: id ?? _id,
        name: name ?? _name,
        skipModel: skipModel ?? _skipModel,
        skipType: skipType ?? _skipType,
        skipUrl: skipUrl ?? _skipUrl,
      );

  num? get categoryId => _categoryId;

  String? get gameCode => _gameCode;

  String? get gameId => _gameId;

  String? get iconUrl => _iconUrl;

  num? get id => _id;

  String? get name => _name;

  num? get skipModel => _skipModel;

  num? get skipType => _skipType;

  String? get skipUrl => _skipUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['gameCode'] = _gameCode;
    map['gameId'] = _gameId;
    map['iconUrl'] = _iconUrl;
    map['id'] = _id;
    map['name'] = _name;
    map['skipModel'] = _skipModel;
    map['skipType'] = _skipType;
    map['skipUrl'] = _skipUrl;
    return map;
  }
}
