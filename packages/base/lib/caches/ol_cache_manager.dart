import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

class OLCacheManager {
  static final OLCacheManager shared = OLCacheManager();
  final cache = DefaultCacheManager();

  Uint8List _convertStringToUInt8List(String str) {
    final utf8Encoder = utf8.encoder;
    final encodedSample = utf8Encoder.convert(str);
    return encodedSample;
  }

  // 缓存一个map
  void putData(String key, Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    final jsonData = _convertStringToUInt8List(jsonString);
    cache.putFile(key, jsonData, key: key);
  }

  // 缓存一个字符串
  void putString(String key, String data) {
    final jsonData = _convertStringToUInt8List(data);
    cache.putFile(key, jsonData, key: key);
  }

  // 缓存一个字节
  void putByte(String key, Uint8List bytes) {
    cache.putFile(key, bytes, key: key);
  }

  // 清空缓存
  void emptyCache() {
    cache.emptyCache();
  }

  // 通过key移除缓存
  void removeFile(key) {
    cache.removeFile(key);
  }

  // 获取一个map
  Future<Map<String, dynamic>> getData(String key) async {
    final fileInfo = await getFileInfo(key);
    if (fileInfo == null) {
      return {};
    }
    final cacheString = await fileInfo.file.readAsString();
    return json.decode(cacheString);
  }

  // 获取一个字符串
  Future<String> getString(String key) async {
    final fileInfo = await getFileInfo(key);
    if (fileInfo == null) {
      return "";
    }
    return fileInfo.file.readAsString();
  }

  Future<Uint8List?> getBytes(String key) async {
    final fileInfo = await getFileInfo(key);
    if (fileInfo == null) {
      return null;
    }
    return fileInfo.file.readAsBytes();
  }

  Future<FileInfo?> getFileInfo(String key) async {
    return OLCacheManager.shared.cache.getFileFromCache(key);
  }
}
