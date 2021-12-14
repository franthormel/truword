import 'enums.dart';

// TODO Tests
class GameSettings {
  final TimeLimit timeLimit;

  const GameSettings({
    required this.timeLimit,
  });

  ///Returns seconds value from [Map<TimeLimit,int>]
  int get seconds => timeLimitSeconds[timeLimit]!;

  ///Returns remaining seconds based on [seconds] that is not greater than seconds per minute
  int get secondsRemainder =>
      timeLimitSeconds[timeLimit]! % Duration.secondsPerMinute;

  ///Display Results (TimeLimit.value) as text
  ///
  ///* TimeLimit.Long = 'Results (Long)'
  ///* TimeLimit.Regular = 'Results (Regular)'
  ///* TimeLimit.Quick = 'Results (Quick)'
  String get results => "Results (${timeLimitText()})";

  ///Display [TimeLimit] in mm:ss format
  ///
  ///* 30 seconds displays 0:30
  ///* 60 seconds displays 1:00
  ///* 150 seconds displays 2:30
  String timeLimitFormat() {
    final txtSeconds = seconds;
    final txtSecondsRemainder = secondsRemainder;
    final buffer = StringBuffer();

    //Write minutes if there's any otherwise add 0
    if (txtSeconds >= Duration.secondsPerMinute) {
      buffer.write(txtSeconds ~/ Duration.secondsPerMinute);
    } else {
      buffer.write("0");
    }

    buffer.write(":");

    //Place a '0' if remaining seconds is less than 10
    if (txtSecondsRemainder < 10) {
      buffer.write("0");
    }

    buffer.write(txtSecondsRemainder);

    return buffer.toString();
  }

  ///Display [TimeLimit] value without its type
  ///
  ///* TimeLimit.Long = 'Long'
  ///* TimeLimit.Regular = 'Regular'
  ///* TimeLimit.Quick = 'Quick'
  String timeLimitText() {
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
        throw ArgumentError("Time limit is not defined!");
    }
    return value;
  }
}
