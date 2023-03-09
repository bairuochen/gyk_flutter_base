class HttpConfig {

  final Duration _connectTimeOut;

  Duration get connectTimeOut {
    return _connectTimeOut;
  }

  final Duration _receiveTimeOut;

  Duration get receiveTimeOut {
    return _receiveTimeOut;
  }

  final bool _retry;

  get retry {
    return _retry;
  }

  final int _retryCount;

  get retryCount {
    return _retryCount;
  }

  HttpConfig(HttpConfigBuilder httpConfigBuilder):
      _connectTimeOut = httpConfigBuilder._connectTimeout,
      _receiveTimeOut = httpConfigBuilder._receiveTimeOut,
      _retry = httpConfigBuilder._retry,
      _retryCount = httpConfigBuilder._retryCount;
}

class HttpConfigBuilder {
  /// 连接超时时间
  Duration _connectTimeout = const Duration(milliseconds: 50000);

  ///接收超时时间
  Duration _receiveTimeOut = const Duration(milliseconds: 30000);

  /// 是否重试
  bool _retry = false;

  /// 重试次数
  int _retryCount = 3;

  HttpConfigBuilder setConnectTimeout(Duration connectTimeOut) {
    _connectTimeout = connectTimeOut;
    return this;
  }

  HttpConfigBuilder setReceiveTimeOut(Duration receiveTimeOut) {
    _receiveTimeOut = receiveTimeOut;
    return this;
  }

  HttpConfigBuilder setRetry(bool retry) {
    _retry = retry;
    return this;
  }

  HttpConfigBuilder setRetryCount(int retryCount) {
    _retryCount = retryCount;
    return this;
  }

  HttpConfig build() => HttpConfig(this);
}