import 'dart:async';

import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import '../models/game_state.dart';
import 'display_row.dart';

class WordGame extends StatefulWidget {
  final GameState gameState;

  const WordGame(this.gameState);

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  ///Add the user answer to [GameState]'s list of answers
  ///and generate new [EnglishWord]
  void answer(bool answer) {
    widget.gameState.addAnswer(answer);

    setState(() {
      widget.gameState.resetWord();
    });
  }

  ///Returns a [Column] of [Button]s
  Widget buttons() {
    final media = MediaQuery.of(context);
    final style = ButtonStyle(
      minimumSize:
      MaterialStateProperty.all<Size>(SizeManager.game(media.size)),
      textStyle: MaterialStateProperty.all<TextStyle>(
          Theme
              .of(context)
              .textTheme
              .headline5!),
    );

    return Column(
      children: <Widget>[
        ElevatedButton(
          style: style,
          onPressed: stopwatch.isRunning
              ? () {
            answer(true);
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
          onPressed: stopwatch.isRunning
              ? () {
            answer(false);
          }
              : null,
        ),
      ],
    );
  }

  ///Display an non-dismissible dialog showing the evaluation
  void end() {
    final eval = widget.gameState.evaluateAnswers;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final style = ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
              theme.textTheme.headline5!),
        );

        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text(
              widget.gameState.settings.results(),
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
                      icon: Icon(Icons.replay),
                      label: Text("REPLAY"),
                      style: style,
                      onPressed: () {
                        start(isReplay: true);
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                      style: style,
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

  ///Display an undismissable dialog after pause
  ///button is pressed
  void pause() {
    if (widget.gameState.canPause && stopwatch.isRunning) {
      stopwatch.stop();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final style = ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                Theme
                    .of(context)
                    .textTheme
                    .headline5!),
          );

          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              children: [
                SimpleDialogOption(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.play_arrow),
                    style: style,
                    label: Text("Resume"),
                    onPressed: () {
                      if (!stopwatch.isRunning) {
                        Navigator.pop(context);
                        stopwatch.start();
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

  ///If [isReplay] is set to true initialize [Stopwatch] otherwise
  ///reset [GameState]
  void start({bool isReplay = false}) {
    if (isReplay) {
      widget.gameState.reset();
      Navigator.pop(context);
    } else {
      stopwatch = Stopwatch();
    }

    stopwatch.start();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (stopwatch.isRunning && widget.gameState.enoughTimeLeft) {
        setState(() {
          widget.gameState.reduceTime();
        });
      }

      //Stopwatch has hit the set time limit
      if (!widget.gameState.enoughTimeLeft) {
        //Stop the timer and stopwatch
        stopwatch.stop();
        timer.cancel();

        //Display popup
        end();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controls = buttons();
    final padding = PaddingManager.contents(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.accentColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: stopwatch.isRunning ? pause : null,
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
                  style: theme.textTheme.headline3,
                ),
                controls,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
