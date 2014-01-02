package ru.zzzzzzerg.linden;

import android.content.Context;
import android.util.Log;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import java.util.Map;
import java.util.HashMap;

import com.flurry.android.FlurryAgent;

import org.haxe.extension.Extension;

public class Flurry extends Extension
{
  private static boolean _started;

  private static String tag = "LindenFlurry";

  public Flurry()
  {
    Log.d(tag, "Construct LindenFlurry");
    _started = false;
  }

  /**
   * Called when an activity you launched exits, giving you the requestCode
   * you started it with, the resultCode it returned, and any additional data
   * from it.
   */
  public boolean onActivityResult (int requestCode, int resultCode, Intent data)
  {
    return true;
  }


  /**
   * Called when the activity is starting.
   */
  public void onCreate(Bundle savedInstanceState)
  {
  }


  /**
   * Perform any final cleanup before an activity is destroyed.
   */
  public void onDestroy()
  {
  }


  /**
   * Called as part of the activity lifecycle when an activity is going into
   * the background, but has not (yet) been killed.
   */
  public void onPause()
  {
  }


  /**
   * Called after {@link #onStop} when the current activity is being
   * re-displayed to the user (the user has navigated back to it).
   */
  public void onRestart()
  {
  }


  /**
   * Called after {@link #onRestart}, or {@link #onPause}, for your activity
   * to start interacting with the user.
   */
  public void onResume()
  {
  }


  /**
   * Called after {@link #onCreate} &mdash; or after {@link #onRestart} when
   * the activity had been stopped, but is now again being displayed to the
   * user.
   */
  public void onStart()
  {
  }


  /**
   * Called when the activity is no longer visible to the user, because
   * another activity has been resumed and is covering this one.
   */
  public void onStop()
  {
    stop();
  }

  public static void start(String flurryKey)
  {
    if(_started)
    {
      Log.e(tag, "LindenFlurry already started");
      return ;
    }

    Log.d(tag, "Starting LindenFlurry");

    FlurryAgent.onStartSession(mainContext, flurryKey);
    FlurryAgent.setLogEvents(true);

    _started = true;

    Log.d(tag, "LindenFlurry started");
  }

  public static void stop()
  {
    if(_started)
    {
      Log.d(tag, "Stoping LindenFlurry");

      FlurryAgent.onEndSession(mainContext);
      _started = false;

      Log.d(tag, "LindenFlurry stopped");
    }
  }

}
