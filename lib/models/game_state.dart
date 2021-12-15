import 'answer.dart';
import 'english_word.dart';
import 'evaluation.dart';
import 'game_settings.dart';

class GameState {
  final GameSettings settings;
  final List<Answer> _answers = <Answer>[];

  EnglishWord _word = EnglishWord();
  int _remainingSeconds;

  GameState(
    this.settings,
  ) : _remainingSeconds = settings.seconds;

  /// Returns true if there is at least two (2) seconds left
  bool get canPause => _remainingSeconds > 1;

  bool get enoughTimeLeft => _remainingSeconds > 0;

  Evaluation get evaluateAnswers => Evaluation(_answers);

  int get remainingSeconds => _remainingSeconds;

  /// Returns the text of [EnglishWord]
  String get text => _word.text;

  /// Returns [String] for remaining seconds in timer format
  ///
  /// If remaining seconds is 0 (or less) returns empty [String]
  ///
  /// Example:
  ///* If remaining seconds is 60, return '60 s'
  ///* If remaining seconds is 0, return ''
  ///* If remaining seconds is -1, return ''
  String get textRemainingSeconds =>
      _remainingSeconds > 0 ? "$_remainingSeconds s" : "";

  void addAnswer(bool value) {
    final answer = Answer(
      word: _word,
      answer: value,
    );

    _answers.add(answer);
  }

  /// Reduce timer by one (1) second.
  void reduceTime() {
    _remainingSeconds--;
  }

  /// Reset [EnglishWord] by calling its randomize() method
  void replaceWord() {
    _word = EnglishWord();
  }

  /// Replaces [EnglishWord] with a new one, sets
  /// [remainingSeconds] back to initial value and
  /// clears user's previous answers.
  void reset() {
    replaceWord();
    _remainingSeconds = settings.seconds;
    _answers.clear();
  }
}
