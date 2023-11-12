#import "BasePagePlugin.h"
#if __has_include(<base_page/base_page-Swift.h>)
#import <base_page/base_page-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "base_page-Swift.h"
#endif

@implementation BasePagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBasePagePlugin registerWithRegistrar:registrar];
}
@end
