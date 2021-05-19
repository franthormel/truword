import 'dart:async';

import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import '../models/game_state.dart';
import 'display_row.dart';

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

        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text(
              widget.gameState.settings.resultsText(),
              textAlign: TextAlign.center,
            ),
            children: [
              Text(
                eval.percentageText(),
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
                      label: Text("REPLAY"),
                      icon: Icon(Icons.replay),
                      onPressed: () {
                        startGame(isReplay: true);
                      },
                    ),
                    TextButton.icon(
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
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              children: [
                SimpleDialogOption(
                  child: ElevatedButton.icon(
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

  Widget buttonOrientation() {
    final media = MediaQuery.of(context);
    final style = ButtonStyle(
      minimumSize:
          MaterialStateProperty.all<Size>(SizeManager.game(media.size)),
    );

    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttons = buttonOrientation();
    final padding = PaddingManager.contents(context);

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
          padding: padding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Is the word valid?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline6,
                ),
                Text(
                  widget.gameState.text,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline4,
                ),
                buttons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
