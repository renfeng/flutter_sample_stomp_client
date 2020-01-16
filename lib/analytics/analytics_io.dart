import 'package:path_provider/path_provider.dart';
import 'package:usage/usage_io.dart';

Future<Analytics> analytics({
  trackingId,
  applicationName,
  applicationVersion,
  analyticsUrl,
}) async =>
    AnalyticsIO(
      trackingId,
      applicationName,
      applicationVersion,
      analyticsUrl: analyticsUrl,
      documentDirectory: await getApplicationDocumentsDirectory(),
    );
