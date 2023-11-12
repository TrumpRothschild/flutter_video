#import "ServicesPlugin.h"
#if __has_include(<services/services-Swift.h>)
#import <services/services-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "services-Swift.h"
#endif

@implementation ServicesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftServicesPlugin registerWithRegistrar:registrar];
}
@end
