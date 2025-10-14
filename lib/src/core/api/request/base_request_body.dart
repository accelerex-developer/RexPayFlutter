abstract class BaseRequestBody {
  final fieldDevice = 'device';
  String? _device;

  BaseRequestBody() {
    _setDeviceId();
  }

  Map<String, String?> paramsMap();

  String? get device => _device;

  _setDeviceId() {
    String deviceId = "device id string";
    // String deviceId = RexpayPlugin.platformInfo.deviceId;
    _device = deviceId;
  }
}
