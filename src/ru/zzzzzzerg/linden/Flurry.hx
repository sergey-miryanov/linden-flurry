package ru.zzzzzzerg.linden;

#if android

import openfl.utils.JNI;
import haxe.CallStack;

class FlurryImpl
{
  static public function onStartSession(flurryKey : String)
  {
    initJNI();
    _onStartSession(flurryKey);
  }

  static public function onEndSession()
  {
    initJNI();
    _onEndSession();
  }

  static public function setVersionName(versionName : String)
  {
    initJNI();
    _setVersionName(versionName);
  }

  static public function setReportLocation(reportLocation : Bool)
  {
    initJNI();
    _setReportLocation(reportLocation);
  }

  static public function setLogEnabled(logEnabled : Bool)
  {
    initJNI();
    _setLogEnabled(logEnabled);
  }

  static public function setLogLevel(logLevel : Int)
  {
    initJNI();
    _setLogLevel(logLevel);
  }

  static public function setContinueSessionMillis(millis : Int)
  {
    initJNI();
    _setContinueSessionMillis(millis);
  }

  static public function setLogEvents(logEvents : Bool)
  {
    initJNI();
    _setLogEvents(logEvents);
  }

  static public function setCaptureUncaughtExceptions(isEnabled : Bool)
  {
    initJNI();
    _setCaptureUncaughtExceptions(isEnabled);
  }

  static public function logEvent(eventId : String, ?params : Dynamic = null, ?timed : Bool = false)
  {
    initJNI();
    if(params != null)
    {
      var map = new JNIHashMap();
      for(n in Reflect.fields(params))
      {
        map.put(n, Std.string(Reflect.field(params, n)));
      }

      if(timed)
      {
        callMethod(_logEventParamsTimed, [eventId, map.getJNIObject(), timed]);
      }
      else
      {
        callMethod(_logEventParams, [eventId, map.getJNIObject()]);
      }
    }
    else if(timed)
    {
      callMethod(_logEventTimed, [eventId, timed]);
    }
    else
    {
      callMethod(_logEvent, [eventId]);
    }
  }

  static public function endTimedEvent(eventId : String, ?params : Dynamic = null)
  {
    initJNI();
    if(params != null)
    {
      var map = new JNIHashMap();
      for(n in Reflect.fields(params))
      {
        map.put(n, Std.string(Reflect.field(params, n)));
      }

      callMethod(_endTimedEventParams, [eventId, map.getJNIObject()]);
    }
    else
    {
      callMethod(_endTimedEvent, [eventId]);
    }
  }

  static public function onError(errorId : String, message : String, errorClass : String)
  {
    initJNI();
    _onError(errorId, message, errorClass);
  }

  static public function onPageView()
  {
    initJNI();
    _onPageView();
  }

  static public function setAge(age : Int)
  {
    initJNI();
    _setAge(age);
  }

  static public function setGender(gender : Int)
  {
    initJNI();
    _setGender(gender);
  }

  static public function setUserId(userId : String)
  {
    initJNI();
    _setUserId(userId);
  }

  private static function getMethod(ns : String, name : String, sig : String, useArray : Bool = false) : Dynamic
  {
    var m = JNI.createStaticMethod(ns, name, sig, useArray, true);
    if(m == null)
    {
      trace(["Can't find JNI method", ns, name, sig]);
    }

    return m;
  }

  private static function callMethod(method : Dynamic, params : Array<Dynamic>)
  {
    if(method != null)
    {
      method(params);
    }
    else
    {
      trace("Method is null");
      var stack = CallStack.callStack();
      trace(CallStack.toString(stack));
    }
  }

