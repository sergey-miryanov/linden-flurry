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

extern "C" void linden_flurry_main()
{
  val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(linden_flurry_main);

extern "C" int linden_flurry_register_prims() { return 0; }

