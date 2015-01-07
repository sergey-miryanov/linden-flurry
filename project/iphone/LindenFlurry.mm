#include "LindenFlurry.h"
#import "Flurry.h"


namespace LindenFlurry
{
  void setCrashReportingEnabled(bool enabled)
  {
    [Flurry setCrashReportingEnabled: enabled? YES : NO];
  }

  void startSession(const char* key)
  {
    NSString* strKey = [[NSString alloc] initWithUTF8String:key];
    [Flurry startSession: strKey];
    [strKey release];
  }
}
