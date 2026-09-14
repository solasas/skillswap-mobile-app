/// Used on web, where `dart:io`'s `Platform` isn't available — the browser
/// always reaches the developer's machine through `localhost`.
String hostForCurrentPlatform() => 'localhost';
