///用户钱包信息
class UserWalletModel {
  String? withdrawalMax;
  String? payMax;
  String? withdrawalFirst;
  String? sumRechargeAmount;
  String? amount;
  bool? isWithdrawal;
  String? minWithdraw;
  String? payFirst;
  String? payNum;
  String? sumWithdrawAmount;
  String? balance;
  String? walletType;
  String? walletName;
  String? sumAccountDml;
  String? czExChange;
  String? shortcutOptionsUnit;
  String? walletId;
  String? currencyUint;
  String? silverBean;
  String? withdrawalNum;
  String? sumGiveSilverBean;
  String? gameWallet;
  String? fee;
  String? accountDml;
  String? txExChange;
  String? desc;
  String? userId;

  UserWalletModel(
      {withdrawalMax,
      payMax,
      withdrawalFirst,
      sumRechargeAmount,
      amount,
      isWithdrawal,
      minWithdraw,
      payFirst,
      payNum,
      sumWithdrawAmount,
      balance,
      walletType,
      walletName,
      sumAccountDml,
      czExChange,
      shortcutOptionsUnit,
      walletId,
      currencyUint,
      silverBean,
      withdrawalNum,
      sumGiveSilverBean,
      gameWallet,
      fee,
      accountDml,
      txExChange,
      desc,
      userId});

  UserWalletModel.fromJson(Map<String, dynamic> json) {
    withdrawalMax = json['withdrawalMax'].toString();
    payMax = json['payMax'].toString();
    withdrawalFirst = json['withdrawalFirst'].toString();
    sumRechargeAmount = json['sumRechargeAmount'].toString();
    amount = json['amount'].toString();
    isWithdrawal = json['isWithdrawal'];
    minWithdraw = json['minWithdraw'].toString();
    payFirst = json['payFirst'].toString();
    payNum = json['payNum'].toString();
    sumWithdrawAmount = json['sumWithdrawAmount'].toString();
    balance = json['balance'].toString();
    walletType = json['walletType'].toString();
    walletName = json['walletName'].toString();
    sumAccountDml = json['sumAccountDml'].toString();
    czExChange = json['czExChange'].toString();
    shortcutOptionsUnit = json['shortcutOptionsUnit'].toString();
    walletId = json['walletId'].toString();
    currencyUint = json['currencyUint'].toString();
    silverBean = json['silverBean'].toString();
    withdrawalNum = json['withdrawalNum'].toString();
    sumGiveSilverBean = json['sumGiveSilverBean'].toString();
    gameWallet = json['gameWallet'].toString();
    fee = json['fee'].toString();
    accountDml = json['accountDml'].toString();
    txExChange = json['txExChange'].toString();
    desc = json['desc'].toString();
    userId = json['userId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['withdrawalMax'] = withdrawalMax;
    data['payMax'] = payMax;
    data['withdrawalFirst'] = withdrawalFirst;
    data['sumRechargeAmount'] = sumRechargeAmount;
    data['amount'] = amount;
    data['isWithdrawal'] = isWithdrawal;
    data['minWithdraw'] = minWithdraw;
    data['payFirst'] = payFirst;
    data['payNum'] = payNum;
    data['sumWithdrawAmount'] = sumWithdrawAmount;
    data['balance'] = balance;
    data['walletType'] = walletType;
    data['walletName'] = walletName;
    data['sumAccountDml'] = sumAccountDml;
    data['czExChange'] = czExChange;
    data['shortcutOptionsUnit'] = shortcutOptionsUnit;
    data['walletId'] = walletId;
    data['currencyUint'] = currencyUint;
    data['silverBean'] = silverBean;
    data['withdrawalNum'] = withdrawalNum;
    data['sumGiveSilverBean'] = sumGiveSilverBean;
    data['gameWallet'] = gameWallet;
    data['fee'] = fee;
    data['accountDml'] = accountDml;
    data['txExChange'] = txExChange;
    data['desc'] = desc;
    data['userId'] = userId;
    return data;
  }
}
