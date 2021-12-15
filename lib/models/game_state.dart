import 'answer.dart';
import 'english_word.dart';
import 'evaluation.dart';
import 'game_settings.dart';

// TODO Tests
class GameState {
  final GameSettings settings;
  final List<Answer> _answers;

  EnglishWord _word;
  int _remainingSeconds;

  GameState({
    required this.settings,
  })  : _answers = <Answer>[],
        _word = EnglishWord(),
        _remainingSeconds = settings.seconds;

  ///Returns true if there is still at least 1 seconds left for the timer
  bool get enoughTimeLeft => _remainingSeconds > 0;

  ///Returns the remaining seconds
  int get remainingSeconds => _remainingSeconds;

  ///Returns the current text of [EnglishWord]
  String get text => _word.text;

  ///Returns [String] for remaining seconds in timer format
  ///
  /// If remaining seconds is 0 (or less) returns empty [String]
  ///
  ///Example:
  ///* If remaining seconds is 60, return '60 s'
  ///* If remaining seconds is 0, return ''
  ///* If remaining seconds is -1, return ''
  String get textRemainingSeconds =>
      _remainingSeconds > 0 ? "$_remainingSeconds s" : "";

  ///Returns true if there is att least 2 seconds left for timer
  bool get canPause => _remainingSeconds > 1;

  ///Returns an [Evaluation] of the [List<Answer>]
  Evaluation get evaluateAnswers => Evaluation(answers: _answers);

  ///Add user answer along with the current [EnglishWord] to list
  void addAnswer(bool answer) {
    _answers.add(
      Answer(
        word: _word,
        answer: answer,
      ),
    );
  }

  ///Decrements the remaining seconds by 1
  void reduceTime() {
    _remainingSeconds--;
  }

  ///Resets properties
  void reset() {
    replaceWord();
    _remainingSeconds = settings.seconds;
    _answers.clear();
  }

  ///Reset [EnglishWord] by calling its randomize() method
  void replaceWord() {
    _word = EnglishWord();
  }
}
