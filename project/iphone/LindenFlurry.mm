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

  void endTimedEvent(const char* eventId)
  {
    NSString* strEventId = [[NSString alloc] initWithUTF8String:eventId];
    [Flurry endTimedEvent:strEventId withParameters:nil];

    [strEventId release];
  }

  void endTimedEvent(const char* eventId, int keysCount, const char** keys, const char** values)
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

    [Flurry endTimedEvent:strEventId withParameters: paramsDict];

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

  void setUserId(const char* userId)
  {
    NSString* strUserId = [[NSString alloc] initWithUTF8String:userId];
    [Flurry setUserID:strUserId];
    [strUserId release];
  }

  void setGender(const char* gender)
  {
    NSString* strGender = [[NSString alloc] initWithUTF8String:gender];
    [Flurry setGender:strGender];
    [strGender release];
  }

  void setAge(int age)
  {
    [Flurry setAge: age];
  }

  void logPageView()
  {
    [Flurry logPageView];
  }

  void setAppVersion(const char* appVersion)
  {
    NSString* strAppVersion = [[NSString alloc] initWithUTF8String:appVersion];
    [Flurry setAppVersion:strAppVersion];
    [strAppVersion release];
  }

  void setEventLoggingEnabled(bool enabled)
  {
    [Flurry setEventLoggingEnabled: enabled?YES:NO];
  }

  void setLogLevel(int logLevel)
  {
    [Flurry setLogLevel:(FlurryLogLevel)logLevel];
  }

  void setSessionContinueSeconds(int seconds)
  {
    [Flurry setSessionContinueSeconds:seconds];
  }
}
