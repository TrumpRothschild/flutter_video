#import "BasePlugin.h"
#if __has_include(<base/base-Swift.h>)
#import <base/base-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "base-Swift.h"
#endif

@implementation BasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBasePlugin registerWithRegistrar:registrar];
}
@end