  private static function initJNI()
  {
    if(_onStartSession == null)
    {
      _onStartSession = getMethod("ru/zzzzzzerg/linden/Flurry", "start", "(Ljava/lang/String;)V");
    }

    if(_onEndSession == null)
    {
      _onEndSession = getMethod("ru/zzzzzzerg/linden/Flurry", "stop", "()V");
    }

    if(_setVersionName == null)
    {
      _setVersionName = getMethod("com/flurry/android/FlurryAgent", "setVersionName", "(Ljava/lang/String;)V");
    }

    if(_setReportLocation == null)
    {
      _setReportLocation = getMethod("com/flurry/android/FlurryAgent", "setReportLocation", "(Z)V");
    }

    if(_setLogEnabled == null)
    {
      _setLogEnabled = getMethod("com/flurry/android/FlurryAgent", "setLogEnabled", "(Z)V");
    }

    if(_setLogLevel == null)
    {
      _setLogLevel = getMethod("com/flurry/android/FlurryAgent", "setLogLevel", "(I)V");
    }

    if(_setContinueSessionMillis == null)
    {
      _setContinueSessionMillis = getMethod("com/flurry/android/FlurryAgent", "setContinueSessionMillis", "(J)V");
    }

    if(_setLogEvents == null)
    {
      _setLogEvents = getMethod("com/flurry/android/FlurryAgent", "setLogEvents", "(Z)V");
    }

    if(_setCaptureUncaughtExceptions == null)
    {
      _setCaptureUncaughtExceptions = getMethod("com/flurry/android/FlurryAgent", "setCaptureUncaughtExceptions", "(Z)V");
    }

    if(_logEvent == null)
    {
      _logEvent = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;)Lcom/flurry/android/FlurryEventRecordStatus;", true);
      _logEventParams = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Ljava/util/Map;)Lcom/flurry/android/FlurryEventRecordStatus;", true);
      _logEventParamsTimed = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Ljava/util/Map;Z)Lcom/flurry/android/FlurryEventRecordStatus;", true);
      _logEventTimed = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Z)Lcom/flurry/android/FlurryEventRecordStatus;", true);
    }

    if(_endTimedEvent == null)
    {
      _endTimedEvent = getMethod("com/flurry/android/FlurryAgent", "endTimedEvent", "(Ljava/lang/String;)V", true);
      _endTimedEventParams = getMethod("com/flurry/android/FlurryAgent", "endTimedEvent", "(Ljava/lang/String;Ljava/util/Map;)V", true);
    }

    if(_onError == null)
    {
      _onError = getMethod("com/flurry/android/FlurryAgent", "onError", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    }

    if(_onPageView == null)
    {
      _onPageView = getMethod("com/flurry/android/FlurryAgent", "onPageView", "()V");
    }

    if(_setAge == null)
    {
      _setAge = getMethod("com/flurry/android/FlurryAgent", "setAge", "(I)V");
    }

    if(_setGender == null)
    {
      _setGender = getMethod("com/flurry/android/FlurryAgent", "setGender", "(B)V");
    }

    if(_setUserId == null)
    {
      _setUserId = getMethod("com/flurry/android/FlurryAgent", "setUserId", "(Ljava/lang/String;)V");
    }
  }

  private static var _onStartSession : Dynamic = null;
  private static var _onEndSession : Dynamic = null;
  private static var _setVersionName : Dynamic = null;
  private static var _setReportLocation : Dynamic = null;
  private static var _setLogEnabled : Dynamic = null;
  private static var _setLogLevel : Dynamic = null;
  private static var _setContinueSessionMillis : Dynamic = null;
  private static var _setLogEvents : Dynamic = null;
  private static var _setCaptureUncaughtExceptions : Dynamic = null;
  private static var _logEvent : Dynamic = null;
  private static var _logEventTimed : Dynamic = null;
  private static var _logEventParams : Dynamic = null;
  private static var _logEventParamsTimed : Dynamic = null;
  private static var _endTimedEvent : Dynamic = null;
  private static var _endTimedEventParams : Dynamic = null;
  private static var _onError : Dynamic = null;
  private static var _onPageView : Dynamic = null;
  private static var _setAge : Dynamic = null;
  private static var _setGender : Dynamic = null;
  private static var _setUserId : Dynamic = null;

}

