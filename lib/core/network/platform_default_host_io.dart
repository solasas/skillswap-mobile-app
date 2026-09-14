import 'dart:io';

/// Only the Android emulator's virtual NIC maps `10.0.2.2` to the host
/// machine's `localhost`; every other native platform (iOS simulator,
/// macOS, Windows, Linux, and physical devices reached via the emulator's
/// own loopback) uses plain `localhost`.
String hostForCurrentPlatform() => Platform.isAndroid ? '10.0.2.2' : 'localhost';
