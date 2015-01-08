#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include <stdio.h>
#include <hxcpp.h>
#include "LindenFlurry.h"

using namespace LindenFlurry;

static value linden_flurry_setCrashReportingEnabled(value enabled)
{
#ifdef IPHONE
  if(val_is_bool(enabled))
  {
    bool b = val_get_bool(enabled);
    setCrashReportingEnabled(b);
  }
#endif
  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setCrashReportingEnabled, 1);

static value linden_flurry_startSession(value key)
{
#ifdef IPHONE
  if(val_is_string(key))
  {
    const char* strKey  = val_get_string(key);
    startSession(strKey);
  }
#endif
  return alloc_null();
}
DEFINE_PRIM(linden_flurry_startSession, 1);

static value linden_flurry_logEvent(value eventId, value keys, value values, value timed)
{
#ifdef IPHONE
  if(val_is_null(keys) || val_is_null(values))
  {
    if(val_is_string(eventId) && val_is_bool(timed))
    {
      logEvent(val_get_string(eventId), val_get_bool(timed));
    }
  }
  else
  {
    int keysSize = val_array_size(keys);
    int valuesSize = val_array_size(values);
    if(keysSize == valuesSize)
    {
      const char** strKeys = new const char*[keysSize];
      const char** strValues = new const char*[keysSize];

      for(int i = 0; i < keysSize; ++i)
      {
        value key = val_array_i(keys, i);
        value value = val_array_i(values, i);

        if(val_is_string(key) && val_is_string(value))
        {
          strKeys[i] = val_get_string(key);
          strValues[i] = val_get_string(value);
        }
      }

      if(val_is_string(eventId) && val_is_bool(timed))
      {
        logEvent(val_get_string(eventId), keysSize, strKeys, strValues, val_get_bool(timed));
      }

      delete[] strValues;
      delete[] strKeys;
    }
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_logEvent, 4);

static value linden_flurry_endTimedEvent(value eventId, value keys, value values)
{
#ifdef IPHONE
  if(val_is_null(keys) || val_is_null(values))
  {
    if(val_is_string(eventId))
    {
      endTimedEvent(val_get_string(eventId));
    }
  }
  else
  {
    int keysSize = val_array_size(keys);
    int valuesSize = val_array_size(values);
    if(keysSize == valuesSize)
    {
      const char** strKeys = new const char*[keysSize];
      const char** strValues = new const char*[keysSize];

      for(int i = 0; i < keysSize; ++i)
      {
        value key = val_array_i(keys, i);
        value value = val_array_i(values, i);

        if(val_is_string(key) && val_is_string(value))
        {
          strKeys[i] = val_get_string(key);
          strValues[i] = val_get_string(value);
        }
      }

      if(val_is_string(eventId))
      {
        endTimedEvent(val_get_string(eventId), keysSize, strKeys, strValues);
      }

      delete[] strValues;
      delete[] strKeys;
    }
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_endTimedEvent, 3);

static value linden_flurry_setUserId(value userId)
{
#ifdef IPHONE
  if(val_is_string(userId))
  {
    setUserId(val_get_string(userId));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setUserId, 1);

static value linden_flurry_setGender(value gender)
{
#ifdef IPHONE
  if(val_is_string(gender))
  {
    setGender(val_get_string(gender));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setGender, 1);

static value linden_flurry_setAge(value age)
{
#ifdef IPHONE
  if(val_is_int(age))
  {
    setAge(val_get_int(age));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setAge, 1);

static value linden_flurry_logPageView()
{
#ifdef IPHONE
  logPageView();
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_logPageView, 0);

static value linden_flurry_setAppVersion(value appVersion)
{
#ifdef IPHONE
  if(val_is_string(appVersion))
  {
    setAppVersion(val_get_string(appVersion));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setAppVersion, 1);

static value linden_flurry_setEventLoggingEnabled(value enabled)
{
#ifdef IPHONE
  if(val_is_bool(enabled))
  {
    setEventLoggingEnabled(val_get_bool(enabled));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setEventLoggingEnabled, 1);

static value linden_flurry_setLogLevel(value logLevel)
{
#ifdef IPHONE
  if(val_is_int(logLevel))
  {
    setLogLevel(val_get_int(logLevel));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setLogLevel, 1);

static value linden_flurry_setSessionContinueSeconds(value seconds)
{
#ifdef IPHONE
  if(val_is_int(seconds))
  {
    setSessionContinueSeconds(val_get_int(seconds));
  }
#endif

  return alloc_null();
}
DEFINE_PRIM(linden_flurry_setSessionContinueSeconds, 1);

extern "C" void linden_flurry_main()
{
  val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(linden_flurry_main);

extern "C" int linden_flurry_register_prims() { return 0; }

