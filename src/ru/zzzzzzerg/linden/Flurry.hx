package ru.zzzzzzerg.linden;

#if android

import openfl.utils.JNI;
import haxe.CallStack;

class FlurryImpl
{
  public function new ()
  {
    initJNI();
  }

  public function onStartSession(flurryKey : String)
  {
    _onStartSession(flurryKey);
    _setLogEnabled(true);
  }

  public function onEndSession()
  {
    _onEndSession();
  }

  public function setVersionName(versionName : String)
  {
    _setVersionName(versionName);
  }

  public function setReportLocation(reportLocation : Bool)
  {
    _setReportLocation(reportLocation);
  }

  public function setLogEnabled(logEnabled : Bool)
  {
    _setLogEnabled(logEnabled);
  }

  public function setLogLevel(logLevel : Int)
  {
    _setLogLevel(logLevel);
  }

  public function setContinueSessionMillis(millis : Int)
  {
    _setContinueSessionMillis(millis);
  }

  public function setLogEvents(logEvents : Bool)
  {
    _setLogEvents(logEvents);
  }

  public function setUseHttps(useHttps : Bool)
  {
    _setUseHttps(useHttps);
  }

  public function setCaptureUncaughtExceptions(isEnabled : Bool)
  {
    _setCaptureUncaughtExceptions(isEnabled);
  }

  public function logEvent(eventId : String, ?params : Dynamic = null, ?timed : Bool = false)
  {
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

  public function endTimedEvent(eventId : String, ?params : Dynamic = null)
  {
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

  public function onError(errorId : String, message : String, errorClass : String)
  {
    _onError(errorId, message, errorClass);
  }

  public function onPageView()
  {
    _onPageView();
  }

  public function setAge(age : Int)
  {
    _setAge(age);
  }

  public function setGender(gender : Int)
  {
    _setGender(gender);
  }

  public function setUserId(userId : String)
  {
    _setUserId(userId);
  }

  private static function getMethod(ns : String, name : String, sig : String, useArray : Bool = false) : Dynamic
  {
    var m = JNI.createStaticMethod(ns, name, sig, useArray);
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

    if(_setUseHttps == null)
    {
      _setUseHttps = getMethod("com/flurry/android/FlurryAgent", "setUseHttps", "(Z)V");
    }

    if(_setCaptureUncaughtExceptions == null)
    {
      _setCaptureUncaughtExceptions = getMethod("com/flurry/android/FlurryAgent", "setCaptureUncaughtExceptions", "(Z)V");
    }

    if(_logEvent == null)
    {
      _logEvent = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;)V", true);
      _logEventParams = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Ljava/util/Map;)V", true);
      _logEventParamsTimed = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Ljava/util/Map;Z)V", true);
      _logEventTimed = getMethod("com/flurry/android/FlurryAgent", "logEvent", "(Ljava/lang/String;Z)V", true);
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
  private static var _setUseHttps : Dynamic = null;
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

#else

class FlurryFallback
{
  public function new ()
  {
    setLogEnabled(true);
  }

  public function onStartSession(flurryKey : String)
  {
  }

  public function onEndSession()
  {
  }

  public function setVersionName(versionName : String)
  {
  }

  public function setReportLocation(reportLocation : Bool)
  {
  }

  public function setLogEnabled(logEnabled : Bool)
  {
  }

  public function setLogLevel(logLevel : Int)
  {
  }

  public function setContinueSessionMillis(millis : Int)
  {
  }

  public function setLogEvents(logEvents : Bool)
  {
  }

  public function setUseHttps(useHttps : Bool)
  {
  }

  public function setCaptureUncaughtExceptions(isEnabled : Bool)
  {
  }

  public function logEvent(eventId : String, ?params : Dynamic = null, ?timed : Bool = false)
  {
  }

  public function endTimedEvent(eventId : String, ?params : Dynamic = null)
  {
  }

  public function onError(errorId : String, message : String, errorClass : String)
  {
  }

  public function onPageView()
  {
  }

  public function setAge(age : Int)
  {
  }

  public function setGender(gender : Int)
  {
  }

  public function setUserId(userId : String)
  {
  }

}

typedef Flurry = FlurryFallback;

#end
