import 'package:usage/usage_html.dart';

Future<Analytics> analytics({
  trackingId,
  applicationName,
  applicationVersion,
  analyticsUrl,
}) async =>
    AnalyticsHtml(
      trackingId,
      applicationName,
      applicationVersion,
      analyticsUrl: analyticsUrl,
    );
