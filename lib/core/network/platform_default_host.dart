import 'platform_default_host_stub.dart'
    if (dart.library.io) 'platform_default_host_io.dart' as impl;

/// The loopback host a device/emulator/browser uses to reach services
/// running on the developer's machine. Only the Android emulator needs the
/// special `10.0.2.2` alias — everything else (iOS simulator, macOS,
/// Windows, Linux desktop, and the browser via CORS) reaches the host
/// machine through plain `localhost`.
String get platformDefaultHost => impl.hostForCurrentPlatform();
