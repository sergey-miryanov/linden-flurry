package ru.zzzzzzerg.linden;

#if android

import openfl.utils.JNI;

class JNIHashMap
{
  private var _hashMap : Dynamic;

  public function new()
  {
    _hashMap = createHashMap();
  }

  public function put(key : String, value : String)
  {
    putHashMap(_hashMap, key, value);
  }

  public function getJNIObject()
  {
    return _hashMap;
  }

  private static function createHashMap() : Dynamic
  {
    initJNI();

    if(_hashMap_new == null)
    {
      trace("HashMap.ctor is null");
      return null;
    }
    else
    {
      return _hashMap_new();
    }
  }

  private static function putHashMap(map : Dynamic, key : String, value : String)
  {
    initJNI();

    if(_hashMap_put == null)
    {
      trace("HashMap.put is null");
    }
    else if(map == null)
    {
      trace("HashMap instance is null");
    }
    else
    {
      _hashMap_put(map, key, value);
    }
  }

  private static function initJNI()
  {
    if(_hashMap_new == null)
    {
      _hashMap_new = JNI.createStaticMethod("java/util/HashMap", "<init>", "()V");
    }

    if(_hashMap_put == null)
    {
      _hashMap_put = JNI.createMemberMethod("java/util/Map", "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");
    }
  }

  private static var _hashMap_new : Dynamic = null;
  private static var _hashMap_put : Dynamic = null;
}

#end
