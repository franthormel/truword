import 'dart:async';

import 'package:flutter/material.dart';

import '../models/game_state.dart';
import '../theme.dart';
import 'display_row.dart';

const _kBtnWidthFactor = .67;
const _kBtnHeightFactor = .07;

class Contents extends StatefulWidget {
  final GameState gameState;

  Contents(this.gameState);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  ///If [isReplay] is set to true initialize [Stopwatch] otherwise
  ///reset [GameState]
  void startGame({bool isReplay = false}) {
    if (isReplay) {
      widget.gameState.reset();
      Navigator.pop(context);
    } else {
      _stopwatch = Stopwatch();
    }

    _stopwatch.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopwatch.isRunning && widget.gameState.enoughTimeLeft) {
        setState(() {
          widget.gameState.reduceTime();
        });
      }

      //Stopwatch has hit the set time limit
      if (!widget.gameState.enoughTimeLeft) {
        //Stop the timer and stopwatch
        _stopwatch.stop();
        timer.cancel();

        //Display popup
        evaluateGame();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  ///Display an undismissable dialog and showing the
  ///the game evaluation
  void evaluateGame() {
    final eval = widget.gameState.evaluateAnswers;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final btnStyle = ButtonStyle(
          textStyle:
              MaterialStateProperty.all<TextStyle>(theme.textTheme.headline4!),
        );

        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text(
              widget.gameState.settings.resultsText(),
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4!.apply(
                color: theme.primaryColor,
              ),
            ),
            children: [
              Text(
                eval.percentCorrectString(),
                textAlign: TextAlign.center,
                style: theme.textTheme.headline2,
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Correct",
                  textRight: eval.correct.toString(),
                ),
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Wrong",
                  textRight: eval.wrong.toString(),
                ),
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Total",
                  textRight: eval.total.toString(),
                ),
              ),
              Divider(),
              SimpleDialogOption(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: btnStyle,
                      label: Text("REPLAY"),
                      icon: Icon(Icons.replay),
                      onPressed: () {
                        startGame(isReplay: true);
                      },
                    ),
                    TextButton.icon(
                      style: btnStyle,
                      label: Text("Home"),
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///Add the user answer to [GameState]'s list of answers
  ///and generate new [EnglishWord]
  void evaluateAnswer(bool answer) {
    widget.gameState.addAnswer(answer);

    setState(() {
      widget.gameState.resetWord();
    });
  }

  ///Display an undismissable dialog after pause
  ///button is pressed
  void pauseScreen() {
    if (widget.gameState.timeLimitPausable && _stopwatch.isRunning) {
      _stopwatch.stop();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final btnTextStyle = Theme.of(context).textTheme.headline4;

          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              children: [
                SimpleDialogOption(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      textStyle:
                          MaterialStateProperty.all<TextStyle>(btnTextStyle!),
                    ),
                    icon: Icon(Icons.play_arrow),
                    label: Text("Resume"),
                    onPressed: () {
                      if (!_stopwatch.isRunning) {
                        Navigator.pop(context);
                        _stopwatch.start();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  ///Return buttons separated by a transparent divider depending on settings
  ButtonStyle btnStyle(MediaQueryData media) {
    final btnWidth = media.size.width * _kBtnWidthFactor;
    final btnHeight = media.size.height * _kBtnHeightFactor;
    final btnTextStyle = Theme.of(context).textTheme.headline4;

    return ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(btnTextStyle!),
      minimumSize: MaterialStateProperty.all<Size>(
        Size(btnWidth, btnHeight),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final style = btnStyle(media);

    return Scaffold(
      backgroundColor: theme.accentColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: _stopwatch.isRunning ? pauseScreen : null,
          ),
        ],
        centerTitle: true,
        title: Text(widget.gameState.textRemainingSeconds),
      ),
      body: SafeArea(
        child: Padding(
          padding: PaddingManager.contents(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Is the word valid?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5!.apply(
                    color: theme.primaryColor,
                  ),
                ),
                Text(
                  widget.gameState.text,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline3!.apply(
                    color: theme.primaryColor,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      style: style,
                      onPressed: _stopwatch.isRunning
                          ? () {
                              evaluateAnswer(true);
                            }
                          : null,
                      child: Text("CORRECT"),
                    ),
                    if (media.orientation == Orientation.portrait)
                      Divider(
                        color: Colors.transparent,
                      ),
                    OutlinedButton(
                      style: style,
                      child: Text("WRONG"),
                      onPressed: _stopwatch.isRunning
                          ? () {
                              evaluateAnswer(false);
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
