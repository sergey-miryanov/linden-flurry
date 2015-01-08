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

  void logEvent(const char* eventId, bool t)
  {
    NSString* strEventId = [[NSString alloc] initWithUTF8String:eventId];
    if(t)
    {
      [Flurry logEvent:strEventId timed: t?YES:NO];
    }
    else
    {
      [Flurry logEvent:strEventId];
    }

    [strEventId release];
  }

  void logEvent(const char* eventId, int keysCount, const char** keys, const char** values, bool t)
  {
    NSString* strEventId = [[NSString alloc] initWithUTF8String:eventId];
    NSMutableArray* nsKeys = [[NSMutableArray alloc] init];
    NSMutableArray* nsValues = [[NSMutableArray alloc] init];

    for(int i = 0; i < keysCount; ++i)
    {
      NSString* key = [[NSString alloc] initWithUTF8String:keys[i]];
      NSString* value = [[NSString alloc] initWithUTF8String:values[i]];

      [nsKeys addObject: key];
      [nsValues addObject: value];
    }

    NSDictionary* paramsDict = [[NSDictionary alloc] initWithObjects: nsValues forKeys: nsKeys];

    if(t)
    {
      [Flurry logEvent:strEventId withParameters:paramsDict timed: t? YES:NO];
    }
    else
    {
      [Flurry logEvent:strEventId withParameters: paramsDict];
    }

    for(int i = 0; i < keysCount; ++i)
    {
      NSString* key = nsKeys[i];
      NSString* value = nsValues[i];

      [key release];
      [value release];
    }

    [nsKeys release];
    [nsValues release];
    [paramsDict release];
    [strEventId release];
  }
}