typedef Flurry = FlurryImpl;

#elseif ios

import cpp.Lib;

class FlurryIOS
{
  static public function onStartSession(flurryKey : String)
  {
    linden_flurry_startSession(flurryKey);
  }

  static public function setCaptureUncaughtExceptions(enabled: Bool)
  {
    linden_flurry_setCrashReportingEnabled(enabled);
  }

  static public function logEvent(eventId : String, ?params : Dynamic = null, ?timed : Bool = false)
  {
    if(params != null)
    {
      var keys = Reflect.fields(params);
      var values = new Array<String>();
      for(key in keys)
      {
        values.push(Std.string(Reflect.field(params, key)));
      }

      linden_flurry_logEvent(eventId, keys, values, timed);
    }
    else
    {
      linden_flurry_logEvent(eventId, null, null, timed);
    }
  }

  static public function endTimedEvent(eventId : String, ?params : Dynamic = null)
  {
    if(params != null)
    {
      var keys = Reflect.fields(params);
      var values = new Array<String>();
      for(key in keys)
      {
        values.push(Std.string(Reflect.field(params, key)));
      }

      linden_flurry_endTimedEvent(eventId, keys, values);
    }
    else
    {
      linden_flurry_endTimedEvent(eventId, null, null);
    }
  }



  private static var linden_flurry_startSession = Lib.load("linden_flurry", "startSession", 1);
  private static var linden_flurry_setCrashReportingEnabled = Lib.load("linden_flurry", "setCrashReportingEnabled", 1);
  private static var linden_flurry_logEvent = Lib.load("linden_flurry", "logEvent", 4);
  private static var linden_flurry_endTimedEvent = Lib.load("linden_flurry", "endTimedEvent", 3);
}

typedef Flurry = FlurryIOS;

#else

class FlurryFallback
{
  static public function onStartSession(flurryKey : String)
  {
    write("On start Flurry session");
  }

  static public function onEndSession()
  {
    write("On end Flurry session");
  }

  static public function setVersionName(versionName : String)
  {
    write(["setVersionName", versionName]);
  }

  static public function setReportLocation(reportLocation : Bool)
  {
    write(["setReportLocation", reportLocation]);
  }

  static public function setLogEnabled(logEnabled : Bool)
  {
    write(["setLogEnabled", logEnabled]);
  }

  static public function setLogLevel(logLevel : Int)
  {
    write(["setLogLevel", logLevel]);
  }

  static public function setContinueSessionMillis(millis : Int)
  {
    write(["setContinueSessionMillis", millis]);
  }

  static public function setLogEvents(logEvents : Bool)
  {
    write(["setLogEvents", logEvents]);
  }

  static public function setUseHttps(useHttps : Bool)
  {
    write(["setUseHttps", useHttps]);
  }

  static public function setCaptureUncaughtExceptions(isEnabled : Bool)
  {
    write(["setCaptureUncaughtExceptions", isEnabled]);
  }

  static public function logEvent(eventId : String, ?params : Dynamic = null, ?timed : Bool = false)
  {
    write(["logEvent", eventId, params, timed]);
  }

  static public function endTimedEvent(eventId : String, ?params : Dynamic = null)
  {
    write(["endTimedEvent", eventId, params]);
  }

  static public function onError(errorId : String, message : String, errorClass : String)
  {
    write(["onError", errorId, message, errorClass]);
  }

  static public function onPageView()
  {
    write("onPageView");
  }

  static public function setAge(age : Int)
  {
    write(["setAge", age]);
  }

  static public function setGender(gender : Int)
  {
    write(["setGender", gender]);
  }

  static public function setUserId(userId : String)
  {
    write(["setUserId", userId]);
  }

  static function write(m : Dynamic)
  {
#if debug
    trace("FLURRY: " + m);
#end
  }

}

typedef Flurry = FlurryFallback;

#end
