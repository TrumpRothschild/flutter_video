class AppVersionUpdateBean {
  AppVersionUpdateBean({
    String? appType, //app类型 1客户端, 2主播端
    String? code, //app客户端编码 ios/android
    String? content, //更新内容
    String? downUrl, //下载地址
    String? fileSize, //文件大小
    String? id, //id
    String? isForced, //强制更新 0不强制 1强制 ,
    String? isSilentDownload, //是否静默下载
    String? name, //app名称
    String? showVersion, //展示版本号
    String? updateTime, //更新时间
    String? upgradeVersion, //升级版本号
    String? isShow, //显示弹窗说明在设置页面手动触发  需要提示最新版本
    String? relativeDownUrl, //云相对路径
  }) {
    _appType = appType;
    _code = code;
    _content = content;
    _downUrl = downUrl;
    _fileSize = fileSize;
    _id = id;
    _isForced = isForced;
    _isSilentDownload = isSilentDownload;
    _name = name;
    _showVersion = showVersion;
    _updateTime = updateTime;
    _upgradeVersion = upgradeVersion;
    _isShow = isShow;
    _relativeDownUrl = relativeDownUrl;
  }

  AppVersionUpdateBean.fromJson(dynamic json) {
    _appType = json['appType'];
    _code = json['code'];
    _content = json['ontent'];
    _downUrl = json['downUrl'];
    _fileSize = json['fileSize'];
    _id = json['id'];
    _isForced = json['isForced'];
    _isSilentDownload = json['isSilentDownload'];
    _name = json['name'];
    _showVersion = json['showVersion'];
    _updateTime = json['updateTime'];
    _upgradeVersion = json['upgradeVersion'];
    _isShow = json['isShow'];
    _relativeDownUrl = json['relativeDownUrl'];
  }

  String? _appType; //app类型 1客户端, 2主播端
  String? _code; //app客户端编码 ios/android
  String? _content; //更新内容
  String? _downUrl; //下载地址
  String? _fileSize; //文件大小
  String? _id; //id
  String? _isForced; //强制更新 0不强制 1强制 ,
  String? _isSilentDownload; //是否静默下载
  String? _name; //app名称
  String? _showVersion; //展示版本号
  String? _updateTime; //更新时间
  String? _upgradeVersion; //升级版本号
  String? _isShow; //显示弹窗说明在设置页面手动触发  需要提示最新版本
  String? _relativeDownUrl; //云相对路径

  String? get appType => _appType;

  String? get code => _code;

  String? get relativeDownUrl => _relativeDownUrl;

  String? get isShow => _isShow;

  String? get upgradeVersion => _upgradeVersion;

  String? get updateTime => _updateTime;

  String? get showVersion => _showVersion;

  String? get name => _name;

  String? get isSilentDownload => _isSilentDownload;

  String? get isForced => _isForced;

  String? get id => _id;

  String? get fileSize => _fileSize;

  String? get downUrl => _downUrl;

  String? get content => _content;

}
