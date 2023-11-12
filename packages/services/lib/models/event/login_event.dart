/// 登录事件参数
class LoginEvent {
  /// 1 游客登录 2 账户密码登录
  int type;

  LoginEvent(this.type);
}
