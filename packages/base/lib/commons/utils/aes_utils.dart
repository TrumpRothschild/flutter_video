import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:base/commons/utils/log_utils.dart';
import 'package:dio/dio.dart';
import 'package:pointycastle/export.dart';
import 'package:encrypt/encrypt.dart';
import 'package:common_aes/common_aes.dart';

/// @date 2023/01、31
/// @des 加密相关工具类
class EncryptUtil {
  /// 通用key
  static const commonKey = "c1kgVioySoUVimtw";

  /// 图片key
  static const imageKey = "qs0fIlSFMMZxOuzD";

  /// 视频key
  static const videoKey = "elZNmenx4XPxah3n";

  static EncryptUtil of() => EncryptUtil();

  /// ASE加密
  Future<String> aesEncryptV2(String data, {key = commonKey}) async {
    final encrypter = await CommonAes.encryptString(data, key);
    return encrypter ?? "";
  }

  /// ASE加密
  Future<String> aesEncrypt(String data, {key = commonKey}) async {
    try {
      final encrypter = Encrypter(AES(Key.fromUtf8(key)));
      final iv = IV.fromLength(16);
      final encrypted = encrypter.encrypt(data, iv: iv);
      return encrypted.base64;
    } catch (e) {
      Log.e("AES加密失败！【${e.toString()}】");
      return data;
    }
  }

  /// ASE解密
  Future<String> aesDecrypt(String data, {key = commonKey}) async {
    try {
      final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
      final iv = IV.fromLength(16);
      return encrypter.decrypt64(data, iv: iv);
    } catch (e) {
      Log.e("AES解密失败！【${e.toString()}】");
      return data;
    }
  }

  static String processImg(Uint8List buffer) {
    final keyUint8List = Uint8List.fromList(utf8.encode(imageKey));
    final key = KeyParameter(keyUint8List);
    final ivParam = key;

    /// key
    final cipher = AESEngine();
    // final cipher =ECBBlockCipher(AESEngine());
    // final cipher =BlockCipher("AES/ECB");
    // log(cipher.blockSize.toString());
    cipher.init(false, ivParam);

    /// ivParam
    final decrypted = cipher.process(buffer);
    log(decrypted.toString());
    // final output = Uint8List(buffer.length);
    // cipher.processBlock(buffer, 0, output, 0);
    // log(output.toString());
    final url = 'data:image/png;base64,' + base64.encode(decrypted);
    // log(url);
    return url;
  }

  /// 分解buffer
  static List<Uint8List> splitBuff(Uint8List buffer) {
    Uint8List key = Uint8List.fromList(utf8.encode(imageKey)); //
    Uint8List data = buffer;
    List<Uint8List> chunks = [];
    Uint8List chunk = Uint8List(16);
    KeyParameter keyP =  KeyParameter(key);
    int chunkSize = 0;
    var cipher = BlockCipher("AES/ECB");
    cipher.init(false,keyP);
    for (int byte in data) {
      chunk[chunkSize] = byte;
      chunkSize++;
      if (chunkSize == 16) {
        Uint8List decrypted = cipher.process(chunk);
        chunks.add(decrypted);
        chunk = Uint8List(16);
        chunkSize = 0;
      }
    }
    return chunks;
  }

//  加密
  static String addProcessImg(Uint8List buffer) {
    List<Uint8List> data = splitBuff(buffer);
    Uint8List dataL =
        Uint8List.fromList(data.expand((element) => element).toList());
    return base64.encode(dataL);
  }

  /// 解密
  static Uint8List encodeImg(Uint8List buffer) {
    List<Uint8List> data = splitBuff(buffer);
    Uint8List dataL =
        Uint8List.fromList(data.expand((element) => element).toList());
    return dataL;
  }

  static Future<String> editProcessImg(String url) async {
    log(url.toString());
    if (url.toString().contains(".w.")) {
      var response = await Dio().get(url.toString(),
          options: Options(responseType: ResponseType.bytes));

      /// options: Options(responseType: ResponseType.bytes
      final buffer = response.data;
      log(buffer.toString());
      List<Uint8List> data = splitBuff(buffer);
      Uint8List dataL =
          Uint8List.fromList(data.expand((element) => element).toList());
      return base64.encode(dataL).toString();
    } else {
      return url.toString();
    }
  }

  /// 视频解码
  static String processImg1(Uint8List buffer) {
    final keyUint8List = Uint8List.fromList(utf8.encode('qs0fIlSFMMZxOuzD'));
    final iv = Uint8List.fromList(utf8.encode('qs0fIlSFMMZxOuzD'));
    final key = KeyParameter(keyUint8List);
    CBCBlockCipher cipher = CBCBlockCipher(AESFastEngine());
    ParametersWithIV<KeyParameter> params =
        ParametersWithIV<KeyParameter>(key, iv);
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
        paddingParams =
        PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
            params, null);
    PaddedBlockCipherImpl paddingCipher =
        PaddedBlockCipherImpl(PKCS7Padding(), cipher);
    paddingCipher.init(false, paddingParams);
    paddingCipher.process(buffer);
    final decrypted = cipher.process(buffer);
    log(decrypted.toString());
    final url = 'data:image/png;base64,' + base64.encode(decrypted);
    return url;
  }

  static String processImg2(Uint8List buffer) {
    final keyUint8List = Uint8List.fromList(utf8.encode('qs0fIlSFMMZxOuzD'));
    final key = KeyParameter(keyUint8List);

    /// key
    // final cipher = AESFastEngine();
    // final pad = Padding("PKCS7");
    final iv = Uint8List.fromList(List.generate(16, (i) => i));
    final cipher = BlockCipher("AES");
    final params = ParametersWithIV(key, iv);
    cipher.init(false, params);
    final decrypted = cipher.process(buffer);
    final url = 'data:image/png;base64,' + base64.encode(decrypted);
    return url;
  }

  static Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  static Uint8List xor(Uint8List a, String key) {
    List<int> keyList = convertStringToUint8List(key).toList();
    List<int> codeUnits = a.toList();
    List<int> codes = [];
    for (int i = 0, length = codeUnits.length; i < length; i++) {
      int code = codeUnits[i] ^ keyList[i % keyList.length];
      codes.add(code);
    }
    return Uint8List.fromList(codes);
  }
}
