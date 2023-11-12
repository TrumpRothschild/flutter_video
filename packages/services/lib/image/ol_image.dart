import 'dart:convert';
import 'dart:typed_data';

import 'package:base/caches/ol_cache_manager.dart';
import 'package:base/commons/utils/aes_utils.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

///  图片加载组件
/// OLImage(
///     url: url,
///     width: 200,
///     height: 100,
///     fit: BoxFit.cover,
/// )

/// 鉴权key标识
const authKey = "?auth_key=";

/// aes加密
const decryptW = ".w.";

/// 异或加密
const decryptP = ".p.";

/// base64加密
const decryptCed = ".ced";

class OLImage extends StatefulWidget {
  final String imageUrl;
  final String placeholderPath;

  final ImageErrorWidgetBuilder? errorBuilder;

  final double? width;

  final double? height;

  final BoxFit fit;

  final Alignment alignment;

  const OLImage({
    Key? key,
    required this.imageUrl,
    this.placeholderPath = "",
    this.errorBuilder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OLImageState();
}

class _OLImageState extends State<OLImage> {
  late final Dio _dio = Dio();
  Uint8List? _imageBytes;

  /// 缓存key
  String _cacheKey = "";

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null || _imageBytes?.isEmpty == true) {
      return _placeholderWidget();
    } else {
      return _imageMemoryWidget();
    }
  }

  @override
  void initState() {
    super.initState();
    // 获取图片数据
    _getImageData();
  }

  @override
  void didUpdateWidget(OLImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _getImageData();
    }
  }

  /// 图片组件--Uint8List
  Widget _imageMemoryWidget() {
    return Image.memory(_imageBytes!,
        errorBuilder: widget.errorBuilder,
        alignment: widget.alignment,
        gaplessPlayback: true,
        fit: widget.fit,
        width: widget.width,
        height: widget.height);
  }

  /// 占位图
  Widget _placeholderWidget() {
    var placeholderPath = widget.placeholderPath;
    if (placeholderPath.isEmpty) {
      return Container();
    } else {
      return Image.asset(
        widget.placeholderPath,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
      );
    }
  }

  /// 是否AES
  bool isAes(url) => url.contains(decryptW);

  /// 是否异或
  bool isXor(url) => url.contains(decryptP);

  /// 是否base64
  bool isBase64(url) => url.contains(decryptCed);

  /// 获取图片
  _getImageData() {
    try {
      var temUrl = widget.imageUrl;
      if (temUrl.isEmpty) {
        Log.e("image---【图片地址为空！】");
        return;
      }
      if (temUrl.contains(authKey)) {
        List<String> list = temUrl.split(authKey);
        //图片路径去掉鉴权部分作为缓存的key
        _cacheKey = list[0];
      } else {
        _cacheKey = temUrl;
      }
      _loadImageByCache(_cacheKey, (Uint8List? data) {
        if (data != null && data.isNotEmpty == true) {
         // Log.d("image---缓存---【$_cacheKey】");
          if (mounted) {
            setState(() {
              _imageBytes = data;
            });
          }
        } else {
          _loadImageByNetwork(temUrl, _cacheKey, (Uint8List? data) {
          //  Log.d("image---网络---【$_cacheKey】");
            if (mounted) {
              setState(() {
                _imageBytes = data;
              });
            }
          });
        }
      });
    } catch (e) {
      Log.e("【获取图片失败：${e.toString()}】");
    }
  }

  /// 获取缓存的图片
  _loadImageByCache(String cacheKey, Function(Uint8List?) callback) {
    OLCacheManager.shared.getBytes(cacheKey).then((value) => callback(value));
  }

  /// 从网络获取图片
  _loadImageByNetwork(
      String url, String cacheKey, Function(Uint8List) callback) {
    _dio.get(url, options: Options(responseType: ResponseType.bytes)).then(
        (response) {
      if (response.data == null) {
        Log.e("image---【获取图片为空】");
        return;
      }
      Uint8List bytes = response.data;
      Uint8List _imageBytes;
      if (isAes(url)) {
        /// AES
        _imageBytes = EncryptUtil.encodeImg(bytes);
      } else if (isXor(url)) {
        /// 异或
        // 获取文件名
        var keyTmp = path.basename(cacheKey);
        // 获取后缀
        var ext = path.extension(keyTmp);
        // 去掉 .p. 和 后缀
        var key = keyTmp.replaceAll(".p.", "").replaceAll(ext, "");
        // https: //img.91momo50.vip/picture/2023/01/04/1777807018482906688.p.jpg 的key=1777807018482906688
        _imageBytes = EncryptUtil.xor(bytes, key);
      } else if (isBase64(url)) {
        /// base64
        _imageBytes = base64Decode(String.fromCharCodes(bytes));
      } else {
        _imageBytes = bytes;
      }
      callback(_imageBytes);

      /// 缓存解密后的图片
      OLCacheManager.shared.putByte(cacheKey, _imageBytes);
    }, onError: (error) {
      Log.e("image---【获取图片失败：${error.toString()}】");
    });
  }
}
