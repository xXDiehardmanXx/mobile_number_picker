#import "MobileNumberPickerPlugin.h"
#if __has_include(<mobile_number_picker/mobile_number_picker-Swift.h>)
#import <mobile_number_picker/mobile_number_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mobile_number_picker-Swift.h"
#endif

@implementation MobileNumberPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMobileNumberPickerPlugin registerWithRegistrar:registrar];
}
@end
