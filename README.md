# linden-flurry

OpenFL extension for Flurry

## Getting started
linden-flurry just proxies all calls from Haxe side to native side (Java or iOS) to FlurryAgent.
So if you have native Flurry experience you will be familiar with linden-flurry API.

Main difference is that Haxe side no have access to onStart, onStop and other
Android Activity callbacks. So you have to call Flurry.onStartSession as soon as possible
in your application.


##Integration

1. linden-flurry extension properly integrate FlurryAgent to your application so
you just have to include it in your project file. Also you have to specify minimum
Android SDK version. linden-flurry supports Android OS versions 10 and above.
```
<?xml version="1.0" encoding="utf-8"?>
<project>

  <meta title="LindenFlurrySamples" package="ru.zzzzzzerg.linden.flurry.samples" version="1.0.0" company="RockGate.ru" />
  <app main="Main" path="Export" file="LindenFlurrySamples" />

  <source path="Source" />

  <haxelib name="openfl" />

  <!-- include linden-flurry library -->
  <haxelib name="linden-flurry"/>

  <!-- set minimum Android SDK version -->
  <android target-sdk-version="19" minimum-sdk-version="14" if="android" />

  <assets path="Assets" rename="assets" exclude="openfl.svg" />
  <icon path="Assets/openfl.svg" />

  <certificate
    path="t.keystore"
    password="password"
    alias="t_alias"
    alias-password="password" if="android" />

</project>
```

2. Now you have to call Flurry.onStartSession(YOUR_FLURRY_API_KEY) in your application
as soon as possible. After start Flurry you can call all Flurry API methods.

3. You also can stop Flurry by calling Flurry.stop. But take in account that
native Android FlurryAgent after initialization automatically starting and
stoping himself on onStart and onStop Activity callbacks.

##Usage
After start Flurry you can report additional data.
Use ``Flurry.logEvent(eventId:String)`` to track user events that happens during
a session. Each project supports a maximum of 300 event names, and each event id,
parameter key, and parameter value must be no more than 255 characters in length.

You also can pass additional parameters with event by calling
``Flurry.logEvent(eventId:String, params:Dynamic)``. Each event can have no more
than 100 parameters:
```
Flurry.logEvent("TEST_LINDEN_FLURRY_PARAMS", {'test':1, 'value':"TEST"});
```
You can log timed event by calling ``Flurry.logEvent(eventId:String, params:Dynamic, timed:Bool)``.
Use have to use ``Flurry.endTimedEvent(eventId:String)`` or ``Flurry.endTimedEvent(eventId:String, params:Dynamic)``
to end timed event.

About all other Flurry API please refer [official Flurry documentation](https://developer.yahoo.com/flurry/docs/analytics/gettingstarted/android/).
