import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/simple_bank_model.dart';

class BindBankProvider extends GetConnect {
  static Future<List<SimpleBankModel>> getBankList() async {
    BaseResponse response = await CommonApis.of().getBankList();
    if (GetUtils.isNull(response.data) == true) {
      return [];
    }

    final resList = response.data as List? ?? [];
    if (resList.isEmpty) return [];

    return resList
        .map((e) => SimpleBankModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<BaseResponse?> addBank({
    required String bankAccountName,
    required String bankAccountNo,
    required String bankCode,
    required String smsCode,
  }) async {
    BaseResponse response = await CommonApis.of().addBank(
      bankAccountName,
      bankAccountNo,
      bankCode,
      smsCode,
    );
    // if (GetUtils.isNull(response.data) == true) {
    //   return null;
    // }
    return response;
  }
}
