package;


import flash.display.Sprite;
import flash.display.Bitmap;
import flash.filters.ColorMatrixFilter;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.text.TextField;
import flash.Lib;

import openfl.Assets;

import ru.zzzzzzerg.linden.Flurry;

class Main extends Sprite {

#if android
  private static var FLURRY_KEY = "Y8MB3385SY839THTZ9XM";
#elseif ios
  private static var FLURRY_KEY = "YNBJ64QGF9DQCZGD8Z2M";
#else
  private static var FLURRY_KEY = "";
#end

  public function new () {

    super ();

    stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);


    testFlurry(FLURRY_KEY);
  }

  function onKeyUp(event : KeyboardEvent)
  {
    switch(event.keyCode)
    {
      case Keyboard.ESCAPE:
        Lib.exit();
    }
  }

  public static function analytics(msg : String, ?params : Dynamic = null)
  {
    Flurry.logEvent(msg, params);
  }

  function testFlurry(key : String)
  {
    Flurry.onStartSession(key);
    Flurry.setCaptureUncaughtExceptions(true);

    Flurry.logEvent("TEST_LINDEN_FLURRY", null, false);
    Flurry.logEvent("TEST_LINDEN_FLURRY_PARAMS", {'test' : 1, 'value' : 'TEST'}, false);

    Flurry.logEvent("TEST_LINDEN_FLURRY_TIMED", true);
    Flurry.endTimedEvent("TEST_LINDEN_FLURRY_TIMED");

    Flurry.logEvent("TEST_LINDEN_FLURRY_PARAMS_TIMED", {'test' : 2, 'value' : 'TEST_TIMED'}, true);
    Flurry.endTimedEvent("TEST_LINDEN_FLURRY_PARAMS_TIMED");

    Flurry.logEvent("TEST_LINDEN_FLURRY_PARAMS_TIMED_2", {'test' : 3, 'value' : 'TEST_TIMED_2'}, true);
    Flurry.endTimedEvent("TEST_LINDEN_FLURRY_PARAMS_TIMED_2", {'timed' : 'end'});
  }
}

