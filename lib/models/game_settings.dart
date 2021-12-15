import 'enums.dart';

class GameSettings {
  final TimeLimit timeLimit;

  const GameSettings(this.timeLimit);

  int get seconds => timeLimitSeconds[timeLimit]!;

  /// Example:
  ///
  /// If timeLimit is set to TimeLimit.Long which has a [seconds] value of 120
  /// this is equivalent to 2:00 if formatted. Therefore this should return 0.
  ///
  /// However, if timeLimit is set to TimeLimit.Quick has a [seconds] value of 30
  /// this is equivalent to 0:30 if formatted. Therefore this should return 30.
  int get secondsRemainder =>
      timeLimitSeconds[timeLimit]! % Duration.secondsPerMinute;

  ///* TimeLimit.Long = 'Results (Long)'
  ///* TimeLimit.Regular = 'Results (Regular)'
  ///* TimeLimit.Quick = 'Results (Quick)'
  String get results => "Results ($timeLimitText)";

  /// Display [timeLimit] in mm:ss format
  ///
  ///* 30 seconds displays 0:30
  ///* 60 seconds displays 1:00
  ///* 120 seconds displays 2:00
  String get timeLimitFormat {
    final buffer = StringBuffer();

    final txtSeconds = seconds;
    final txtSecondsRemainder = secondsRemainder;

    // Write the minutes if available otherwise add 0
    if (txtSeconds >= Duration.secondsPerMinute) {
      buffer.write(txtSeconds ~/ Duration.secondsPerMinute);
    } else {
      buffer.write("0");
    }

    buffer.write(":");

    if (txtSecondsRemainder < 10) {
      buffer.write("0");
    }

    buffer.write(txtSecondsRemainder);

    return buffer.toString();
  }

  /// Display [TimeLimit] value without its type
  ///
  ///* TimeLimit.Long = 'Long'
  ///* TimeLimit.Regular = 'Regular'
  ///* TimeLimit.Quick = 'Quick'
  String get timeLimitText {
    String value;

    switch (timeLimit) {
      case TimeLimit.long:
        value = "Long";
        break;
      case TimeLimit.regular:
        value = "Regular";
        break;
      case TimeLimit.quick:
        value = "Quick";
        break;
      default:
        throw ArgumentError(
            "Game settings time limit property is not defined!");
    }

    return value;
  }
}
