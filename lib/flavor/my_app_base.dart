import 'package:base/app_routes.dart';
import 'package:base/commons/utils/logger.dart';
import 'package:base/themes/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:base/res/app_dimens.dart';

import '../main/base_main_controller.dart';

abstract class MyAppBase<T extends BaseMainController> extends StatelessWidget {
  final easyLoad = EasyLoading.init();
  final botToastBuilder = BotToastInit();

  MyAppBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///支持刷新的全局配置
    return RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => const MaterialClassicHeader(),
        footerBuilder: () => const ClassicFooter(),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: ScreenUtilInit(
            designSize: const Size(AppDimens.design_w, AppDimens.design_h),
            builder: (context, child) {
              return GetX<T>(builder: (_) {
                return GetMaterialApp(
                  title: getTitle(),
                  theme: getTheme(),
                  darkTheme: AppTheme.light,
                  themeMode: ThemeMode.system,
                  debugShowCheckedModeBanner: false,
                  initialRoute: AppRoutes.splash,
                  getPages: getPages(),
                  builder: (context, child) {
                    child = EasyLoading.init()(context, child);

                    ///支持刷新的全局配置
                    ScrollConfiguration(
                      child: child,
                      behavior: RefreshScrollBehavior(),
                    );
                    return child;
                  },
                  navigatorObservers: [BotToastNavigatorObserver()],
                  // unknownRoute: AppPages.unknownRoute,
                  enableLog: true,
                  logWriterCallback: Logger.write,
                  initialBinding: getInitialBinding(),
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    RefreshLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('zh', 'CN'),
                  ],
                );
              });
            }));
  }

  /// 主题
  ThemeData? getTheme();

  /// 标题
  String getTitle();

  /// 获取页面
  List<GetPage>? getPages();

  /// 初始化bindings
  Bindings? getInitialBinding();
}

class RefreshScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: true,
          showTrailing: true,
          axisDirection: axisDirection,
          notificationPredicate: (notification) {
            if (notification.depth == 0) {
              // 越界了拖动触发overScroll的话就没必要展示水波纹
              if (notification.metrics.outOfRange) {
                return false;
              }
              return true;
            }
            return false;
          },
          color: Theme.of(context).primaryColor,
        );
      case TargetPlatform.fuchsia:
        break;
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
    return const Text("data");
  }
}
