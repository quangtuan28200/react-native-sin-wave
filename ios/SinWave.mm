#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SinWave, NSObject)

RCT_EXTERN_METHOD(playSound:(double)frequency)
RCT_EXTERN_METHOD(stopSound)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
