import 'dart:developer';

import 'package:logging/logging.dart';

export 'package:logging/logging.dart';

/// The type of output to use when pretty logging is enabled.
enum PrettyOutputType {
  /// Use the `print` function to output logs.
  print,

  /// Use the `log` function to output logs.
  log,
}

/// Configures and enables pretty logging in your Dart application.
///
/// Use this function to set up colorful and customizable log output for better
/// readability.
///
/// - [enable]: Set to `true` to enable pretty logging. Default is `false`.
///
/// - [ignoredLoggers]: A list of logger names that should be ignored when
/// logging. Default is `null`.
///
/// - [type]: The type of output to use when pretty logging is enabled. Default
/// is [PrettyOutputType.log].
///
/// - [level]: The logging level to use. Default is [Level.ALL].
///
/// - [hierarchicalLogging]: Whether to use hierarchical logging. Default is
/// `true`.
///
void prettyLogging({
  bool enable = false,
  List<String>? ignoredLoggers,
  PrettyOutputType type = PrettyOutputType.log,
  Level level = Level.ALL,
  bool hierarchicalLogging = true,
}) {
  if (!enable || level == Level.OFF) {
    return;
  }

  Logger.root.level = level;

  hierarchicalLoggingEnabled = hierarchicalLogging;

  Logger.root.onRecord.listen((rec) {
    if (!enable) {
      return;
    }

    if (ignoredLoggers?.toSet().contains(rec.loggerName) ?? false) {
      return;
    }

    const endColor = '\x1b[0m'; // Reset color
    const whiteColor = '\x1b[37m'; // White
    const grayColor = '\x1b[90m'; // Gray
    const levelColor = '\x1b[93m'; // Yellow

    const finestColor = '\x1b[90m'; // gray
    const finerColor = '\x1b[36m'; // Cyan
    const fineColor = '\x1b[32m'; // Green
    const configColor = '\x1b[35m'; // Magenta
    const infoColor = '\x1b[34m'; // Blue
    const warningColor = '\x1b[33m'; // Yellow
    const severeColor = '\x1b[31m'; // Red
    const shoutColor = '\x1b[41m\x1b[97m'; // Red background, white text

    var startColor = grayColor;

    switch (rec.level) {
      case Level.FINEST:
        startColor = finestColor;

      case Level.FINER:
        startColor = finerColor;

      case Level.FINE:
        startColor = fineColor;

      case Level.CONFIG:
        startColor = configColor;

      case Level.INFO:
        startColor = infoColor;

      case Level.WARNING:
        startColor = warningColor;

      case Level.SEVERE:
        startColor = severeColor;

      case Level.SHOUT:
        startColor = shoutColor;
    }

    final fullMessage = '$whiteColor${rec.time}$endColor '
        '$levelColor${rec.level.name}$endColor '
        '$startColor${rec.message}$endColor';

    switch (type) {
      case PrettyOutputType.log:
        log(
          fullMessage,
          time: rec.time,
          name: rec.loggerName,
          sequenceNumber: rec.sequenceNumber,
          zone: rec.zone,
          level: rec.level.value,
          error: rec.error,
          stackTrace: rec.stackTrace,
        );
      case PrettyOutputType.print:
        // ignore: avoid_print
        print(fullMessage);
        return;
    }
  });
}
