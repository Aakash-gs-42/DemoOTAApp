#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(OTABundleManager, NSObject)
RCT_EXTERN_METHOD(
  checkForBundleUpdate:
  (NSString *)apiEndpoint
  appId:(NSString *)appId
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject
)
@end




