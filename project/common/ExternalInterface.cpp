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

extern "C" void linden_flurry_main()
{
  val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(linden_flurry_main);

extern "C" int linden_flurry_register_prims() { return 0; }

