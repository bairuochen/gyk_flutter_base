import 'package:gyk_flutter_base/constant/gyk_constant.dart';
import 'package:mmkv/mmkv.dart';

/// 缓存工具类
class GYKCacheUtil {

  static Map<String, Map> headerPersistent = {};
  static Map<String, Map> urlPersistent = {};

  static MMKV _store(String baseUrl, int type) => MMKV.defaultMMKV();

  static void setPersistent(String baseUrl, String key, String? value, {int type = GYKConstant.allPersistent}) {
    if (type == GYKConstant.allPersistent || type == GYKConstant.headerPersistent) {
      if (!headerPersistent.containsKey(baseUrl)) {
        headerPersistent[baseUrl] = {};
      }
      var keyMap = headerPersistent[baseUrl]!;
      keyMap[key] = value;
      _store(baseUrl, GYKConstant.headerPersistent).encodeString(key, value??'');
    }
    if (type ==GYKConstant.allPersistent || type == GYKConstant.urlPersistent) {
      if (!urlPersistent.containsKey(key)) {
        urlPersistent[baseUrl] = {};
      }
      var keyMap = urlPersistent[baseUrl]!;
      keyMap[key] = value;
      _store(baseUrl, GYKConstant.urlPersistent).encodeString(key, value??'');
    }
  }

  static void setPersistentMap(String baseUrl, Map map, {int type = GYKConstant.allPersistent}) {
    if (type == GYKConstant.allPersistent || type == GYKConstant.headerPersistent) {
      if (!headerPersistent.containsKey(baseUrl)) {
        headerPersistent[baseUrl] = {};
      }
      var keyMap = headerPersistent[baseUrl]!;
      keyMap.addAll(map);
      keyMap.forEach((key, value) {
        _store(baseUrl, GYKConstant.headerPersistent).encodeString(key, value??'');
      });
    }
    if (type == GYKConstant.allPersistent || type == GYKConstant.urlPersistent) {
      if (!urlPersistent.containsKey(baseUrl)) {
        urlPersistent[baseUrl] = {};
      }
      var keyMap = urlPersistent[baseUrl]!;
      keyMap.forEach((key, value) {
        _store(baseUrl, GYKConstant.urlPersistent).encodeString(key, value??'');
      });
    }
  }

  static Map? getPersistent(String baseUrl, {int type = GYKConstant.allPersistent}) {
    Map? map;
    if (type == GYKConstant.allPersistent || type == GYKConstant.headerPersistent) {
      Map? headerMap;
      if (headerPersistent.containsKey(baseUrl)) {
        headerMap = headerPersistent[baseUrl];
      } else {
        headerMap = null;
      }
      if (headerMap != null) {
        map ??= {};
        map.addAll(headerMap);
      }
    }
    if (type == GYKConstant.allPersistent || type == GYKConstant.urlPersistent) {
      Map? urlMap;
      if (urlPersistent.containsKey(baseUrl)) {
        urlMap = urlPersistent[baseUrl];
      } else {
        urlMap = null;
      }
      if (urlMap != null) {
        map ??= {};
        map.addAll(urlMap);
      }
    }
    return map;
  }

  /// 刷新当前缓存
  static void flushPersistent(String baseUrl, {int type = GYKConstant.allPersistent}) {
    if (type == GYKConstant.allPersistent || type == GYKConstant.headerPersistent) {
      var map = _refreshAll(baseUrl, type);
      headerPersistent[baseUrl]?.clear();
      if (!headerPersistent.containsKey(baseUrl)) {
        headerPersistent[baseUrl] = {};
      }
      var keyMap = headerPersistent[baseUrl]!;
      keyMap.addAll(map);
    }
    if (type == GYKConstant.allPersistent || type == GYKConstant.urlPersistent) {
      var map = _refreshAll(baseUrl, type);
      urlPersistent[baseUrl]?.clear();
      if (!urlPersistent.containsKey(baseUrl)) {
        urlPersistent[baseUrl] = {};
      }
      var keyMap = headerPersistent[baseUrl]!;
      keyMap.addAll(map);
    }
  }

  /// 退出登录移除持久化
  static void removeAllPersistent(String baseUrl, {int type = GYKConstant.allPersistent}) {
    if (type == GYKConstant.allPersistent || type == GYKConstant.headerPersistent) {
      headerPersistent[baseUrl]?.clear();
      _store(baseUrl, GYKConstant.headerPersistent).clearAll();
    }
    if (type == GYKConstant.allPersistent || type == GYKConstant.urlPersistent) {
      urlPersistent[baseUrl]?.clear();
      _store(baseUrl, GYKConstant.urlPersistent).clearAll();
    }
  }

  static Map _refreshAll(String baseUrl, int type) {
    var mmkv = _store(baseUrl, type);
    var keys = mmkv.allKeys;
    Map map = {};
    for (var element in keys) {
      var value = mmkv.decodeString(element);
      map[element] = value;
    }
    return map;
  }
}