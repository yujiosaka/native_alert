#import "NativeDialogPlugin.h"
#if __has_include(<native_dialog/native_dialog-Swift.h>)
#import <native_dialog/native_dialog-Swift.h>
#else
#import "native_dialog-Swift.h"
#endif

@implementation NativeDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeDialogPlugin registerWithRegistrar:registrar];
}
@end
