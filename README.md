# flutter_uni_client

## UI 使用

- [UI](https://www.figma.com/file/JmnfcsRZXC5Po7QDfvDENU/b-ball--3?node-id=104%3A4970&t=Fm3lIWyqZPCbi9GU-0)

### 参考页面标准

```
base里面一个功能一个文件夹，比如login，splash,各个子模块所有的controller,view,binding,provider建议用一个文件夹，
命名xxx_controller等，具体看下home_page模块，
路由一个模块一个主路由(home），其他的都写子路由(home/xx)，
getx 模版设置 请参考
https://juejin.cn/post/6924104248275763208
```

### 配置地址: lib/live.dart

## 文件夹介绍

1. app定义页面，app初始化 main 包含启动工程所需的功能

2. packages 存放功能分割的插件 把每个功能都单独进行分离 根据不同打包的配置加载依赖 packages/base 模块之间的公共文件放到这里 （登录、注册等）
   packages/base/app_config.dart 应用需要配置的地方 packages/base/themes 存放主题的地方 需要用到字体大小 字体颜色 等资源
   packages//base/common/utils 共同的工具类 不依赖其他的自己定义的基础库 避免循环引用 packages/base/common/widget 存放通用的基础组件 比如
   固定样式的按钮 固定样式的文本文件 packages/base_page/ 存放模块之间的公共页面 比如 登录，注册， 启动页面 packages/base_service/
   存储公共页面所需要的接口服务 多个模块共同使用 packages/service 与接口相关的数据放到这里 packages/demo_page 测试模块 packages/home_page
   首页、直播相关的功能模块 packages/game_page 游戏、彩票相关的功能模块 packages/wallet_page 充值中心、钱包、提现等相关的功能模块
   packages/mine_page 我的功能模块 packages/video_page 视频页面

3. base_page 存储一些公共的页面 比如 启动页面 公共的展示页面
4. app/app_init.dart 存放应用需要初始化的地方 尽量都写在这里 便于后面分包处理

## 常用的开发点

1. 页面之前传递使用GetX系列进行传递
2. 用到的颜色或字体 themes 定义编译切换主题
3. 大功能模块尽量使用package或plugins 模式开发 用于根据不同的需求进行打包
4. 命名尽量使用flutter建议，工程里面尽量把警告处理掉
5. 命名以OL前缀开始 例如 ol_flash_widget
6. 重要的逻辑和参数 需要写注释

## git使用注意

1. 大家都在 dev上开发 2.尽量每天都提交代码，避免2提交一次， 做一个小功能完成原则上就需要提交代码，早提交少点合并代码的烦恼

## json 使用规范 参考baseService/lib/Users 下面生成

https://app.quicktype.io/ 参考splash页面

## 资源使用

1. 所有的图片 都放在 assets/
2. 添加图片需要运行命令

```
清理
flutter packages pub run build_runner clean
生成
flutter packages pub run build_runner build
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. 生成后，把packages/base/asset.gen.dart 是生成的资源导航 需要引入

### 图片展示组件

OLImage 支持aes解密 OLImage(imageUrl:'you image url',)

### loading 显示组件

OLEasyLoading 显示toast

## 环境配置

### 目前环境是根据预编译的参数来进行配置的 在运行的时候，通过配置 定义环境参数: PACKAGE_ENV 在android里面设置

https://stackoverflow.com/questions/55004302/how-do-you-pass-arguments-from-command-line-to-main-in-flutter-dart

### 环境参数

```
正式环境
--dart-define=PACKAGE_ENV=pro --no-sound-null-safety --dart-define=PACKAGE_DEBUG=true
预发布环境
--dart-define=PACKAGE_ENV=pre --no-sound-null-safety
开发环境
--dart-define=PACKAGE_ENV=dev --no-sound-null-safety
uat环境
--dart-define=PACKAGE_ENV=uat --no-sound-null-safety
说明：Build flavor 需要设置下,对应值为环境枚举EnvType
```

### 需要在脚本运行的时候 则需要使用这个脚本 flutter run --dart-define=PACKAGE_ENV=dev flutter run

--dart-define=PACKAGE_ENV=pro

### 是否debug模式

--dart-define=PACKAGE_DEBUG=true

## GetX使用规则

1. 定义监听的变量 只需添加 .obs 作为value的属性 推荐使用

*** 在AndroidStudio 安装插件GetX和GetX Template Generator 辅助使用gex状态管理

```
   如果使用Getx管理状态，需要继承于GetXBaseController使用，目前包含主题的改变 后续公共的一些状态处理就放到这个类里面
   注意事项:
   如果在页面监听状态 ，则需要 放到GetX的前面
   Color? selectColor1 = controller.currentCustomThemeData().colors0x000000;
   
   bottomNavigationBar: GetX<GetRootController>(
          builder: (_) {
            Color? selectColor2 = controller.currentCustomThemeData().colors0x000000;
            
          BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: selectColor1,
              //selectedItemColor: selectColor2,
              
              
```

*** 结果是selectColor1是监听不到， selectColor2是可以监听的 所有在使用的时候请注意

## 主题使用 controller.currentCustomThemeData() 获取当前主题

```
   使用主题的时候请注意了
   xxGetController 是继承GetXBaseController 
   final controller = xxGetController 
   如果当前使用GetX方式进行处理， 则使用 controller.currentCustomThemeData() 获取到当前的主题 
   会根据当前主题进行全局更换
```

*** 如果没有使用GetXController管理状态 则需要自己去实现监听

### 缓存使用

// 对于大数据则使用这个 尽量少用UserDefine之类的存储 package:base/cache/cache_manager.dart

void putData(String key, Map<String,dynamic> data) 存入一个数据 void putString(String key, String data)
存储一个字符串 Future<Map<String, dynamic>> getData(String key) 读取一个缓存的数据 Future<String> getString(String
key) 读取一个缓存的字符串

在接口请求的时候注意 // 默认空是处理需要受版本控制的接口 （主要针对受版本控制） await HttpUtil().post(Apis.verApi, needCache : false)

// ios 和 android 自带的 缓存 就用 class SpUtils

## 打包注意 如果要编译相应的包通过xcode或Android Studio 则需要改 main.dart

```
  ios : uni-client/ios/flutter/Generated.xcconfig 里面的 FLUTTER_TARGET=lib/main.dart
  android : 直接通过运行的配置就可以了

```

### 打包

#### 1、修改版本号：

```
位置：android/config/config.gradle
修改：Code和Name，我们的版本号还是三位为主，比如pro环境：vCode：1 vName："1.0.0"
```

#### 2、执行打包命令：

- uat环境

```
 打包所有
 flutter build apk --dart-define=PACKAGE_ENV=uat --no-sound-null-safety  --target=lib/live.dart --release --flavor uat
 只打armeabi-v7a
 flutter build apk --dart-define=PACKAGE_ENV=uat --no-sound-null-safety  --target=lib/video.dart --target-platform android-arm --split-per-abi --release --flavor uat
```

- pro环境

```
 打包所有
 flutter build apk --dart-define=PACKAGE_ENV=pro --no-sound-null-safety  --target=lib/live.dart --release
 打armeabi-v7a
 flutter build apk --dart-define=PACKAGE_ENV=pro --no-sound-null-safety  --target=lib/video.dart --target-platform android-arm --release --flavor pro
 打arm64
 flutter build apk --dart-define=PACKAGE_ENV=pro --no-sound-null-safety --target=lib/video.dart --target-platform android-arm --release --flavor pro
 打armeabi-v7a和打arm64，--split-per-abi 按不同架构分别打包
 flutter build apk --dart-define=PACKAGE_ENV=pro --no-sound-null-safety --target=lib/video.dart --target-platform android-arm64 --split-per-abi --release --flavor pro
 打armeabi-v7a和打arm64一起
 flutter build apk --dart-define=PACKAGE_ENV=pro --no-sound-null-safety --target=lib/video.dart --target-platform android-arm android-arm64 --release --flavor pro
```

### 分析apk大小

```
flutter build apk --analyze-size --target-platform=[android-arm64|android-arm|android-x64]
flutter build apk --analyze-size --no-sound-null-safety  --target=lib/video.dart --target-platform android-arm --split-per-abi --release 
```

## GetX

### getx的路由跳转命令

```
Get.to(TabBarPage()); // 直接跳转页面 （=Navigation.push()）
Get.toNamed("/home")  // 通过路由表中的名字进行跳转
Get.back();   	     // 关闭当前页面（=Navigation.pop()）
Get.off(TabBarPage())// 跳转页面并关闭之前的页面 (等于 Navigation.pushReplacement() )
Get.offAll(TabBarPage()) //跳转页面并关闭之前全部的页面 (= Navigation.pushAndRemoveUntil)
Get.offNamed("/home")  //  使用路由名 功能同上
Get.offAllNamed("/home")  //  使用路由名 功能同上
```

# 颜色值透明度

```
百分比:0% HEX: 00
百分比:1% HEX: 30
百分比:2% HEX: 50
百分比:3% HEX: 80
百分比:4% HEX: A0
百分比:5% HEX: D0
百分比:6% HEX: F0
百分比:7% HEX: 12
百分比:8% HEX: 14
百分比:9% HEX: 17
百分比:10% HEX: 1A
百分比:11% HEX: 1C
百分比:12% HEX: 1F
百分比:13% HEX: 21
百分比:14% HEX: 24
百分比:15% HEX: 26
百分比:16% HEX: 29
百分比:17% HEX: 2B
百分比:18% HEX: 2E
百分比:19% HEX: 30
百分比:20% HEX: 33
百分比:21% HEX: 36
百分比:22% HEX: 38
百分比:23% HEX: 3B
百分比:24% HEX: 3D
百分比:25% HEX: 40
百分比:26% HEX: 42
百分比:27% HEX: 45
百分比:28% HEX: 47
百分比:29% HEX: 4A
百分比:30% HEX: 4D
百分比:31% HEX: 4F
百分比:32% HEX: 52
百分比:33% HEX: 54
百分比:34% HEX: 57
百分比:35% HEX: 59
百分比:36% HEX: 5C
百分比:37% HEX: 5E
百分比:38% HEX: 61
百分比:39% HEX: 63
百分比:40% HEX: 66
百分比:41% HEX: 69
百分比:42% HEX: 6B
百分比:43% HEX: 6E
百分比:44% HEX: 70
百分比:45% HEX: 73
百分比:46% HEX: 75
百分比:47% HEX: 78
百分比:48% HEX: 7A
百分比:49% HEX: 7D
百分比:50% HEX: 80
百分比:51% HEX: 82
百分比:52% HEX: 85
百分比:53% HEX: 87
百分比:54% HEX: 8A
百分比:55% HEX: 8C
百分比:56% HEX: 8F
百分比:57% HEX: 91
百分比:58% HEX: 94
百分比:59% HEX: 96
百分比:60% HEX: 99
百分比:61% HEX: 9C
百分比:62% HEX: 9E
百分比:63% HEX: A1
百分比:64% HEX: A3
百分比:65% HEX: A6
百分比:66% HEX: A8
百分比:67% HEX: AB
百分比:68% HEX: AD
百分比:69% HEX: B0
百分比:70% HEX: B3
百分比:71% HEX: B5
百分比:72% HEX: B8
百分比:73% HEX: BA
百分比:74% HEX: BD
百分比:75% HEX: BF
百分比:76% HEX: C2
百分比:77% HEX: C4
百分比:78% HEX: C7
百分比:79% HEX: C9
百分比:80% HEX: CC
百分比:81% HEX: CF
百分比:82% HEX: D1
百分比:83% HEX: D4
百分比:84% HEX: D6
百分比:85% HEX: D9
百分比:86% HEX: DB
百分比:87% HEX: DE
百分比:88% HEX: E0
百分比:89% HEX: E3
百分比:90% HEX: E6
百分比:91% HEX: E8
百分比:92% HEX: EB
百分比:93% HEX: ED
百分比:94% HEX: F0
百分比:95% HEX: F2
百分比:96% HEX: F5
百分比:97% HEX: F7
百分比:98% HEX: FA
百分比:99% HEX: FC
百分比:100% HEX: FF
```

正式环境--dart-define=PACKAGE_ENV=pro --no-sound-null-safety --dart-define=PACKAGE_APP=video --dart-define=PACKAGE_DEBUG=true
预发布环境--dart-define=PACKAGE_ENV=pre --no-sound-null-safety --dart-define=PACKAGE_APP=video --dart-define=PACKAGE_DEBUG=true
开发环境--dart-define=PACKAGE_ENV=dev --no-sound-null-safety --dart-define=PACKAGE_APP=video --dart-define=PACKAGE_DEBUG=trueuat
环境--dart-define=PACKAGE_ENV=uat --no-sound-null-safety --dart-define=PACKAGE_APP=video --dart-define=PACKAGE_DEBUG=true
























