import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_cached_video_player/models/models.dart';
import 'package:fijkplayer/fijkplayer.dart';

abstract class VideoControllerService {
  // Future<FijkPlayer> getControllerForVideo(Video video);
}

class CachedVideoControllerService extends VideoControllerService {
  final BaseCacheManager _cacheManager;

  CachedVideoControllerService(this._cacheManager);

  // @override
  // Future<FijkPlayer> getControllerForVideo(Video video) async {
  //   final fileInfo = await _cacheManager.getFileFromCache(video.url);
  //
  //   if (fileInfo == null) {
  //     if (kDebugMode) {
  //       print('[VideoControllerService]: No video in cache');
  //     }
  //
  //     if (kDebugMode) {
  //       print('[VideoControllerService]: Saving video to cache');
  //     }
  //     unawaited(_cacheManager.downloadFile(video.url));
  //
  //     return FijkPlayer.network(video.url);
  //   } else {
  //     if (kDebugMode) {
  //       print('[VideoControllerService]: Loading video from cache');
  //     }
  //     return FijkPlayer.file(fileInfo.file);
  //   }
  // }
}

final videoPlayerRepositoryProvider = Provider<VideoControllerService>((ref) {
  throw UnimplementedError();
});
