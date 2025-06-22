//
//  BundleReloader.m
//  OTAApp
//
//  Created by Aakash G S on 19/05/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(BundleReloader, NSObject)

RCT_EXTERN_METHOD(reloadBridge)

@end

