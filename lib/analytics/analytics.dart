export 'analytics_stub.dart'
    if (dart.library.html) 'analytics_html.dart'
    if (dart.library.io) 'analytics_io.dart';
